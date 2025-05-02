import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_controller.dart';
import 'core/theme/tokens_provider.dart';
import 'core/theme/pokemon_tokens.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final tokensAsyncValue = ref.watch(themeControllerProvider);
    return tokensAsyncValue.when(
      data: (tokens) => TokensProvider(
        tokens: tokens,
        child: Builder(
          builder: (context) => MaterialApp.router(
            title: 'Pokédex App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: context.colors.primary,
                onPrimary: context.colors.textLight,
                secondary: context.colors.secondary,
                onSecondary: context.colors.textLight,
                error: context.colors.error,
                onError: context.colors.textLight,
                surface: context.colors.surface,
                onSurface: context.colors.textPrimary,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.textLight,
              ),
              textTheme: TextTheme(
                displayLarge: context.textStyles.displayLarge,
                displayMedium: context.textStyles.displayMedium,
                displaySmall: context.textStyles.displaySmall,
                headlineLarge: context.textStyles.headlineLarge,
                headlineMedium: context.textStyles.headlineMedium,
                headlineSmall: context.textStyles.headlineSmall,
                bodyLarge: context.textStyles.bodyLarge,
                bodyMedium: context.textStyles.bodyMedium,
                bodySmall: context.textStyles.bodySmall,
                labelLarge: context.textStyles.labelLarge,
                labelMedium: context.textStyles.labelMedium,
                labelSmall: context.textStyles.labelSmall,
              ),
              useMaterial3: true,
            ),
            routerConfig: router,
          ),
        ),
      ),
      loading: () => MaterialApp(
        home: Scaffold(
          backgroundColor: PokemonLightTokens().colors.background,
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, stack) => MaterialApp(
        home: Scaffold(
          backgroundColor: PokemonLightTokens().colors.background,
          body: Center(
            child: Text(
              'Failed to load theme: $error',
              style: TextStyle(
                color: PokemonLightTokens().colors.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}