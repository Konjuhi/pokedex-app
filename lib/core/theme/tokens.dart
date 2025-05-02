import 'package:flutter/material.dart';

/// Abstract interface defining color tokens
abstract class ColorTokens {
  Color get primary;
  Color get secondary;
  Color get accent;
  Color get background;
  Color get surface;
  
  Color get textPrimary;
  Color get textSecondary;
  Color get textLight;
  
  Color get error;
  Color get success;
  Color get warning;
  
  Color get cardBackground;
  Color get cardShadow;
  
  LinearGradient get backgroundGradient;
}

/// Abstract interface defining text style tokens
abstract class TextStyleTokens {
  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;
  
  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;
  
  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;
  
  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;
}

/// Abstract interface for all tokens
abstract class ITokens {
  ColorTokens get colors;
  TextStyleTokens get textStyles;
} 