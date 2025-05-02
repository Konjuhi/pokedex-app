import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';

class PokemonSearchBar extends HookConsumerWidget {
  const PokemonSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.onSurprise,
    required this.showAutocomplete,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onSubmit;
  final VoidCallback onSurprise;
  final ValueNotifier<bool> showAutocomplete;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animCtrl = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    final scale = useAnimation(
      Tween<double>(begin: 1, end: 1.25).animate(
        CurvedAnimation(parent: animCtrl, curve: Curves.elasticOut),
      ),
    );

    final rotation = useAnimation(
      Tween<double>(begin: 0, end: 0.15).animate(
        CurvedAnimation(parent: animCtrl, curve: Curves.elasticOut),
      ),
    );

    void play() {
      animCtrl
        ..reset()
        ..forward().then((_) => animCtrl.reverse());
    }

    final hasText = useListenableSelector(
      controller,
          () => controller.text.isNotEmpty,
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: TextInputAction.search,
            onChanged: onChanged,
            onSubmitted: onSubmit,
            decoration: InputDecoration(
              hintText: 'Search by name...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: AnimatedOpacity(
                opacity: hasText ? 1 : 0,
                duration: const Duration(milliseconds: 150),
                child: hasText
                    ? IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                    showAutocomplete.value = false;
                  },
                )
                    : const SizedBox.shrink(),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        gapW12,
        Transform.rotate(
          angle: rotation,
          child: Transform.scale(
            scale: scale,
            child: IconButton(
              tooltip: 'Surprise me!',
              iconSize: 32,
              icon: const Icon(Icons.auto_awesome, color: Colors.amber),
              onPressed: () {
                play();
                onSurprise();
              },
            ),
          ),
        ),
      ],
    );
  }
}
