import 'package:pokedex_app/core/api/pokemon_api.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart';
import 'package:pokedex_app/features/pokemon/data/repositories/pokemon_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'pokemon_controller.g.dart';

@riverpod
class AutocompleteController extends _$AutocompleteController {
  @override
  FutureOr<List<String>> build() async {
    return [];
  }

  Future<void> getSuggestions(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final suggestions = await ref
          .read(pokemonApiProvider)
          .getAbilitySuggestions(query);
      state = AsyncValue.data(suggestions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void clearSuggestions() {
    state = const AsyncValue.data([]);
  }
}

@riverpod
class SearchController extends _$SearchController {
  @override
  FutureOr<List<Pokemon>> build() async {
    final savedResults =
        await ref.read(pokemonRepositoryProvider).getLastSessionResults();

    if (savedResults.isNotEmpty) {
      return savedResults;
    }

    return [];
  }

  Future<void> searchPokemon(String name) async {
    state = const AsyncValue.loading();

    try {
      final pokemon = await ref
          .read(pokemonRepositoryProvider)
          .searchPokemonByName(name);

      if (pokemon != null) {
        state = AsyncValue.data([pokemon]);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> getRandomPokemon() async {
    state = const AsyncValue.loading();

    try {
      final pokemon = await ref
          .read(pokemonRepositoryProvider)
          .getRandomPokemon(10, forceRefresh: true);
      state = AsyncValue.data(pokemon);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void clearSearch() {
    state = const AsyncValue.data([]);
  }

  Future<String?> getLastSearchQuery() async {
    return ref.read(pokemonRepositoryProvider).getLastSearchQuery();
  }
}

@riverpod
class PokedexController extends _$PokedexController {
  @override
  FutureOr<List<Pokemon>> build() async {
    return ref.read(pokemonRepositoryProvider).getUserPokemon();
  }

  void reorderLocal(int oldIndex, int newIndex) {
    final list = state.value ?? [];
    if (oldIndex < newIndex) newIndex--;
    final newList = [...list];
    final item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);
    state = AsyncValue.data(newList);
  }

  Future<void> reorderPokemon(
    int oldIndex,
    int newIndex, {
    bool adjustIndex = true,
  }) async {
    await ref
        .read(pokemonRepositoryProvider)
        .reorderPokemon(oldIndex, newIndex, adjustIndex: adjustIndex);
    ref.invalidateSelf();
  }

  Future<void> addPokemon(Pokemon pokemon) async {
    await ref.read(pokemonRepositoryProvider).addPokemonToPokedex(pokemon);
    ref.invalidateSelf();
  }

  Future<void> removePokemon(String id) async {
    await ref.read(pokemonRepositoryProvider).removePokemonFromPokedex(id);
    ref.invalidateSelf();
  }
}
