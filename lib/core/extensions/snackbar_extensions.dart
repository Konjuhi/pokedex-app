import 'package:flutter/material.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';

extension SnackbarExtensions on BuildContext {
  void showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textLight)),
        backgroundColor: colors.success,
      ),
    );
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textLight)),
        backgroundColor: colors.error,
      ),
    );
  }

  void showInfoSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: colors.textPrimary)),
        backgroundColor: colors.surface,
      ),
    );
  }
}
