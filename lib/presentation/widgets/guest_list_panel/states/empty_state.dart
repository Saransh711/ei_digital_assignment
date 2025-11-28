import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_padding.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Empty state widget for guest list
class GuestListEmptyState extends StatelessWidget {
  const GuestListEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding.large(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            size: context.responsiveFontSize(48),
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingM)),
          ResponsiveText(
            'No Guests Found',
            style: ResponsiveTextStyle.headlineSmall,
            color: AppColors.textPrimary,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.responsivePadding(UIConstants.spacingS)),
          ResponsiveText(
            'Try adjusting your search or filters',
            style: ResponsiveTextStyle.bodyMedium,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
