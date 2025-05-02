import 'package:flutter/material.dart';
import 'tokens.dart';

/// An InheritedWidget that provides access to design tokens throughout the app
class TokensProvider extends InheritedWidget {
  const TokensProvider({super.key, required this.tokens, required super.child});

  final ITokens tokens;

  @override
  bool updateShouldNotify(TokensProvider oldWidget) {
    return oldWidget.tokens != tokens;
  }

  /// Get the tokens from the context
  static ITokens of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<TokensProvider>();
    if (provider == null) {
      throw FlutterError(
        'TokensProvider not found in context. '
        'Make sure to wrap your app with TokensProvider.',
      );
    }
    return provider.tokens;
  }
}

/// Extension on BuildContext to easily access tokens
extension TokensExtension on BuildContext {
  ITokens get tokens => TokensProvider.of(this);

  ColorTokens get colors => tokens.colors;

  TextStyleTokens get textStyles => tokens.textStyles;
}
