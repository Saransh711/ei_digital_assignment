/// Responsive padding widget that automatically scales based on screen size
/// This widget provides consistent spacing throughout the application
/// following responsive design principles and DRY methodology.
library;

import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/constants/ui_constants.dart';

/// Padding widget that automatically scales based on screen size
/// Use this instead of manual padding to ensure consistent responsive spacing
class ResponsivePadding extends StatelessWidget {
  /// Child widget to wrap with padding
  final Widget child;

  /// Padding variant to use
  final ResponsivePaddingSize size;

  /// Whether to apply padding horizontally
  final bool horizontal;

  /// Whether to apply padding vertically
  final bool vertical;

  /// Custom horizontal padding multiplier (optional)
  final double? horizontalMultiplier;

  /// Custom vertical padding multiplier (optional)
  final double? verticalMultiplier;

  /// Creates a responsive padding widget
  const ResponsivePadding({
    super.key,
    required this.child,
    this.size = ResponsivePaddingSize.medium,
    this.horizontal = true,
    this.vertical = true,
    this.horizontalMultiplier,
    this.verticalMultiplier,
  });

  /// Create padding with only horizontal spacing
  const ResponsivePadding.horizontal({
    super.key,
    required this.child,
    this.size = ResponsivePaddingSize.medium,
    this.horizontalMultiplier,
  })  : horizontal = true,
        vertical = false,
        verticalMultiplier = null;

  /// Create padding with only vertical spacing
  const ResponsivePadding.vertical({
    super.key,
    required this.child,
    this.size = ResponsivePaddingSize.medium,
    this.verticalMultiplier,
  })  : horizontal = false,
        vertical = true,
        horizontalMultiplier = null;

  /// Create padding with all sides
  const ResponsivePadding.all({
    super.key,
    required this.child,
    this.size = ResponsivePaddingSize.medium,
  })  : horizontal = true,
        vertical = true,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  /// Create extra small padding
  const ResponsivePadding.extraSmall({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = true,
  })  : size = ResponsivePaddingSize.extraSmall,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  /// Create small padding
  const ResponsivePadding.small({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = true,
  })  : size = ResponsivePaddingSize.small,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  /// Create medium padding (default)
  const ResponsivePadding.medium({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = true,
  })  : size = ResponsivePaddingSize.medium,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  /// Create large padding
  const ResponsivePadding.large({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = true,
  })  : size = ResponsivePaddingSize.large,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  /// Create extra large padding
  const ResponsivePadding.extraLarge({
    super.key,
    required this.child,
    this.horizontal = true,
    this.vertical = true,
  })  : size = ResponsivePaddingSize.extraLarge,
        horizontalMultiplier = null,
        verticalMultiplier = null;

  @override
  Widget build(BuildContext context) {
    final paddingValue = _getPaddingValue(context);

    final horizontalPadding = horizontal 
        ? paddingValue * (horizontalMultiplier ?? 1.0)
        : 0.0;

    final verticalPadding = vertical 
        ? paddingValue * (verticalMultiplier ?? 1.0)
        : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }

  /// Get the base padding value for the current screen size
  double _getPaddingValue(BuildContext context) {
    final basePadding = _getBasePaddingForSize();
    return context.responsivePadding(basePadding);
  }

  /// Get base padding value for the specified size
  double _getBasePaddingForSize() {
    switch (size) {
      case ResponsivePaddingSize.extraSmall:
        return UIConstants.spacingXS;
      case ResponsivePaddingSize.small:
        return UIConstants.spacingS;
      case ResponsivePaddingSize.medium:
        return UIConstants.spacingM;
      case ResponsivePaddingSize.large:
        return UIConstants.spacingL;
      case ResponsivePaddingSize.extraLarge:
        return UIConstants.spacingXL;
    }
  }
}

/// Enumeration of available padding sizes
enum ResponsivePaddingSize {
  extraSmall,
  small,
  medium,
  large,
  extraLarge,
}

/// Custom responsive padding widget for specific use cases
class CustomResponsivePadding extends StatelessWidget {
  /// Child widget to wrap with padding
  final Widget child;

