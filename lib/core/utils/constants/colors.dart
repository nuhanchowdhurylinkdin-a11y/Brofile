import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF0D5E3C); // Brofile brand green
  static const Color secondary = Color(0xFFFEC601); // Bright yellow for highlights and accents
  static const Color accent = Color(0xFF89A7FF); // Softer blue for a modern touch

  // Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFFFFF9A9E),
      Color(0xFFFAD0C4),
      Color(0xFFFAD0C4),
    ],
  );
  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Darker shade for better readability
  static const Color textSecondary = Color(0xFF757575); // Neutral grey for secondary text
  static const Color textWhite = Colors.white;
  static const Color textGray800 = Color(0xFF252B37);

  // Gray scale
  static const Color gray900 = Color(0xFF262626);
  static const Color gray800 = Color(0xFF3B4054);
  static const Color gray700 = Color(0xFF61677D);
  static const Color gray600 = Color(0xFF7C8BA0);
  static const Color gray100 = Color(0xFFEAEFF5);
  static const Color gray50 = Color(0xFFF5F9FE);

  // Link Colors
  static const Color link = Color(0xFF3461FD);
  static const Color linkSecondary = Color(0xFF2970FF);

  // Input / Surface Colors
  static const Color primary100 = Color(0xFFD6DFFF);
  static const Color inputFill = Color(0x0D0D5E3C); // primary at 5%
  static const Color stepInactive = Color(0x330D5E3C); // primary at 20%
  static const Color highlight = Color(0xFFFFEDB6);

  // Indicator Colors
  static const Color indicatorInactive = Color(0xFFE9EAEB);

  // Neutral scale
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFE9EAEB);
  static const Color neutral400 = Color(0xFFA4A7AE);
  static const Color neutral500 = Color(0xFF717680);
  static const Color neutral600 = Color(0xFF535862);
  static const Color neutral700 = Color(0xFF414651);

  // Home
  static const Color navActive = Color(0xFF0F6B43);
  static const Color orange = Color(0xFFFC6000);
  static const Color orangeLight = Color(0xFFFFF1EA);
  static const Color online = Color(0xFF3CCB7F);
  static const Color followBlue = Color(0xFF1570EF);
  static const Color surface = Color(0xFFF9F9F9);
  static const Color cardBorder = Color(0xFFEFEFEF);
  static const Color infoBorder = Color(0xFFF4F4F4);
  static const Color avatarNeutral = Color(0xFFE0E0E0);
  static const Color tagBlueBg = Color(0xFFB9E6FE);
  static const Color tagBlueText = Color(0xFF0086C9);
  static const Color primaryContainer = Color(0xFFA6F2D1);
  static const Color headerBackground = Color(0xCFFFFFFF); // white at 81%
  static const Color navBackground = Color(0xDBFFFFFF); // white at 86%
  static const Color albumShade = Color(0xE6000C07);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF9FAFB); // Light neutral for clean look
  static const Color backgroundDark = Color(0xFF121212); // Dark background for contrast in dark mode
  static const Color primaryBackground = Color(0xFFFFFFFF); // Pure white for primary content areas

  // Surface Colors
  static const Color surfaceLight = Color(0xFFE0E0E0); // Light grey for elevated surfaces
  static const Color surfaceDark = Color(0xFF2C2C2C); // Dark grey for elevated surfaces in dark mode

  // Container Colors
  static const Color lightContainer = Color(0xFFF1F8E9); // Soft green for a subtle highlight

  // Utility Colors
  static const Color success = Color(0xFF4CAF50); // Green for success messages
  static const Color warning = Color(0xFFFFA726); // Orange for warnings
  static const Color error = Color(0xFFF44336); // Red for error messages
  static const Color info = Color(0xFF29B6F6); // Blue for informational messages
}