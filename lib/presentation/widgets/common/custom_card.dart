/// Custom card widget with consistent styling and responsive behavior
/// This widget provides a reusable card component that matches the
/// guest book interface design and scales appropriately.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/ui_constants.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/utils/design_utils.dart';
import 'responsive_padding.dart';

/// Custom card widget with consistent styling
/// Use this instead of Material Card to ensure design consistency
class CustomCard extends StatelessWidget {
  /// Child widget to display in the card
  final Widget child;

  /// Background color of the card
  final Color? backgroundColor;

  /// Border radius override
  final double? borderRadius;

  /// Elevation override
  final double? elevation;

  /// Margin around the card
  final EdgeInsetsGeometry? margin;

  /// Padding inside the card
  final EdgeInsetsGeometry? padding;

  /// Whether the card should be clickable
  final bool clickable;

  /// Callback for tap events
  final VoidCallback? onTap;

  /// Callback for long press events
  final VoidCallback? onLongPress;

  /// Whether to show a subtle border
  final bool showBorder;

  /// Border color override
  final Color? borderColor;

  /// Whether to apply a subtle gradient background
  final bool useGradient;

  /// Shadow color override
  final Color? shadowColor;

  /// Semantic label for accessibility
  final String? semanticsLabel;

  /// Creates a custom card widget
  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.padding,
    this.clickable = false,
    this.onTap,
    this.onLongPress,
    this.showBorder = false,
    this.borderColor,
    this.useGradient = false,
    this.shadowColor,
    this.semanticsLabel,
  });

  /// Create a clickable card
  const CustomCard.clickable({
    super.key,
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.padding,
    this.onLongPress,
    this.showBorder = false,
    this.borderColor,
    this.useGradient = false,
    this.shadowColor,
    this.semanticsLabel,
  }) : clickable = true;

  /// Create a bordered card
  const CustomCard.bordered({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.padding,
    this.clickable = false,
    this.onTap,
    this.onLongPress,
    this.borderColor,
    this.useGradient = false,
    this.shadowColor,
    this.semanticsLabel,
  }) : showBorder = true;

  /// Create a gradient card
  const CustomCard.gradient({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.margin,
    this.padding,
    this.clickable = false,
    this.onTap,
    this.onLongPress,
    this.showBorder = false,
    this.borderColor,
    this.shadowColor,
    this.semanticsLabel,
  }) : useGradient = true;

  @override
  Widget build(BuildContext context) {
    final cardBorderRadius =
        borderRadius ??
        DesignUtils.getResponsiveBorderRadius(context, UIConstants.radiusL);

    final cardElevation =
        elevation ??
        DesignUtils.getResponsiveElevation(context, UIConstants.cardElevation);

    final cardMargin = margin ?? DesignUtils.getResponsiveMargin(context);

    final cardPadding = padding ?? DesignUtils.getContentPadding(context);

    final cardBackgroundColor = backgroundColor ?? AppColors.surface;

    // Build the card content
    Widget cardChild = Container(
      padding: cardPadding,
      decoration: BoxDecoration(
        color: useGradient ? null : cardBackgroundColor,
        gradient: useGradient
            ? DesignUtils.getSubtleGradient(startColor: cardBackgroundColor)
            : null,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        border: showBorder
            ? Border.all(color: borderColor ?? AppColors.border, width: 1.0)
            : null,
        boxShadow: DesignUtils.getCardShadow(elevation: cardElevation),
      ),
      child: child,
    );

    // Add semantics if provided
    if (semanticsLabel != null) {
      cardChild = Semantics(label: semanticsLabel, child: cardChild);
    }

    // Wrap in Material for ink effects if clickable
    if (clickable) {
      cardChild = Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(cardBorderRadius),
          child: cardChild,
        ),
      );
    }

    // Apply margin
    return Container(margin: cardMargin, child: cardChild);
  }
}

/// Specialized cards for common use cases
class GuestCard extends StatelessWidget {
  /// Child widget (guest information)
  final Widget child;

  /// Whether the card is selected
  final bool isSelected;

  /// Tap callback
  final VoidCallback? onTap;

  /// Long press callback
  final VoidCallback? onLongPress;

  /// Creates a guest card widget
  const GuestCard({
    super.key,
    required this.child,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard.clickable(
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: isSelected
          ? AppColors.primary.withValues(alpha: 0.1)
          : null,
      showBorder: isSelected,
      borderColor: isSelected ? AppColors.primary : null,
      semanticsLabel: 'Guest card',
      child: child,
    );
  }
}

/// Statistics card for displaying metrics
class StatisticsCard extends StatelessWidget {
  /// Title of the statistic
  final String title;

  /// Value of the statistic
  final String value;

  /// Optional subtitle
  final String? subtitle;

  /// Optional icon
  final IconData? icon;

  /// Color theme for the card
  final Color? color;

  /// Creates a statistics card widget
  const StatisticsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;

    return CustomCard(
      useGradient: true,
      backgroundColor: cardColor.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: cardColor,
                  size: context.responsiveValue(
                    small: 20.0,
                    medium: 22.0,
                    large: 24.0,
                    extraLarge: 26.0,
                  ),
                ),
                DesignUtils.horizontalSpace(UIConstants.spacingS),
              ],
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: context.responsiveFontSize(12),
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          DesignUtils.verticalSpace(UIConstants.spacingS),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: context.responsiveFontSize(18),
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          if (subtitle != null) ...[
            DesignUtils.verticalSpace(UIConstants.spacingXS),
            Text(
              subtitle!,
              style: GoogleFonts.montserrat(
                fontSize: context.responsiveFontSize(10),
                fontWeight: FontWeight.w400,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Section card for grouping related content
class SectionCard extends StatelessWidget {
  /// Section title
  final String title;

  /// Section content
  final Widget child;

  /// Optional trailing widget (e.g., button)
  final Widget? trailing;

  /// Whether the section is collapsible
  final bool collapsible;

  /// Whether the section is initially expanded (if collapsible)
  final bool initiallyExpanded;

  /// Creates a section card widget
  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.collapsible = false,
    this.initiallyExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    if (collapsible) {
      return CustomCard(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            title: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: context.responsiveFontSize(16),
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            trailing: trailing,
            children: [ResponsivePadding.medium(child: child)],
          ),
        ),
      );
    }

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(16),
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          DesignUtils.verticalSpace(UIConstants.spacingM),
          child,
        ],
      ),
    );
  }
}

/// Loading card placeholder
class LoadingCard extends StatelessWidget {
  /// Height of the loading card
  final double? height;

  /// Whether to show shimmer animation
  final bool showShimmer;

  /// Creates a loading card widget
  const LoadingCard({super.key, this.height, this.showShimmer = true});

  @override
  Widget build(BuildContext context) {
    final cardHeight =
        height ??
        context.responsiveValue(
          small: 120.0,
          medium: 140.0,
          large: 160.0,
          extraLarge: 180.0,
        );

    return CustomCard(
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: AppColors.textTertiary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(UIConstants.radiusM),
        ),
        child: showShimmer
            ? const Center(child: CircularProgressIndicator.adaptive())
            : null,
      ),
    );
  }
}
