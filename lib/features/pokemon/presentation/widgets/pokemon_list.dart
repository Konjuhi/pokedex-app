import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/localization/localization.dart';
import 'package:pokedex_app/core/theme/theme.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart';
import 'package:pokedex_app/features/pokemon/domain/pokemon_controller.dart';
import 'pokemon_card.dart';

class PokemonList extends ConsumerWidget {
  const PokemonList({super.key, required this.pokemon});

  final List<Pokemon> pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokedexController = ref.watch(pokedexControllerProvider.notifier);

    return ListView.builder(
      itemCount: pokemon.length,
      itemBuilder: (context, index) {
        final inPokedex = ref
            .watch(pokedexControllerProvider)
            .when(
              data:
                  (pokedexPokemon) =>
                      pokedexPokemon.any((p) => p.id == pokemon[index].id),
              loading: () => false,
              error: (_, __) => false,
            );

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: PokemonCard(
            pokemon: pokemon[index],
            showAddButton: !inPokedex,
            onAddToPokedex:
                inPokedex
                    ? null
                    : () {
                      pokedexController.addPokemon(pokemon[index]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${pokemon[index].name} added to your Pokédex'
                                .hardcoded,
                            style: TextStyle(color: context.colors.textLight),
                          ),
                          backgroundColor: context.colors.success,
                        ),
                      );
                    },
          ),
        );
      },
    );
  }
}
