import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Generic section card for displaying empty states (Recent Orders, Online Reviews, etc.)
class SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String emptyText;

  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsivePadding(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 10,
            medium: 11,
            large: 12,
            extraLarge: 13,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            title,
            style: ResponsiveTextStyle.labelSmall,
            fontWeight: FontWeight.bold,
            color: AppColors.textTertiary,
            fontSize: context.responsiveFontSize(14),
          ),
          SizedBox(height: context.responsivePadding(24)),
          Row(
            children: [
              Icon(
                icon,
                size: context.responsiveValue(
                  small: 24,
                  medium: 28,
                  large: 32,
                  extraLarge: 36,
                ),
                color: AppColors.textPrimary,
              ),
              SizedBox(
                height: context.responsiveValue(
                  small: 32,
                  medium: 36,
                  large: 40,
                  extraLarge: 44,
                ),
                child: const VerticalDivider(
                  width: 32,
                  thickness: 1,
                  color: AppColors.divider,
                ),
              ),
              Expanded(
                child: ResponsiveText(
                  emptyText,
                  style: ResponsiveTextStyle.bodyMedium,
                  fontWeight: FontWeight.bold,
                  fontSize: context.responsiveFontSize(14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
