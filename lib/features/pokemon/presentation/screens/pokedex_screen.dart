import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/common_widgets/async_value_widget.dart';
import 'package:pokedex_app/core/common_widgets/theme_menu.dart';
import 'package:pokedex_app/core/extensions/extensions.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/theme.dart';
import 'package:pokedex_app/features/auth/domain/auth_controller.dart';
import 'package:pokedex_app/features/pokemon/domain/pokemon_controller.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/empty_pokedex_animation.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/pokemon_card.dart';

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
    final themeController = ref.watch(themeControllerProvider.notifier);
    final tokensAsyncValue = ref.watch(themeControllerProvider);
    final isDarkMode = tokensAsyncValue.maybeWhen(
      data: (tokens) => tokens is PokemonDarkTokens,
      orElse: () => false,
    );
    final currentThemeMode = themeController.currentThemeMode;

    void showThemeMenu() {
      ThemeMenu.show(context, ref);
    }

    Future<void> confirmLogout() async {
      final result = await context.showAnimatedConfirmDialog(
        title: 'Logout'.hardcoded,
        content: 'Are you sure you want to log out?'.hardcoded,
        confirmText: 'Yes, log out'.hardcoded,
      );

      if (result == true) {
        final ok = await ref.read(authControllerProvider.notifier).logout();
        if (!ok && context.mounted) {
          context.showErrorSnackbar(
            'Failed to logout. Please try again.'.hardcoded,
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'My Pokédex'.hardcoded,
          style: context.textStyles.headlineMedium.copyWith(
            // color: context.colors.textLight,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              currentThemeMode == AppThemeMode.system
                  ? Icons.brightness_auto
                  : isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: context.colors.background,
            ),
            tooltip: 'Theme settings'.hardcoded,
            onPressed: showThemeMenu,
          ),
          IconButton(
            icon: Icon(Icons.logout, color: context.colors.background),
            onPressed: confirmLogout,
          ),
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
                  shadowColor: context.colors.cardShadow,
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
                                '${p.name} removed from your Pokédex'.hardcoded,
                                style: TextStyle(
                                  color: context.colors.textLight,
                                ),
                              ),
                              backgroundColor: context.colors.error,
                              action: SnackBarAction(
                                label: 'Undo'.hardcoded,
                                onPressed: () => controller.addPokemon(p),
                                textColor: context.colors.textLight,
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
                        child: Icon(
                          Icons.drag_indicator_rounded,
                          color: context.colors.textSecondary,
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
