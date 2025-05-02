import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex_app/core/constants/app_sizes.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset(
                'assets/animations/pokemon_splash.json',
                frameRate: FrameRate.max,
                repeat: true,
                onLoaded: (composition) {},
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.catching_pokemon,
                    size: 100,
                    color: context.colors.textLight,
                  );
                },
              ),
            ),
            gapH16,
            Text(
              'Pokédex'.hardcoded,
              style: context.textStyles.displaySmall.copyWith(
                color: context.colors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
