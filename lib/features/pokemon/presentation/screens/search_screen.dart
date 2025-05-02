import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/common_widgets/theme_menu.dart';
import 'package:pokedex_app/core/constants/app_sizes.dart';
import 'package:pokedex_app/core/extensions/async_value_ui.dart';
import 'package:pokedex_app/core/extensions/dialog_extensions.dart';
import 'package:pokedex_app/core/extensions/snackbar_extensions.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/pokemon_tokens.dart';
import 'package:pokedex_app/core/theme/theme_controller.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';
import 'package:pokedex_app/features/auth/domain/auth_controller.dart';
import 'package:pokedex_app/features/pokemon/domain/pokemon_controller.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/autocomplete_suggestions.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/pokemon_search_bar.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/search_results.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      searchControllerProvider,
      (p, n) => n.showAlertDialogOnError(context),
    );
    ref.listen<AsyncValue>(
      autocompleteControllerProvider,
      (p, n) => n.showAlertDialogOnError(context),
    );

    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final results = ref.watch(searchControllerProvider);
    final autocomplete = ref.watch(autocompleteControllerProvider);
    final showAutocomplete = useState(false);
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

    void doSearch(String q) {
      if (q.isEmpty) return;
      ref.read(searchControllerProvider.notifier).searchPokemon(q);
      ref.read(autocompleteControllerProvider.notifier).clearSuggestions();
      showAutocomplete.value = false;
      FocusScope.of(context).unfocus();
    }

    void surprise() {
      ref.read(searchControllerProvider.notifier).getRandomPokemon();
      ref.read(autocompleteControllerProvider.notifier).clearSuggestions();
      showAutocomplete.value = false;
      controller.clear();
      FocusScope.of(context).unfocus();
    }

    void changed(String t) {
      if (t.isEmpty) {
        ref.read(autocompleteControllerProvider.notifier).clearSuggestions();
        showAutocomplete.value = false;
      } else {
        ref.read(autocompleteControllerProvider.notifier).getSuggestions(t);
        showAutocomplete.value = true;
      }
    }

    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: Text(
          'Pokémon Search'.hardcoded,
          style: context.textStyles.headlineMedium.copyWith(
          //  color: context.colors.textLight,
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
            onPressed: () async {
              final result = await context.showAnimatedConfirmDialog(
                title: 'Logout'.hardcoded,
                content: 'Are you sure you want to log out?'.hardcoded,
                confirmText: 'Yes, log out'.hardcoded,
              );

              if (result == true) {
                final ok =
                    await ref.read(authControllerProvider.notifier).logout();
                if (!ok && context.mounted) {
                  context.showErrorSnackbar(
                    'Failed to logout. Please try again.'.hardcoded,
                  );
                }
              }
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
          showAutocomplete.value = false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              PokemonSearchBar(
                controller: controller,
                focusNode: focusNode,
                onSubmit: doSearch,
                onSurprise: surprise,
                showAutocomplete: showAutocomplete,
                onChanged: changed,
              ),
              gapH8,
              if (showAutocomplete.value)
                AutocompleteSuggestions(
                  autocompleteResults: autocomplete,
                  onSuggestionSelected: (s) {
                    controller.text = s;
                    doSearch(s);
                  },
                ),
              gapW16,
              SearchResults(searchResults: results),
            ],
          ),
        ),
      ),
    );
  }
}
