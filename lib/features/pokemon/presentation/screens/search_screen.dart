import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/autocomplete_suggestions.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/pokemon_search_bar.dart';
import 'package:pokedex_app/features/pokemon/presentation/widgets/search_results.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/extensions/async_value_ui.dart';
import '../../../auth/domain/auth_controller.dart';
import '../../domain/pokemon_controller.dart';

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
      appBar: AppBar(
        title: const Text('Pokémon Search'),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.bug_report),
          //   tooltip: 'Test Error Handling',
          //   onPressed: () => context.push('/test-errors'),
          // ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final ok =
                  await ref.read(authControllerProvider.notifier).logout();
              if (!ok && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to logout')),
                );
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
              if (showAutocomplete.value)
                AutocompleteSuggestions(
                  autocompleteResults: autocomplete,
                  onSuggestionSelected: (s) {
                    controller.text = s;
                    doSearch(s);
                  },
                ),
              gapW16,
              const Divider(),
              SearchResults(searchResults: results),
            ],
          ),
        ),
      ),
    );
  }
}
