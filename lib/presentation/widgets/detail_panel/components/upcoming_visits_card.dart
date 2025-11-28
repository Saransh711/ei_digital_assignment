import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/app_common_button.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Upcoming visits card showing guest's upcoming visit information
class UpcomingVisitsCard extends StatelessWidget {
  const UpcomingVisitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsivePadding(20)),
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
            "UPCOMING VISITS",
            style: ResponsiveTextStyle.labelSmall,
            fontWeight: FontWeight.bold,
            color: AppColors.textTertiary,
            fontSize: context.responsiveFontSize(14),
          ),
          SizedBox(height: context.responsivePadding(16)),
          Row(
            children: [
              Icon(
                Icons.storefront,
                size: context.responsiveValue(
                  small: 22,
                  medium: 24,
                  large: 26,
                  extraLarge: 28,
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
                  "No Upcoming Visits",
                  style: ResponsiveTextStyle.bodyMedium,
                  fontWeight: FontWeight.w600,
                  fontSize: context.responsiveFontSize(13),
                ),
              ),
              AppCommonButton(
                text: "Book A Visit",
                fontSize: context.responsiveFontSize(11),
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsivePadding(30),
                  vertical: context.responsivePadding(12),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
