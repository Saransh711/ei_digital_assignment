/// Application theme configuration matching the guest book design
/// This theme ensures consistent visual styling throughout the application
/// based on the color palette and typography extracted from screenshots using Montserrat font.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color_constants.dart';
import '../constants/ui_constants.dart';

/// Application theme data for consistent styling
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme configuration matching screenshot design
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnDark,
      secondary: AppColors.accent,
      onSecondary: AppColors.textOnDark,
      error: AppColors.error,
      onError: AppColors.textOnDark,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
      shadow: AppColors.shadow,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // ========== TYPOGRAPHY ==========
      fontFamily: GoogleFonts.montserrat().fontFamily,

      textTheme: GoogleFonts.montserratTextTheme().copyWith(
        // Display styles with Montserrat
        displayLarge: GoogleFonts.montserrat(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          height: 1.2,
          color: AppColors.textPrimary,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          height: 1.3,
          color: AppColors.textPrimary,
        ),
        displaySmall: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.4,
          color: AppColors.textPrimary,
        ),

        // Headline styles with Montserrat
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
          height: 1.4,
          color: AppColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.4,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.4,
          color: AppColors.textPrimary,
        ),

        // Body styles with Montserrat
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.5,
          color: AppColors.textPrimary,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.5,
          color: AppColors.textSecondary,
        ),

        // Label styles with Montserrat
        labelLarge: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.4,
          color: AppColors.textPrimary,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.4,
          color: AppColors.textSecondary,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.4,
          color: AppColors.textTertiary,
        ),
      ),

      // ========== COMPONENT THEMES ==========

      /// AppBar theme matching screenshot design
      appBarTheme: AppBarTheme(
        elevation: UIConstants.elevationMedium,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          letterSpacing: 0.15,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: UIConstants.iconMedium,
        ),
        centerTitle: false,
        toolbarHeight: UIConstants.appBarHeight,
      ),

      /// Card theme for consistent card styling
      cardTheme: CardThemeData(
        elevation: UIConstants.cardElevation,
        color: AppColors.surface,
        shadowColor: AppColors.shadow,
        margin: EdgeInsets.all(UIConstants.cardMargin),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusL),
        ),
      ),

      /// List tile theme for guest list items
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: UIConstants.spacingM,
          vertical: UIConstants.spacingS,
        ),
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
        subtitleTextStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        iconColor: AppColors.textSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(UIConstants.radiusM)),
        ),
      ),

      /// Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: UIConstants.elevationMedium,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnDark,
          minimumSize: const Size(
            UIConstants.buttonMinWidth,
            UIConstants.buttonHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.spacingL,
            vertical: UIConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusM),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),

      /// Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(
            UIConstants.buttonMinWidth,
            UIConstants.buttonHeightCompact,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.spacingM,
            vertical: UIConstants.spacingS,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusM),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),

      /// Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.border, width: 1.0),
          minimumSize: const Size(
            UIConstants.buttonMinWidth,
            UIConstants.buttonHeight,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.spacingL,
            vertical: UIConstants.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConstants.radiusM),
          ),
          textStyle: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),

      /// Input decoration theme for form fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.border, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.border, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
          borderSide: const BorderSide(color: AppColors.error, width: 1.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: UIConstants.spacingM,
          vertical: UIConstants.spacingM,
        ),
        hintStyle: GoogleFonts.montserrat(
          color: AppColors.textTertiary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: GoogleFonts.montserrat(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      /// Tab bar theme for navigation tabs
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        overlayColor: WidgetStatePropertyAll(AppColors.primary),
      ),

      /// Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1.0,
        space: UIConstants.spacingM,
      ),

      /// Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: UIConstants.iconMedium,
      ),

      /// Chip theme for tags and labels
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        labelStyle: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstants.radiusS),
          side: const BorderSide(color: AppColors.border, width: 1.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.spacingS,
          vertical: UIConstants.spacingXS,
        ),
      ),

      /// Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: GoogleFonts.montserrat(
          color: AppColors.textOnDark,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(UIConstants.radiusM)),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: UIConstants.elevationHigh,
      ),

      // ========== VISUAL DENSITY ==========
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // ========== PLATFORM ADAPTATIONS ==========
      platform: TargetPlatform.android, // Consistent across platforms
    );
  }

  /// Dark theme configuration (future enhancement)
  static ThemeData get darkTheme {
    // Dark theme implementation can be added here
    // For now, return light theme to focus on the main functionality
    return lightTheme;
  }

  /// Get theme based on brightness
  static ThemeData getTheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return lightTheme;
      case Brightness.dark:
        return darkTheme;
    }
  }
}
