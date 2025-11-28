import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Horizontal strip displaying guest statistics
class StatsStrip extends StatelessWidget {
  final bool isLandscape;

  const StatsStrip({super.key, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _buildStatItem(context, '-- -- --', 'Last Visit'),
      _buildStatItem(context, '\$0.00', 'Average Spend'),
      _buildStatItem(context, '\$0.00', 'Lifetime Spend'),
      _buildStatItem(context, '0', 'Total Orders'),
      _buildStatItem(context, '\$0.00', 'Average Tip'),
    ];

    final statChildren = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      statChildren.add(isLandscape ? Expanded(child: stats[i]) : stats[i]);
      if (i < stats.length - 1) {
        statChildren.add(
          Container(
            height: context.responsiveValue(
              small: 24,
              medium: 28,
              large: 32,
              extraLarge: 36,
            ),
            width: 1,
            color: AppColors.divider,
            margin: EdgeInsets.symmetric(horizontal: isLandscape ? 0 : 12),
          ),
        );
      }
    }

    if (isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: statChildren,
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: statChildren),
      );
    }
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsivePadding(8),
        vertical: context.responsivePadding(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveText(
            value,
            style: ResponsiveTextStyle.bodyMedium,
            fontWeight: FontWeight.bold,
            fontSize: context.responsiveFontSize(16),
            color: AppColors.detailPanelTextColor,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.responsivePadding(4)),
          ResponsiveText(
            label,
            style: ResponsiveTextStyle.bodySmall,
            fontWeight: FontWeight.bold,
            fontSize: context.responsiveFontSize(12),
            color: AppColors.detailPanelTextColor,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
