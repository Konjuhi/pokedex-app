import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/widgets/async_value_widget.dart';

class AutocompleteSuggestions extends ConsumerWidget {
  const AutocompleteSuggestions({
    super.key,
    required this.autocompleteResults,
    required this.onSuggestionSelected,
  });

  final AsyncValue<List<String>> autocompleteResults;
  final Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: const EdgeInsets.only(top: 8),
        elevation: 4,
        child: AsyncValueWidget(
          value: autocompleteResults,
          data: (suggestions) {
            if (suggestions.isEmpty) {
              return const Center(
                child: Text('No suggestions found'),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]),
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