  /// Custom padding specification
  final ResponsiveEdgeInsets padding;

  /// Creates a custom responsive padding widget
  const CustomResponsivePadding({
    super.key,
    required this.child,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.resolve(context),
      child: child,
    );
  }
}

/// Responsive edge insets that scale based on screen size
class ResponsiveEdgeInsets {
  /// Left padding
  final double left;

  /// Top padding
  final double top;

  /// Right padding
  final double right;

  /// Bottom padding
  final double bottom;

  /// Creates responsive edge insets
  const ResponsiveEdgeInsets.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  /// Creates responsive edge insets with symmetric values
  const ResponsiveEdgeInsets.symmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  })  : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  /// Creates responsive edge insets with individual values
  const ResponsiveEdgeInsets.only({
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
  });

  /// Resolve to actual EdgeInsets based on screen size
  EdgeInsets resolve(BuildContext context) {
    return EdgeInsets.only(
      left: context.responsivePadding(left),
      top: context.responsivePadding(top),
      right: context.responsivePadding(right),
      bottom: context.responsivePadding(bottom),
    );
  }

  /// Create from UI constants
  factory ResponsiveEdgeInsets.fromUIConstant(ResponsivePaddingSize size) {
    final value = switch (size) {
      ResponsivePaddingSize.extraSmall => UIConstants.spacingXS,
      ResponsivePaddingSize.small => UIConstants.spacingS,
      ResponsivePaddingSize.medium => UIConstants.spacingM,
      ResponsivePaddingSize.large => UIConstants.spacingL,
      ResponsivePaddingSize.extraLarge => UIConstants.spacingXL,
    };

    return ResponsiveEdgeInsets.all(value);
  }
}

/// Sliver responsive padding widget for use in CustomScrollView
class SliverResponsivePadding extends StatelessWidget {
  /// Sliver child widget
  final Widget sliver;

  /// Padding size to apply
  final ResponsivePaddingSize size;

  /// Whether to apply horizontal padding
  final bool horizontal;

  /// Whether to apply vertical padding
  final bool vertical;

  /// Creates a sliver responsive padding widget
  const SliverResponsivePadding({
    super.key,
    required this.sliver,
    this.size = ResponsivePaddingSize.medium,
    this.horizontal = true,
    this.vertical = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = ResponsivePadding(
      size: size,
      horizontal: horizontal,
      vertical: vertical,
      child: const SizedBox.shrink(),
    );

    final paddingValue = responsivePadding._getPaddingValue(context);

    final horizontalPadding = horizontal ? paddingValue : 0.0;
    final verticalPadding = vertical ? paddingValue : 0.0;

    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      sliver: sliver,
    );
  }
}

/// Quick access extensions for common padding patterns
extension WidgetResponsivePaddingExtensions on Widget {
  /// Wrap widget with responsive padding
  Widget withResponsivePadding({
    ResponsivePaddingSize size = ResponsivePaddingSize.medium,
    bool horizontal = true,
    bool vertical = true,
  }) {
    return ResponsivePadding(
      size: size,
      horizontal: horizontal,
      vertical: vertical,
      child: this,
    );
  }

  /// Wrap widget with small responsive padding
  Widget withSmallPadding() => ResponsivePadding.small(child: this);

  /// Wrap widget with medium responsive padding
  Widget withMediumPadding() => ResponsivePadding.medium(child: this);

  /// Wrap widget with large responsive padding
  Widget withLargePadding() => ResponsivePadding.large(child: this);

  /// Wrap widget with horizontal responsive padding only
  Widget withHorizontalPadding({
    ResponsivePaddingSize size = ResponsivePaddingSize.medium,
  }) {
    return ResponsivePadding.horizontal(size: size, child: this);
  }

  /// Wrap widget with vertical responsive padding only
  Widget withVerticalPadding({
    ResponsivePaddingSize size = ResponsivePaddingSize.medium,
  }) {
    return ResponsivePadding.vertical(size: size, child: this);
  }
}
