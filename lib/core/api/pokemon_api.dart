import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../exceptions/app_exception.dart';
import '../models/pokemon.dart';

part 'pokemon_api.g.dart';

class PokemonApi {
  final Dio _dio;
  final Random _random = Random();

  PokemonApi({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  Exception mapDioOrSocketToAppException(
    Object error, [
    String fallbackMessage = 'Something went wrong',
  ]) {
    if (error is DioException) {
      if (error.error is SocketException ||
          error.type == DioExceptionType.unknown) {
        return NetworkException();
      }

      final code = error.response?.statusCode;
      final message =
          code == 404
              ? 'Pokémon ability not found'
              : 'API error: ${error.message}';

      return ApiException(message);
    } else if (error is SocketException) {
      return NetworkException();
    } else if (error is AppException) {
      return error;
    } else {
      return ApiException('$fallbackMessage: $error');
    }
  }

  Future<List<String>> getAbilitySuggestions(String query) async {
    try {
      if (query.isEmpty) {
        return [
          'blaze',
          'overgrow',
          'torrent',
          'adaptability',
          'intimidate',
          'static',
          'sturdy',
          'chlorophyll',
          'speed-boost',
          'levitate',
        ];
      }

      final response = await _dio.get('ability?limit=20');
      if (response.statusCode == 200) {
        final results = response.data['results'] as List<dynamic>;

        final suggestions =
            results
                .where(
                  (result) =>
                      (result['name'] as String).contains(query.toLowerCase()),
                )
                .map<String>((result) => result['name'] as String)
                .toList();

        return suggestions;
      }

      throw ApiException(
        'Failed to get suggestions: Unexpected response code ${response.statusCode}',
      );
    } catch (e) {
      return ['blaze', 'overgrow', 'torrent', 'adaptability', 'intimidate'];
    }
  }

  Future<Pokemon?> getPokemonByName(String name) async {
    try {
      final response = await _dio.get('ability/${name.toLowerCase()}');

      if (response.statusCode == 200) {
        final data = response.data;

        final String generationUrl = data['generation']['url'];
        final generationName =
            generationUrl.split('/').where((part) => part.isNotEmpty).last;
        final String generation =
            'Generation ${generationName.replaceAll(RegExp(r'[^0-9]'), '')}';

        final List<dynamic> effectsData = data['effect_entries'] ?? [];
        final effectEntries =
            effectsData.map((effect) {
              return EffectEntry(
                effect: effect['effect'] ?? '',
                language: effect['language']['name'] ?? '',
              );
            }).toList();

        String imageUrl = '';
        if (data['pokemon'] != null && data['pokemon'].isNotEmpty) {
          final pokemonName = data['pokemon'][0]['pokemon']['name'];
          final pokemonResponse = await _dio.get('pokemon/$pokemonName');
          if (pokemonResponse.statusCode == 200) {
            imageUrl =
                pokemonResponse
                    .data['sprites']['other']['official-artwork']['front_default'] ??
                '';
          }
        }

        return Pokemon(
          id: data['id'].toString(),
          name: data['name'],
          image: imageUrl,
          generation: generation,
          effectEntries: effectEntries,
        );
      }

      throw ApiException(
        'Failed to get Pokémon data for "$name": Status code ${response.statusCode}',
      );
    } catch (e) {
      throw mapDioOrSocketToAppException(e, 'Failed to get Pokémon data');
    }
  }

  Future<List<Pokemon>> getRandomPokemon(int count) async {
    try {
      final countResponse = await _dio.get('ability?limit=1');
      final int total = countResponse.data['count'];

      final List<int> randomIds = [];
      while (randomIds.length < count) {
        final id = _random.nextInt(total) + 1;
        if (!randomIds.contains(id)) {
          randomIds.add(id);
        }
      }

      final List<Pokemon> pokemon = [];
      for (final id in randomIds) {
        try {
          final response = await _dio.get('ability/$id');

          if (response.statusCode == 200) {
            final data = response.data;

            final String generationUrl = data['generation']['url'];
            final generationName =
                generationUrl.split('/').where((part) => part.isNotEmpty).last;
            final String generation =
                'Generation ${generationName.replaceAll(RegExp(r'[^0-9]'), '')}';

            final List<dynamic> effectsData = data['effect_entries'] ?? [];
            final effectEntries =
                effectsData.map((effect) {
                  return EffectEntry(
                    effect: effect['effect'] ?? '',
                    language: effect['language']['name'] ?? '',
                  );
                }).toList();

            String imageUrl = '';
            if (data['pokemon'] != null && data['pokemon'].isNotEmpty) {
              final pokemonName = data['pokemon'][0]['pokemon']['name'];
              final pokemonResponse = await _dio.get('pokemon/$pokemonName');
              if (pokemonResponse.statusCode == 200) {
                imageUrl =
                    pokemonResponse
                        .data['sprites']['other']['official-artwork']['front_default'] ??
                    '';
              }
            }

            pokemon.add(
              Pokemon(
                id: data['id'].toString(),
                name: data['name'],
                image: imageUrl,
                generation: generation,
                effectEntries: effectEntries,
              ),
            );
          }
        } catch (e) {
          continue;
        }
      }

      if (pokemon.isEmpty) {
        throw ApiException('Failed to fetch any random Pokémon');
      }
      return pokemon;
    } catch (e) {
      throw mapDioOrSocketToAppException(e, 'Failed to get random Pokémon');
    }
  }
}

@riverpod
PokemonApi pokemonApi(Ref ref) {
  return PokemonApi();
}
