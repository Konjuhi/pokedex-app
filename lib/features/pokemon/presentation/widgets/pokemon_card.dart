import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/pokemon.dart';

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
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  const Icon(Icons.catching_pokemon, size: 60),
                          fit: BoxFit.contain,
                        )
                        : const Icon(Icons.catching_pokemon, size: 60),
              ),
              // Pokemon details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      gapW8,
                      Text(
                        pokemon.generation,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
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
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text('Add'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          if (!showAddButton && onRemoveFromPokedex != null)
                            ElevatedButton.icon(
                              onPressed: onRemoveFromPokedex,
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              label: const Text('Remove'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
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
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                gapW8,
                Text(
                  englishEffectEntry.effect,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
