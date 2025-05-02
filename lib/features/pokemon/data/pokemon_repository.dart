import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import '../../../core/api/pokemon_api.dart';
import '../../../core/database/database_service.dart';
import '../../../core/models/pokemon.dart';
import '../../../core/exceptions/app_exception.dart';

part 'pokemon_repository.g.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getUserPokemon();

  Future<void> addPokemonToPokedex(Pokemon pokemon);

  Future<void> removePokemonFromPokedex(String id);

  Future<void> reorderPokemon(int oldIndex, int newIndex, {bool adjustIndex});

  Future<Pokemon?> searchPokemonByName(String name);

  Future<List<Pokemon>> getRandomPokemon(int count, {bool forceRefresh});

  Future<List<Pokemon>> getLastSessionResults();

  Future<String?> getLastSearchQuery();
}

class PokemonRepositoryImpl implements PokemonRepository {
  final DatabaseService _databaseService;
  final PokemonApi _pokemonApi;
  final _pokemonStore = stringMapStoreFactory.store(
    DatabaseService.pokemonStore,
  );
  final _cacheStore = stringMapStoreFactory.store(
    DatabaseService.searchCacheStore,
  );

  static const String randomPokemonCacheKey = 'random_pokemon';
  static const String lastSearchCacheKey = 'last_search_result';
  static const String lastSearchQueryKey = 'last_search_query';

  PokemonRepositoryImpl(this._databaseService, this._pokemonApi);

  @override
  Future<List<Pokemon>> getUserPokemon() async {
    try {
      final db = await _databaseService.database;

      final snapshots = await _pokemonStore.find(
        db,
        finder: Finder(sortOrders: [SortOrder('customOrder')]),
      );

      return snapshots.map((snapshot) {
        try {
          return Pokemon.fromJson(snapshot.value);
        } catch (e) {
          final Map<String, dynamic> data = snapshot.value;
          final List<dynamic> effectEntriesJson = data['effectEntries'] ?? [];
          final effectEntries =
              effectEntriesJson
                  .map((e) => effectEntryFromJson(e as Map<String, dynamic>))
                  .toList();

          return Pokemon(
            id: data['id'] as String? ?? '',
            name: data['name'] as String? ?? '',
            image: data['image'] as String? ?? '',
            generation: data['generation'] as String? ?? '',
            effectEntries: effectEntries,
            customOrder: data['customOrder'] as String?,
          );
        }
      }).toList();
    } catch (e) {
      throw DbException('Failed to get user Pokémon: $e');
    }
  }

  @override
  Future<void> addPokemonToPokedex(Pokemon pokemon) async {
    try {
      final db = await _databaseService.database;
      final finder = Finder(filter: Filter.equals('id', pokemon.id));
      final exists = await _pokemonStore.findFirst(db, finder: finder);

      if (exists == null) {
        await db.transaction((txn) async {
          final snapshots = await _pokemonStore.find(
            txn,
            finder: Finder(sortOrders: [SortOrder('customOrder')]),
          );
          for (final record in snapshots) {
            final recordId = record.key;
            final data = Map<String, dynamic>.from(record.value);

            final currentOrder =
                int.tryParse(data['customOrder'] as String? ?? '0') ?? 0;
            data['customOrder'] = (currentOrder + 1).toString();

            await _pokemonStore.record(recordId).update(txn, data);
          }
          final Map<String, dynamic> pokemonJson = {
            'id': pokemon.id,
            'name': pokemon.name,
            'image': pokemon.image,
            'generation': pokemon.generation,
            'customOrder': '0',
            'effectEntries':
                pokemon.effectEntries.map((e) => effectEntryToJson(e)).toList(),
          };

          await _pokemonStore.add(txn, pokemonJson);
        });
      }
    } catch (e) {
      throw DbException('Failed to add Pokémon to Pokédex: $e');
    }
  }

