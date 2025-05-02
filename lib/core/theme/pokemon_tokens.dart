import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tokens.dart';

/// Light theme color tokens for Pokemon app
class PokemonLightColorTokens implements ColorTokens {
  @override
  Color get primary => const Color(0xFFE3350D);
  
  @override
  Color get secondary => const Color(0xFF3B5BA7);
  
  @override
  Color get accent => const Color(0xFFFFCB05);
  
  @override
  Color get background => const Color(0xFFF5F5F5);
  
  @override
  Color get surface => const Color(0xFFFFFFFF);
  
  @override
  Color get textPrimary => const Color(0xFF212121);
  
  @override
  Color get textSecondary => const Color(0xFF757575);
  
  @override
  Color get textLight => const Color(0xFFFFFFFF);
  
  @override
  Color get error => const Color(0xFFB00020);
  
  @override
  Color get success => const Color(0xFF388E3C);
  
  @override
  Color get warning => const Color(0xFFFFA000);
  
  @override
  Color get cardBackground => const Color(0xFFFFFFFF);
  
  @override
  Color get cardShadow => const Color(0x1A000000);
  
  @override
  LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primary.withValues(),
      primary,
    ],
  );
}

/// Dark theme color tokens for Pokemon app
class PokemonDarkColorTokens implements ColorTokens {
  @override
  Color get primary => const Color(0xFFFF6C5C);
  
  @override
  Color get secondary => const Color(0xFF738CC3);
  
  @override
  Color get accent => const Color(0xFFFDD74C);
  
  @override
  Color get background => const Color(0xFF121212);
  
  @override
  Color get surface => const Color(0xFF1E1E1E);
  
  @override
  Color get textPrimary => const Color(0xFFEEEEEE);
  
  @override
  Color get textSecondary => const Color(0xFFBDBDBD);
  
  @override
  Color get textLight => const Color(0xFFFFFFFF);
  
  @override
  Color get error => const Color(0xFFCF6679);
  
  @override
  Color get success => const Color(0xFF81C784);
  
  @override
  Color get warning => const Color(0xFFFFD54F);
  
  @override
  Color get cardBackground => const Color(0xFF2C2C2C);
  
  @override
  Color get cardShadow => const Color(0x1A000000);
  
  @override
  LinearGradient get backgroundGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF2B2B2B),
      const Color(0xFF1E1E1E),
    ],
  );
}

/// Light theme text styles for Pokemon app
class PokemonLightTextStyleTokens implements TextStyleTokens {
  @override
  TextStyle get displayLarge => GoogleFonts.notoSans(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
    letterSpacing: -0.25,
  );
  
  @override
  TextStyle get displayMedium => GoogleFonts.notoSans(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get displaySmall => GoogleFonts.notoSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get headlineLarge => GoogleFonts.notoSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get headlineMedium => GoogleFonts.notoSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color:  Colors.white
  );
  
  @override
  TextStyle get headlineSmall => GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get bodyLarge => GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get bodyMedium => GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get bodySmall => GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get labelLarge => GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get labelMedium => GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF212121),
  );
  
  @override
  TextStyle get labelSmall => GoogleFonts.notoSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF212121),
  );
}

/// Dark theme text styles for Pokemon app
class PokemonDarkTextStyleTokens implements TextStyleTokens {
  @override
  TextStyle get displayLarge => GoogleFonts.notoSans(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
    letterSpacing: -0.25,
  );
  
  @override
  TextStyle get displayMedium => GoogleFonts.notoSans(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get displaySmall => GoogleFonts.notoSans(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get headlineLarge => GoogleFonts.notoSans(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get headlineMedium => GoogleFonts.notoSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color:  Colors.black,
  );
  
  @override
  TextStyle get headlineSmall => GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get bodyLarge => GoogleFonts.notoSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get bodyMedium => GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get bodySmall => GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get labelLarge => GoogleFonts.notoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get labelMedium => GoogleFonts.notoSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xFFEEEEEE),
  );
  
  @override
  TextStyle get labelSmall => GoogleFonts.notoSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: const Color(0xFFEEEEEE),
  );
}

/// Pokemon light theme tokens
class PokemonLightTokens implements ITokens {
  @override
  ColorTokens get colors => PokemonLightColorTokens();
  
  @override
  TextStyleTokens get textStyles => PokemonLightTextStyleTokens();
}

/// Pokemon dark theme tokens
class PokemonDarkTokens implements ITokens {
  @override
  ColorTokens get colors => PokemonDarkColorTokens();
  
  @override
  TextStyleTokens get textStyles => PokemonDarkTextStyleTokens();
} 