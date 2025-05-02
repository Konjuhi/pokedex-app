import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/localization/localization.dart';
import 'package:pokedex_app/core/theme/theme.dart';

class EmptySearchAnimation extends StatelessWidget {
  const EmptySearchAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAnimation(context),
          const SizedBox(height: 20),
          Text(
            'No search results'.hardcoded,
            style: context.textStyles.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Try searching for a different Pokémon ability or use the "Surprise me" button'
                  .hardcoded,
              textAlign: TextAlign.center,
              style: context.textStyles.bodyMedium.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimation(BuildContext context) {
    try {
      return Lottie.asset(
        'assets/animations/magnify_search.json',
        width: 200,
        height: 200,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackAnimation(context);
        },
      );
    } catch (e) {
      return _buildFallbackAnimation(context);
    }
  }

  Widget _buildFallbackAnimation(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: context.colors.surface,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.search, size: 80, color: context.colors.primary),
      ),
    );
  }
}
