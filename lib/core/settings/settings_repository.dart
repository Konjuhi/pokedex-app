import 'package:flutter/material.dart';
import 'package:pokedex_app/core/database/database_service.dart';
import 'package:pokedex_app/core/theme/theme_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';

part 'settings_repository.g.dart';


class SettingsRepository {
  final DatabaseService _databaseService;
  final _settingsStore = stringMapStoreFactory.store(
    DatabaseService.settingsStore,
  );

  static const String themeModePrefKey = 'theme_mode';

  SettingsRepository(this._databaseService);

  Future<void> saveThemeMode(AppThemeMode mode) async {
    try {
      final db = await _databaseService.database;
      await _settingsStore.record(themeModePrefKey).put(
        db,
        {'mode': mode.index},
      );
    } catch (e) {
      debugPrint('Failed to save theme mode: $e');
    }
  }

  Future<AppThemeMode?> loadThemeMode() async {
    try {
      final db = await _databaseService.database;
      final record = await _settingsStore.record(themeModePrefKey).get(db);

      if (record != null && record['mode'] != null) {
        final index = record['mode'] as int;
        return AppThemeMode.values[index];
      }
      return null;
    } catch (e) {
      debugPrint('Failed to load theme mode: $e');
      return null;
    }
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository(
    ref.watch(databaseServiceProvider),
  );
} 