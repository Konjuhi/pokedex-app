import 'package:flutter/material.dart';
import 'package:pokedex_app/core/localization/string_hardcoded.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';

extension DialogExtensions on BuildContext {
  Future<bool?> showAnimatedConfirmDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
  }) async {
    return showGeneralDialog<bool>(
      context: this,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(this).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: AlertDialog(
              backgroundColor: context.colors.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(title, style: context.textStyles.headlineSmall),
              content: Text(
                content,
                style: context.textStyles.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelText ?? 'Cancel'.hardcoded,
                    style: TextStyle(color: context.colors.textSecondary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    confirmText ?? 'Yes'.hardcoded,
                    style: TextStyle(color: context.colors.primary),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 