import 'package:pokedex_app/core/api/pokemon_api.dart';
import 'package:pokedex_app/core/exceptions/app_exception.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart';


class FailingPokemonApi extends PokemonApi {
  @override
  Future<Pokemon?> getPokemonByName(String name) async {
    throw NetworkException();
  }

  @override
  Future<List<Pokemon>> getRandomPokemon(int count) async {
    throw ApiException('API down (simulated)');
  }

  @override
  Future<List<String>> getAbilitySuggestions(String query) async {
    throw ApiException('API down (simulated)');
  }
}