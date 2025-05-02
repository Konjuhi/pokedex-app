import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/common_widgets/async_value_widget.dart';
import 'package:pokedex_app/core/theme/theme.dart';

class AutocompleteSuggestions extends ConsumerWidget {
  const AutocompleteSuggestions({
    super.key,
    required this.autocompleteResults,
    required this.onSuggestionSelected,
  });

  final AsyncValue<List<String>> autocompleteResults;
  final void Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(top: 4),
      elevation: 4,
      color: context.colors.surface,
      shadowColor: context.colors.cardShadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.colors.primary.withValues()),
      ),
      child: SizedBox(
        width: double.infinity,
        child: AsyncValueWidget(
          value: autocompleteResults,
          data: (suggestions) {
            if (suggestions.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'No suggestions found',
                  style: TextStyle(
                    color: context.colors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length > 5 ? 5 : suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  title: Text(
                    suggestions[index],
                    style: context.textStyles.bodyMedium,
                  ),
                  leading: Icon(
                    Icons.search,
                    size: 18,
                    color: context.colors.secondary,
                  ),
                  onTap: () => onSuggestionSelected(suggestions[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 