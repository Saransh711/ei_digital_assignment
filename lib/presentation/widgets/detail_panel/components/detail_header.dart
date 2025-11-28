import 'package:ei_digital_assignment/core/constants/app_constants.dart';
import 'package:ei_digital_assignment/core/constants/app_image_constants.dart';
import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Header section with app icon, title, and description
class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.responsivePadding(24),
        left: context.responsivePadding(24),
        right: context.responsivePadding(24),
        bottom: context.responsivePadding(16),
      ),
      color: AppColors.surface,
      child: Column(
        children: [
          Image.asset(
            AppImageConstants.guestBookIcon,
            width: context.responsiveValue(
              small: 32,
              medium: 36,
              large: 40,
              extraLarge: 44,
            ),
            height: context.responsiveValue(
              small: 32,
              medium: 36,
              large: 40,
              extraLarge: 44,
            ),
            color: AppColors.textSecondary,
          ),
          SizedBox(height: context.responsivePadding(12)),
          ResponsiveText(
            AppConstants.appName,
            style: ResponsiveTextStyle.headlineSmall,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: context.responsiveFontSize(18),
          ),
          SizedBox(height: context.responsivePadding(8)),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.responsiveValue(
                small: 300,
                medium: 600,
                large: 700,
                extraLarge: 800,
              ),
            ),
            child: ResponsiveText(
              AppConstants.guestBookDescription,
              style: ResponsiveTextStyle.bodySmall,
              color: AppColors.textSecondary,
              textAlign: TextAlign.center,
              fontSize: context.responsiveFontSize(13),
            ),
          ),
        ],
      ),
    );
  }
}