  @override
  Future<void> removePokemonFromPokedex(String id) async {
    try {
      final db = await _databaseService.database;
      await db.transaction((txn) async {
        final pokemonFinder = Finder(filter: Filter.equals('id', id));
        final pokemonToRemove = await _pokemonStore.findFirst(
          txn,
          finder: pokemonFinder,
        );

        if (pokemonToRemove == null) {
          return;
        }

        await _pokemonStore.delete(txn, finder: pokemonFinder);
        final deletedOrder =
            int.tryParse(
              pokemonToRemove.value['customOrder'] as String? ?? '0',
            ) ??
            0;

        final remainingPokemon = await _pokemonStore.find(
          txn,
          finder: Finder(sortOrders: [SortOrder('customOrder')]),
        );

        for (final record in remainingPokemon) {
          final recordData = Map<String, dynamic>.from(record.value);
          final currentOrder =
              int.tryParse(recordData['customOrder'] as String? ?? '0') ?? 0;

          if (currentOrder > deletedOrder) {
            recordData['customOrder'] = (currentOrder - 1).toString();
            await _pokemonStore.record(record.key).update(txn, recordData);
          }
        }
      });
    } catch (e) {
      throw DbException('Failed to remove Pokémon from Pokédex: $e');
    }
  }

  @override
  Future<void> reorderPokemon(
    int oldIndex,
    int newIndex, {
    bool adjustIndex = true,
  }) async {
    try {
      final db = await _databaseService.database;
      final pokemonList = await getUserPokemon();

      if (adjustIndex && oldIndex < newIndex) {
        newIndex -= 1;
      }

      final Pokemon item = pokemonList.removeAt(oldIndex);
      pokemonList.insert(newIndex, item);

      await db.transaction((txn) async {
        for (int i = 0; i < pokemonList.length; i++) {
          final pokemon = pokemonList[i].copyWith(customOrder: i.toString());
          final finder = Finder(filter: Filter.equals('id', pokemon.id));

          final Map<String, dynamic> pokemonJson = {
            'id': pokemon.id,
            'name': pokemon.name,
            'image': pokemon.image,
            'generation': pokemon.generation,
            'customOrder': pokemon.customOrder,
            'effectEntries':
                pokemon.effectEntries.map((e) => effectEntryToJson(e)).toList(),
          };

          await _pokemonStore.update(txn, pokemonJson, finder: finder);
        }
      });
    } catch (e) {
      throw DbException('Failed to reorder Pokémon: $e');
    }
  }

  @override
  Future<Pokemon?> searchPokemonByName(String name) async {
    try {
      await _saveLastSearchQuery(name);

      final cachedPokemon = await _getCachedPokemon(name);
      if (cachedPokemon != null) {
        return cachedPokemon;
      }
      final pokemon = await _pokemonApi.getPokemonByName(name);
      if (pokemon != null) {
        await _cachePokemon(pokemon);
      }

      return pokemon;
    } catch (e) {
      throw ApiException('Failed to search for Pokémon "$name": $e');
    }
  }

  @override
  Future<List<Pokemon>> getRandomPokemon(
    int count, {
    bool forceRefresh = false,
  }) async {
    try {
      if (forceRefresh) {
        final pokemon = await _pokemonApi.getRandomPokemon(count);

        for (final p in pokemon) {
          await _cachePokemon(p);
        }

        await _cacheRandomPokemon(pokemon);

        return pokemon;
      }

      final cachedPokemon = await _getCachedRandomPokemon();
      if (cachedPokemon.isNotEmpty) {
        return cachedPokemon;
      }

      final pokemon = await _pokemonApi.getRandomPokemon(count);

      for (final p in pokemon) {
        await _cachePokemon(p);
      }

      await _cacheRandomPokemon(pokemon);

      return pokemon;
    } catch (e) {
      if (e is AppException) {
        rethrow;
      } else {
        throw ApiException('Failed to get random Pokémon: $e');
      }
    }
  }

  @override
  Future<List<Pokemon>> getLastSessionResults() async {
    try {
      final randomPokemon = await _getCachedRandomPokemon();
      if (randomPokemon.isNotEmpty) {
        return randomPokemon;
      }
      return [];
    } catch (e) {
      throw DbException('Failed to get last session results: $e');
    }
  }

  @override
  Future<String?> getLastSearchQuery() async {
    try {
      final db = await _databaseService.database;
      final record = await _cacheStore.record(lastSearchQueryKey).get(db);

      if (record != null && record['query'] != null) {
        final query = record['query'] as String;

        return query;
      }

      return null;
    } catch (e) {
      throw DbException('Failed to get last search query: $e');
    }
  }

