import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/common_widgets/async_value_widget.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart' show Pokemon;
import 'empty_search_animation.dart';
import 'pokemon_list.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key, required this.searchResults});

  final AsyncValue<List<Pokemon>> searchResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: AsyncValueWidget(
        value: searchResults,
        data: (pokemon) {
          if (pokemon.isEmpty) {
            return SingleChildScrollView(child: const EmptySearchAnimation());
          }
          return PokemonList(pokemon: pokemon);
        },
      ),
    );
  }
}
