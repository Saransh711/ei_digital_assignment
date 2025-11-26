/// Design utility functions for common UI calculations and helpers
/// These utilities provide consistent design patterns and calculations
/// throughout the guest book application.
library;

import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import '../constants/ui_constants.dart';
import '../constants/color_constants.dart';

/// Utility class for design-related calculations and helpers
class DesignUtils {
  // Private constructor to prevent instantiation
  DesignUtils._();

  // ========== COLOR UTILITIES ==========

  /// Generate a lighter shade of a color
  static Color lightenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Generate a darker shade of a color
  static Color darkenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Get contrasting text color for a given background
  static Color getContrastingTextColor(Color backgroundColor) {
    // Calculate luminance
    final luminance = backgroundColor.computeLuminance();

    // Return white text for dark backgrounds, dark text for light backgrounds
    return luminance > 0.5 ? AppColors.textPrimary : AppColors.textOnDark;
  }

  /// Generate avatar color based on name
  static Color getAvatarColor(String name) {
    // Simple hash-based color generation
    final hash = name.hashCode;
    final colors = [
      const Color(0xFF2196F3), // Blue
      const Color(0xFF4CAF50), // Green
      const Color(0xFFFF9800), // Orange
      const Color(0xFF9C27B0), // Purple
      const Color(0xFFE91E63), // Pink
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFF8BC34A), // Light Green
      const Color(0xFFFF5722), // Deep Orange
    ];

    return colors[hash.abs() % colors.length];
  }

  // ========== SHADOW UTILITIES ==========

  /// Generate consistent box shadow for cards
  static List<BoxShadow> getCardShadow({double elevation = 4.0}) {
    return [
      BoxShadow(
        color: AppColors.shadow,
        offset: Offset(0, elevation / 2),
        blurRadius: elevation,
        spreadRadius: 0,
      ),
    ];
  }

  /// Generate subtle inset shadow for input fields
  static List<BoxShadow> getInsetShadow() {
    return [
      BoxShadow(
        color: AppColors.shadow.withValues(alpha: 0.1),
        offset: const Offset(0, 2),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ];
  }

  // ========== BORDER UTILITIES ==========

  /// Generate consistent border for input fields
  static Border getInputBorder({Color? color, double width = 1.0}) {
    return Border.all(color: color ?? AppColors.border, width: width);
  }

  /// Generate rounded border with custom radius
  static BorderRadius getBorderRadius(double radius) {
    return BorderRadius.circular(radius);
  }

  /// Get standard card border radius
  static BorderRadius getCardBorderRadius() {
    return BorderRadius.circular(UIConstants.radiusL);
  }

  // ========== GRADIENT UTILITIES ==========

  /// Generate subtle background gradient
  static LinearGradient getSubtleGradient({
    Color? startColor,
    Color? endColor,
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        startColor ?? AppColors.surface,
        endColor ?? lightenColor(startColor ?? AppColors.surface, 0.05),
      ],
    );
  }

  /// Generate primary accent gradient
  static LinearGradient getPrimaryGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.primary, darkenColor(AppColors.primary, 0.1)],
    );
  }

  // ========== TEXT UTILITIES ==========

  /// Get initials from full name for avatars
  static String getInitials(String fullName) {
    if (fullName.isEmpty) return '?';

    final names = fullName.trim().split(' ');
    if (names.length == 1) {
      return names[0].substring(0, 1).toUpperCase();
    }

    return '${names.first.substring(0, 1)}${names.last.substring(0, 1)}'
        .toUpperCase();
  }

  /// Format currency values consistently
  static String formatCurrency(double amount) {
    if (amount == 0) return '\$0.00';
    return '\$${amount.toStringAsFixed(2)}';
  }

  /// Format phone numbers consistently
  static String formatPhoneNumber(String phone) {
    // Remove all non-digits
    final digits = phone.replaceAll(RegExp(r'\D'), '');

    if (digits.length == 10) {
      // Format as (XXX) XXX-XXXX
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      // Format as +1 (XXX) XXX-XXXX
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }

    // Return original if can't format
    return phone;
  }

  // ========== ANIMATION UTILITIES ==========

  /// Generate consistent slide transition
  static SlideTransition createSlideTransition({
    required Animation<double> animation,
    required Widget child,
    Offset begin = const Offset(-1.0, 0.0),
    Offset end = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }

  /// Generate consistent fade transition
  static FadeTransition createFadeTransition({
    required Animation<double> animation,
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }

  // ========== LAYOUT UTILITIES ==========

  /// Create consistent vertical spacing
  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  /// Create consistent horizontal spacing
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }

  /// Create standard vertical spacing
  static Widget get standardVerticalSpace =>
      verticalSpace(UIConstants.spacingM);

  /// Create small vertical spacing
  static Widget get smallVerticalSpace => verticalSpace(UIConstants.spacingS);

  /// Create large vertical spacing
  static Widget get largeVerticalSpace => verticalSpace(UIConstants.spacingL);

  // ========== VALIDATION UTILITIES ==========

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number format
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(
      r'^\+?1?[-.\s]?\(?[2-9]\d{2}\)?[-.\s]?\d{3}[-.\s]?\d{4}$',
    );
    return phoneRegex.hasMatch(phone);
  }

  // ========== DEBUG UTILITIES ==========

  /// Generate random color for debugging layouts
  static Color getRandomColor() {
    final colors = [
      Colors.red.withValues(alpha: 0.3),
      Colors.green.withValues(alpha: 0.3),
      Colors.blue.withValues(alpha: 0.3),
      Colors.orange.withValues(alpha: 0.3),
      Colors.purple.withValues(alpha: 0.3),
    ];

    return colors[(DateTime.now().millisecondsSinceEpoch % colors.length)];
  }

  // ========== RESPONSIVE UTILITIES ==========

  /// Calculate responsive border radius
  static double getResponsiveBorderRadius(
    BuildContext context,
    double baseRadius,
  ) {
    return baseRadius *
        context.responsiveValue(
          small: 1.0,
          medium: 1.1,
          large: 1.2,
          extraLarge: 1.3,
        );
  }

  /// Get responsive elevation for cards and surfaces
  static double getResponsiveElevation(
    BuildContext context,
    double baseElevation,
  ) {
    return baseElevation *
        context.responsiveValue(
          small: 1.0,
          medium: 1.1,
          large: 1.2,
          extraLarge: 1.3,
        );
  }

  /// Calculate responsive margin for cards and containers
  static EdgeInsets getResponsiveMargin(BuildContext context) {
    return EdgeInsets.all(
      context.responsiveValue(
        small: 8.0,
        medium: 12.0,
        large: 16.0,
        extraLarge: 20.0,
      ),
    );
  }

  /// Get responsive content padding for main areas
  static EdgeInsets getContentPadding(BuildContext context) {
    return EdgeInsets.all(
      context.responsiveValue(
        small: 16.0,
        medium: 20.0,
        large: 24.0,
        extraLarge: 28.0,
      ),
    );
  }

  /// Add debug border to widgets for layout debugging
  static Widget debugBorder(Widget child, [String? label]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: getRandomColor(), width: 2),
      ),
      child: label != null
          ? Stack(
              children: [
                child,
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    color: Colors.black54,
                    child: Text(
                      label,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            )
          : child,
    );
  }
}