  Future<void> _saveLastSearchQuery(String query) async {
    try {
      final db = await _databaseService.database;
      await _cacheStore.record(lastSearchQueryKey).put(db, {
        'query': query,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw DbException('Failed to save last search query: $e');
    }
  }

  Future<void> _cachePokemon(Pokemon pokemon) async {
    try {
      final db = await _databaseService.database;

      final key = 'pokemon_${pokemon.name}';
      final Map<String, dynamic> pokemonJson = {
        'id': pokemon.id,
        'name': pokemon.name,
        'image': pokemon.image,
        'generation': pokemon.generation,
        'effectEntries':
            pokemon.effectEntries.map((e) => effectEntryToJson(e)).toList(),
      };

      await _cacheStore.record(key).put(db, pokemonJson);
    } catch (e) {
      throw DbException('Failed to cache Pokémon: $e');
    }
  }

  Future<Pokemon?> _getCachedPokemon(String name) async {
    try {
      final db = await _databaseService.database;

      final key = 'pokemon_$name';
      final record = await _cacheStore.record(key).get(db);

      if (record != null) {
        try {
          return Pokemon.fromJson(record);
        } catch (e) {
          final Map<String, dynamic> data = record;
          final List<dynamic> effectEntriesJson = data['effectEntries'] ?? [];
          final effectEntries =
              effectEntriesJson
                  .map((e) => effectEntryFromJson(e as Map<String, dynamic>))
                  .toList();

          return Pokemon(
            id: data['id'] as String? ?? '',
            name: data['name'] as String? ?? '',
            image: data['image'] as String? ?? '',
            generation: data['generation'] as String? ?? '',
            effectEntries: effectEntries,
          );
        }
      }

      return null;
    } catch (e) {
      throw DbException('Failed to get cached Pokémon: $e');
    }
  }

  Future<void> _cacheRandomPokemon(List<Pokemon> pokemon) async {
    try {
      final db = await _databaseService.database;

      final List<Map<String, dynamic>> pokemonJsonList =
          pokemon
              .map(
                (p) => {
                  'id': p.id,
                  'name': p.name,
                  'image': p.image,
                  'generation': p.generation,
                  'effectEntries':
                      p.effectEntries.map((e) => effectEntryToJson(e)).toList(),
                },
              )
              .toList();

      await _cacheStore.record(randomPokemonCacheKey).put(db, {
        'pokemon': pokemonJsonList,
      });
    } catch (e) {
      throw DbException('Failed to cache random Pokémon: $e');
    }
  }

  Future<List<Pokemon>> _getCachedRandomPokemon() async {
    try {
      final db = await _databaseService.database;

      final record = await _cacheStore.record(randomPokemonCacheKey).get(db);

      if (record != null && record['pokemon'] != null) {
        final List<dynamic> pokemonData = record['pokemon'] as List<dynamic>;

        return pokemonData.map((data) {
          try {
            return Pokemon.fromJson(data as Map<String, dynamic>);
          } catch (e) {
            final Map<String, dynamic> pokemonMap =
                data as Map<String, dynamic>;
            final List<dynamic> effectEntriesJson =
                pokemonMap['effectEntries'] ?? [];
            final effectEntries =
                effectEntriesJson
                    .map((e) => effectEntryFromJson(e as Map<String, dynamic>))
                    .toList();

            return Pokemon(
              id: pokemonMap['id'] as String? ?? '',
              name: pokemonMap['name'] as String? ?? '',
              image: pokemonMap['image'] as String? ?? '',
              generation: pokemonMap['generation'] as String? ?? '',
              effectEntries: effectEntries,
            );
          }
        }).toList();
      }
      return [];
    } catch (e) {
      throw DbException('Failed to get cached random Pokémon: $e');
    }
  }
}

@riverpod
PokemonRepository pokemonRepository(Ref ref) {
  return PokemonRepositoryImpl(
    ref.watch(databaseServiceProvider),
    ref.watch(pokemonApiProvider),
  );
}
