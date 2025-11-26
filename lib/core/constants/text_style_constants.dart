/// Responsive text styles that scale based on screen size
/// All text styles extracted from screenshot analysis with responsive scaling
/// Typography hierarchy matches the guest book interface design using Montserrat font.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../extensions/context_extensions.dart';

/// Text style constants with responsive scaling capabilities
/// All styles follow Material Design typography guidelines
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // ========== FONT WEIGHT CONSTANTS ==========

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // ========== RESPONSIVE TEXT STYLES ==========

  /// Display large text style - Used for major headings
  /// Responsive scaling: 28sp (small) → 32sp (large) → 36sp (xlarge)
  static TextStyle displayLarge(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(28),
      fontWeight: bold,
      letterSpacing: -0.25,
      height: 1.2,
    );
  }

  /// Display medium text style - Used for section headings
  /// Responsive scaling: 24sp (small) → 28sp (large) → 32sp (xlarge)
  static TextStyle displayMedium(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(24),
      fontWeight: semiBold,
      letterSpacing: 0,
      height: 1.3,
    );
  }

  /// Display small text style - Used for subsection headings
  /// Responsive scaling: 20sp (small) → 24sp (large) → 28sp (xlarge)
  static TextStyle displaySmall(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(20),
      fontWeight: medium,
      letterSpacing: 0.15,
      height: 1.4,
    );
  }

  /// Headline large - Used for main content headings
  /// Responsive scaling: 18sp (small) → 20sp (large) → 22sp (xlarge)
  static TextStyle headlineLarge(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(18),
      fontWeight: medium,
      letterSpacing: 0,
      height: 1.4,
    );
  }

  /// Headline medium - Used for content headings (guest names, section titles)
  /// Responsive scaling: 16sp (small) → 18sp (large) → 20sp (xlarge)
  static TextStyle headlineMedium(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(16),
      fontWeight: medium,
      letterSpacing: 0.15,
      height: 1.4,
    );
  }

  /// Headline small - Used for smaller content headings
  /// Responsive scaling: 14sp (small) → 16sp (large) → 18sp (xlarge)
  static TextStyle headlineSmall(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(14),
      fontWeight: medium,
      letterSpacing: 0.1,
      height: 1.4,
    );
  }

  /// Body large - Used for primary body text
  /// Responsive scaling: 16sp (small) → 17sp (large) → 18sp (xlarge)
  static TextStyle bodyLarge(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(16),
      fontWeight: regular,
      letterSpacing: 0.5,
      height: 1.5,
    );
  }

  /// Body medium - Used for standard body text (main content)
  /// Responsive scaling: 14sp (small) → 15sp (large) → 16sp (xlarge)
  static TextStyle bodyMedium(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(14),
      fontWeight: regular,
      letterSpacing: 0.25,
      height: 1.5,
    );
  }

  /// Body small - Used for secondary body text
  /// Responsive scaling: 12sp (small) → 13sp (large) → 14sp (xlarge)
  static TextStyle bodySmall(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(12),
      fontWeight: regular,
      letterSpacing: 0.4,
      height: 1.5,
    );
  }

  /// Label large - Used for button text and important labels
  /// Responsive scaling: 14sp (small) → 15sp (large) → 16sp (xlarge)
  static TextStyle labelLarge(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(14),
      fontWeight: medium,
      letterSpacing: 0.1,
      height: 1.4,
    );
  }

  /// Label medium - Used for standard labels and form fields
  /// Responsive scaling: 12sp (small) → 13sp (large) → 14sp (xlarge)
  static TextStyle labelMedium(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(12),
      fontWeight: medium,
      letterSpacing: 0.5,
      height: 1.4,
    );
  }

  /// Label small - Used for captions and fine print
  /// Responsive scaling: 11sp (small) → 12sp (large) → 13sp (xlarge)
  static TextStyle labelSmall(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(11),
      fontWeight: medium,
      letterSpacing: 0.5,
      height: 1.4,
    );
  }

  // ========== SPECIALIZED TEXT STYLES ==========

  /// Tab text style - Used for tab navigation
  static TextStyle tabText(BuildContext context, {bool isActive = false}) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(14),
      fontWeight: isActive ? medium : regular,
      letterSpacing: 0.1,
      height: 1.4,
    );
  }

  /// Statistics text style - Used for numbers and metrics
  static TextStyle statisticValue(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(18),
      fontWeight: semiBold,
      letterSpacing: 0,
      height: 1.2,
    );
  }

  /// Statistics label style - Used for metric labels
  static TextStyle statisticLabel(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(12),
      fontWeight: regular,
      letterSpacing: 0.4,
      height: 1.4,
    );
  }

  /// Guest name style - Used for guest list items
  static TextStyle guestName(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(16),
      fontWeight: medium,
      letterSpacing: 0.1,
      height: 1.4,
    );
  }

  /// Guest email style - Used for guest contact information
  static TextStyle guestEmail(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: context.responsiveFontSize(14),
      fontWeight: regular,
      letterSpacing: 0.25,
      height: 1.4,
    );
  }
}
