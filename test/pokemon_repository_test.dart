import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/core/api/pokemon_api.dart';
import 'package:pokedex_app/core/database/database_service.dart';
import 'package:pokedex_app/core/models/pokemon.dart';
import 'package:pokedex_app/features/pokemon/data/pokemon_repository.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  late DatabaseService databaseService;
  late PokemonApi pokemonApi;
  late PokemonRepository repository;
  late Database memoryDatabase;

  final samplePokemon = Pokemon(
    id: '1',
    name: 'blaze',
    image: 'https://example.com/charizard.png',
    generation: 'Generation 1',
    effectEntries: [
      const EffectEntry(
        effect: 'Powers up Fire-type moves when HP is low.',
        language: 'en',
      ),
    ],
  );

  setUp(() async {
    final factory = databaseFactoryMemory;
    memoryDatabase = await factory.openDatabase('test.db');

    databaseService = _MockDatabaseService(memoryDatabase);

    pokemonApi = _MockPokemonApi();

    repository = PokemonRepositoryImpl(databaseService, pokemonApi);
  });

  test('Add Pokemon to Pokedex, get and remove Pokemon', () async {
    await repository.addPokemonToPokedex(samplePokemon);

    final pokedexList = await repository.getUserPokemon();

    expect(pokedexList.length, 1);
    expect(pokedexList[0].name, 'blaze');
    expect(pokedexList[0].customOrder, '0');

    await repository.removePokemonFromPokedex('1');

    final updatedList = await repository.getUserPokemon();
    expect(updatedList.length, 0);
  });

  test('Reorder Pokemon in Pokedex', () async {
    final pokemon1 = samplePokemon;
    final pokemon2 = samplePokemon.copyWith(id: '2', name: 'solar-power');
    final pokemon3 = samplePokemon.copyWith(id: '3', name: 'overgrow');

    await repository.addPokemonToPokedex(pokemon1);
    await repository.addPokemonToPokedex(pokemon2);
    await repository.addPokemonToPokedex(pokemon3);

    await repository.reorderPokemon(0, 2);

    final reorderedList = await repository.getUserPokemon();
    expect(reorderedList.length, 3);
    expect(reorderedList[0].id, '2');
    expect(reorderedList[1].id, '3');
    expect(reorderedList[2].id, '1');
  });
}

class _MockDatabaseService extends DatabaseService {
  final Database _database;

  _MockDatabaseService(this._database);

  @override
  Future<Database> get database async => _database;
}

class _MockPokemonApi extends PokemonApi {
  @override
  Future<Pokemon?> getPokemonByName(String name) async {
    if (name == 'charizard') {
      return Pokemon(
        id: '6',
        name: 'charizard',
        image: 'https://example.com/charizard.png',
        generation: 'Generation 1',
        effectEntries: [
          const EffectEntry(
            effect: 'A description of Charizard',
            language: 'en',
          ),
        ],
      );
    }
    return null;
  }

  @override
  Future<List<Pokemon>> getRandomPokemon(int count) async {
    return List.generate(
      count,
      (index) => Pokemon(
        id: (index + 1).toString(),
        name: 'random-pokemon-${index + 1}',
        image: 'https://example.com/pokemon-${index + 1}.png',
        generation: 'Generation ${(index % 8) + 1}',
        effectEntries: [
          EffectEntry(
            effect: 'Description for random Pokemon ${index + 1}',
            language: 'en',
          ),
        ],
      ),
    );
  }
}
