import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/settings/settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'tokens.dart';
import 'pokemon_tokens.dart';

part 'theme_controller.g.dart';

enum AppThemeMode { light, dark, system }

@riverpod
Brightness systemBrightness(Ref ref) {
  final mediaQueryData = WidgetsBinding.instance.platformDispatcher;


  void listener() {
    ref.invalidateSelf();
  }

  mediaQueryData.onPlatformBrightnessChanged = listener;

  ref.onDispose(() {
    mediaQueryData.onPlatformBrightnessChanged = null;
  });

  return mediaQueryData.platformBrightness;
}

@riverpod
class ThemeController extends _$ThemeController {
  AppThemeMode? _currentMode;

  @override
  Future<ITokens> build() async {
    final settingsRepository = ref.watch(settingsRepositoryProvider);

    final brightness = ref.watch(systemBrightnessProvider);

    _currentMode =
        await settingsRepository.loadThemeMode() ?? AppThemeMode.system;

    switch (_currentMode!) {
      case AppThemeMode.light:
        return PokemonLightTokens();
      case AppThemeMode.dark:
        return PokemonDarkTokens();
      case AppThemeMode.system:
        return brightness == Brightness.light
            ? PokemonLightTokens()
            : PokemonDarkTokens();
    }
  }

  AppThemeMode get currentThemeMode => _currentMode ?? AppThemeMode.system;

  Future<void> setThemeMode(AppThemeMode mode) async {
    _currentMode = mode;
    final brightness = ref.read(systemBrightnessProvider);
    final settingsRepository = ref.read(settingsRepositoryProvider);

    await settingsRepository.saveThemeMode(mode);

    switch (mode) {
      case AppThemeMode.light:
        state = AsyncData(PokemonLightTokens());
      case AppThemeMode.dark:
        state = AsyncData(PokemonDarkTokens());
      case AppThemeMode.system:
        state = AsyncData(
          brightness == Brightness.light
              ? PokemonLightTokens()
              : PokemonDarkTokens(),
        );
    }
  }

  Future<void> toggleTheme() async {
    if (!state.hasValue) return;

    final currentTheme = state.value;
    if (currentTheme is PokemonLightTokens) {
      await setThemeMode(AppThemeMode.dark);
    } else {
      await setThemeMode(AppThemeMode.light);
    }
  }
}
