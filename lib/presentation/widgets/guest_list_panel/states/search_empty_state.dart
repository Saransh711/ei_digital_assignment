import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_padding.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Empty state widget for search results
class GuestListSearchEmptyState extends StatelessWidget {
  final String? searchQuery;

  const GuestListSearchEmptyState({
    super.key,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding.large(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
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
            searchQuery != null && searchQuery!.isNotEmpty
                ? 'No guests match "$searchQuery"'
                : 'Try adjusting your search or filters',
            style: ResponsiveTextStyle.bodyMedium,
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            textAlign: TextAlign.center,
          ),
          if (searchQuery != null && searchQuery!.isNotEmpty) ...[
            SizedBox(height: context.responsivePadding(UIConstants.spacingS)),
            ResponsiveText(
              'Please select a guest from the available list',
              style: ResponsiveTextStyle.bodySmall,
              color: AppColors.textPrimary.withValues(alpha: 0.6),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

