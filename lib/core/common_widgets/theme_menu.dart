import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/theme.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';

class ThemeMenu {
  static void show(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themeControllerProvider.notifier);
    final currentThemeMode = themeController.currentThemeMode;

    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<AppThemeMode>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<AppThemeMode>(
          value: AppThemeMode.light,
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                color:
                    currentThemeMode == AppThemeMode.light
                        ? context.colors.primary
                        : context.colors.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                'Light Theme'.hardcoded,
                style: TextStyle(
                  color:
                      currentThemeMode == AppThemeMode.light
                          ? context.colors.primary
                          : context.colors.textPrimary,
                  fontWeight:
                      currentThemeMode == AppThemeMode.light
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<AppThemeMode>(
          value: AppThemeMode.dark,
          child: Row(
            children: [
              Icon(
                Icons.dark_mode,
                color:
                    currentThemeMode == AppThemeMode.dark
                        ? context.colors.primary
                        : context.colors.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                'Dark Theme'.hardcoded,
                style: TextStyle(
                  color:
                      currentThemeMode == AppThemeMode.dark
                          ? context.colors.primary
                          : context.colors.textPrimary,
                  fontWeight:
                      currentThemeMode == AppThemeMode.dark
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<AppThemeMode>(
          value: AppThemeMode.system,
          child: Row(
            children: [
              Icon(
                Icons.settings_suggest,
                color:
                    currentThemeMode == AppThemeMode.system
                        ? context.colors.primary
                        : context.colors.textSecondary,
              ),
              const SizedBox(width: 10),
              Text(
                'System Theme'.hardcoded,
                style: TextStyle(
                  color:
                      currentThemeMode == AppThemeMode.system
                          ? context.colors.primary
                          : context.colors.textPrimary,
                  fontWeight:
                      currentThemeMode == AppThemeMode.system
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        themeController.setThemeMode(value);
      }
    });
  }
}
