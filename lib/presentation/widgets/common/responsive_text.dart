/// Responsive text widget that automatically scales based on screen size
/// This widget eliminates the need for manual responsive text sizing
/// throughout the application, following DRY principles.
library;

import 'package:flutter/material.dart';
import '../../../core/constants/text_style_constants.dart';
import '../../../core/constants/color_constants.dart';

/// Text widget with automatic responsive sizing and consistent styling
/// Use this instead of regular Text widgets to ensure responsive design
class ResponsiveText extends StatelessWidget {
  /// Text content to display
  final String text;

  /// Text style variant to use
  final ResponsiveTextStyle style;

  /// Text color override (optional)
  final Color? color;

  /// Font weight override (optional)
  final FontWeight? fontWeight;

  /// Text alignment
  final TextAlign? textAlign;

  /// Maximum number of lines
  final int? maxLines;

  /// Text overflow behavior
  final TextOverflow? overflow;

  /// Whether text should be selectable
  final bool selectable;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  ///Font size override
  final double? fontSize;

  /// Creates a responsive text widget
  const ResponsiveText(
    this.text, {
    super.key,
    this.style = ResponsiveTextStyle.bodyMedium,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  });

  /// Create a headline text widget
  const ResponsiveText.headline(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  }) : style = ResponsiveTextStyle.headlineMedium;

  /// Create a title text widget
  const ResponsiveText.title(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  }) : style = ResponsiveTextStyle.headlineSmall;

  /// Create a body text widget
  const ResponsiveText.body(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  }) : style = ResponsiveTextStyle.bodyMedium;

  /// Create a caption text widget
  const ResponsiveText.caption(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  }) : style = ResponsiveTextStyle.bodySmall;

  /// Create a label text widget
  const ResponsiveText.label(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.selectable = false,
    this.semanticsLabel,
    this.fontSize,
  }) : style = ResponsiveTextStyle.labelMedium;

  @override
  Widget build(BuildContext context) {
    final textStyle = _getTextStyle(context);

    if (selectable) {
      return SelectableText(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
      );
    }

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
    );
  }

  /// Get the appropriate text style based on the variant
  TextStyle _getTextStyle(BuildContext context) {
    TextStyle baseStyle;

    switch (style) {
      case ResponsiveTextStyle.displayLarge:
        baseStyle = AppTextStyles.displayLarge(context);
        break;
      case ResponsiveTextStyle.displayMedium:
        baseStyle = AppTextStyles.displayMedium(context);
        break;
      case ResponsiveTextStyle.displaySmall:
        baseStyle = AppTextStyles.displaySmall(context);
        break;
      case ResponsiveTextStyle.headlineLarge:
        baseStyle = AppTextStyles.headlineLarge(context);
        break;
      case ResponsiveTextStyle.headlineMedium:
        baseStyle = AppTextStyles.headlineMedium(context);
        break;
      case ResponsiveTextStyle.headlineSmall:
        baseStyle = AppTextStyles.headlineSmall(context);
        break;
      case ResponsiveTextStyle.bodyLarge:
        baseStyle = AppTextStyles.bodyLarge(context);
        break;
      case ResponsiveTextStyle.bodyMedium:
        baseStyle = AppTextStyles.bodyMedium(context);
        break;
      case ResponsiveTextStyle.bodySmall:
        baseStyle = AppTextStyles.bodySmall(context);
        break;
      case ResponsiveTextStyle.labelLarge:
        baseStyle = AppTextStyles.labelLarge(context);
        break;
      case ResponsiveTextStyle.labelMedium:
        baseStyle = AppTextStyles.labelMedium(context);
        break;
      case ResponsiveTextStyle.labelSmall:
        baseStyle = AppTextStyles.labelSmall(context);
        break;
      case ResponsiveTextStyle.guestName:
        baseStyle = AppTextStyles.guestName(context);
        break;
      case ResponsiveTextStyle.guestEmail:
        baseStyle = AppTextStyles.guestEmail(context);
        break;
      case ResponsiveTextStyle.statisticValue:
        baseStyle = AppTextStyles.statisticValue(context);
        break;
      case ResponsiveTextStyle.statisticLabel:
        baseStyle = AppTextStyles.statisticLabel(context);
        break;
    }

    // Apply overrides
    return baseStyle.copyWith(
      color: color ?? baseStyle.color,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      fontSize: fontSize ?? baseStyle.fontSize,
    );
  }
}

/// Enumeration of available responsive text styles
enum ResponsiveTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  guestName,
  guestEmail,
  statisticValue,
  statisticLabel,
}

/// Extension for easy color application
extension ResponsiveTextColorExtension on ResponsiveText {
  /// Apply primary color
  ResponsiveText get primary => ResponsiveText(
    text,
    key: key,
    style: style,
    color: AppColors.primary,
    fontWeight: fontWeight,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply secondary color
  ResponsiveText get secondary => ResponsiveText(
    text,
    key: key,
    style: style,
    color: AppColors.textSecondary,
    fontWeight: fontWeight,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply tertiary color
  ResponsiveText get tertiary => ResponsiveText(
    text,
    key: key,
    style: style,
    color: AppColors.textTertiary,
    fontWeight: fontWeight,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply error color
  ResponsiveText get error => ResponsiveText(
    text,
    key: key,
    style: style,
    color: AppColors.error,
    fontWeight: fontWeight,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply success color
  ResponsiveText get success => ResponsiveText(
    text,
    key: key,
    style: style,
    color: AppColors.success,
    fontWeight: fontWeight,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply bold font weight
  ResponsiveText get bold => ResponsiveText(
    text,
    key: key,
    style: style,
    color: color,
    fontWeight: FontWeight.w700,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );

  /// Apply medium font weight
  ResponsiveText get medium => ResponsiveText(
    text,
    key: key,
    style: style,
    color: color,
    fontWeight: FontWeight.w500,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    selectable: selectable,
    semanticsLabel: semanticsLabel,
  );
}
