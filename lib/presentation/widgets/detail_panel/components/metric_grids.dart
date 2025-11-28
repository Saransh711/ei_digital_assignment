import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Metric grids showing loyalty and visits information
class MetricGrids extends StatelessWidget {
  const MetricGrids({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Loyalty Box
        Expanded(
          child: _buildMetricBox(
            context,
            "LOYALTY",
            [
              ["0", "Earned"],
              ["0", "Redeemed"],
            ],
            [
              ["0", "Available"],
              ["\$ 00.00", "Amount"],
            ],
          ),
        ),
        SizedBox(width: context.responsivePadding(12)),
        // Visits Box
        Expanded(
          child: _buildMetricBox(
            context,
            "VISITS",
            [
              ["0", "Total Visits"],
              ["0", "Upcoming"],
            ],
            [
              ["0", "Canceled"],
              ["0", "No Shows"],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricBox(
    BuildContext context,
    String title,
    List<List<String>> row1,
    List<List<String>> row2,
  ) {
    return Container(
      padding: EdgeInsets.all(context.responsivePadding(12)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 6, medium: 7, large: 8, extraLarge: 9),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            title,
            style: ResponsiveTextStyle.labelSmall,
            fontSize: context.responsiveFontSize(14),
            fontWeight: FontWeight.bold,
            color: AppColors.textTertiary,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.responsivePadding(12)),
          _buildMetricRow(context, row1),
          SizedBox(height: context.responsivePadding(12)),
          _buildMetricRow(context, row2),
        ],
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, List<List<String>> data) {
    return Row(
      children: data.map((item) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ResponsiveText(
                      item[0],
                      style: ResponsiveTextStyle.bodyMedium,
                      fontWeight: FontWeight.bold,
                      fontSize: context.responsiveFontSize(13),
                      color: AppColors.detailPanelTextColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.responsivePadding(2)),
              Row(
                children: [
                  Expanded(
                    child: ResponsiveText(
                      item[1],
                      style: ResponsiveTextStyle.bodySmall,
                      fontSize: context.responsiveFontSize(11),
                      fontWeight: FontWeight.bold,
                      color: AppColors.detailPanelTextColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
