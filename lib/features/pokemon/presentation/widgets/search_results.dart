import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/models/pokemon.dart';
import '../../../../core/widgets/async_value_widget.dart';
import 'empty_search_animation.dart';
import 'pokemon_list.dart';

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key, required this.searchResults});

  final AsyncValue<List<Pokemon>> searchResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: AsyncValueWidget(
          value: searchResults,
          data: (pokemon) {
            if (pokemon.isEmpty) {
              return const EmptySearchAnimation();
            }
            return PokemonList(pokemon: pokemon);
          },
        ),
      ),
    );
  }
}
