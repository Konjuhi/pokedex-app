import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/features/pokemon/data/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onAddToPokedex;
  final VoidCallback? onRemoveFromPokedex;
  final bool showAddButton;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onAddToPokedex,
    this.onRemoveFromPokedex,
    this.showAddButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final englishEffectEntry = pokemon.effectEntries.firstWhere(
      (entry) => entry.language == 'en',
      orElse:
          () =>
              pokemon.effectEntries.isNotEmpty
                  ? pokemon.effectEntries.first
                  : const EffectEntry(
                    effect: 'No description available',
                    language: 'en',
                  ),
    );

    return Card(
      elevation: 1,
      color: context.colors.cardBackground,
      shadowColor: context.colors.cardShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child:
                    pokemon.image.isNotEmpty
                        ? CachedNetworkImage(
                          imageUrl: pokemon.image,
                          placeholder:
                              (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: context.colors.primary,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Icon(
                                Icons.catching_pokemon,
                                size: 60,
                                color: context.colors.primary,
                              ),
                          fit: BoxFit.contain,
                        )
                        : Icon(
                          Icons.catching_pokemon,
                          size: 60,
                          color: context.colors.primary,
                        ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name.toUpperCase(),
                        style: context.textStyles.headlineSmall,
                      ),
                      gapW8,
                      Text(
                        pokemon.generation,
                        style: context.textStyles.labelLarge.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      gapW16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (showAddButton && onAddToPokedex != null)
                            ElevatedButton.icon(
                              onPressed: onAddToPokedex,
                              icon: Icon(
                                Icons.add,
                                color: context.colors.textLight,
                              ),
                              label: const Text('Add'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colors.success,
                                foregroundColor: context.colors.textLight,
                              ),
                            ),
                          if (!showAddButton && onRemoveFromPokedex != null)
                            ElevatedButton.icon(
                              onPressed: onRemoveFromPokedex,
                              icon: Icon(
                                Icons.delete,
                                color: context.colors.textLight,
                              ),
                              label: const Text('Remove'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colors.error,
                                foregroundColor: context.colors.textLight,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: context.textStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                gapW8,
                Text(
                  englishEffectEntry.effect,
                  style: context.textStyles.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
