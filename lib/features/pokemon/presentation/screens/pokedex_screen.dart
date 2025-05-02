import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/extensions/async_value_ui.dart';
import '../../../auth/domain/auth_controller.dart';
import '../../domain/pokemon_controller.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/empty_pokedex_animation.dart';

class PokedexScreen extends ConsumerWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      pokedexControllerProvider,
      (p, n) => n.showAlertDialogOnError(context),
    );

    final pokedexState = ref.watch(pokedexControllerProvider);
    final controller = ref.read(pokedexControllerProvider.notifier);

    Future<void> confirmLogout() async {
      final result = await showDialog<bool>(
        context: context,
        builder:
            (c) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(c).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(c).pop(true),
                  child: const Text('Yes, log out'),
                ),
              ],
            ),
      );
      if (result == true) {
        final ok = await ref.read(authControllerProvider.notifier).logout();
        if (!ok && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to logout. Please try again.'),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pokédex'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: confirmLogout),
        ],
      ),
      body: AsyncValueWidget(
        value: pokedexState,
        data: (pokemon) {
          if (pokemon.isEmpty) {
            return const EmptyPokedexAnimation();
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(16),
            buildDefaultDragHandles: false,
            proxyDecorator: (child, index, animation) {
              final scale =
                  Tween<double>(begin: 1.0, end: 1.03).animate(animation).value;
              return Transform.scale(
                scale: scale,
                child: Material(
                  elevation: 6,
                  type: MaterialType.transparency,
                  child: child,
                ),
              );
            },
            itemCount: pokemon.length,
            onReorder: (oldIndex, newIndex) {
              controller.reorderLocal(oldIndex, newIndex);
              controller.reorderPokemon(oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final p = pokemon[index];
              return Padding(
                key: ValueKey(p.id),
                padding: const EdgeInsets.only(bottom: 16),
                child: Stack(
                  children: [
                    PokemonCard(
                      pokemon: p,
                      showAddButton: false,
                      onRemoveFromPokedex: () async {
                        await controller.removePokemon(p.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${p.name} removed from your Pokédex',
                              ),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () => controller.addPokemon(p),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    Positioned(
                      top: 20,
                      right: 12,
                      child: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(
                          Icons.drag_indicator_rounded,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
