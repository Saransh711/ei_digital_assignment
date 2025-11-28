import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Empty states row showing "No Ordered Items" and "No Recent Vehicle"
class EmptyStatesRow extends StatelessWidget {
  final bool isLandscape;

  const EmptyStatesRow({super.key, required this.isLandscape});

  @override
  Widget build(BuildContext context) {
    final firstBoxForPortrait = Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsivePadding(18),
        horizontal: context.responsivePadding(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 8,
            medium: 9,
            large: 10,
            extraLarge: 12,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fastfood_outlined,
                color: AppColors.textTertiary,
                size: context.responsiveValue(
                  small: 24,
                  medium: 28,
                  large: 30,
                  extraLarge: 32,
                ),
              ),
              SizedBox(width: context.responsivePadding(10)),
              Flexible(
                child: ResponsiveText(
                  "No Ordered Items",
                  style: ResponsiveTextStyle.bodySmall,
                  color: AppColors.detailPanelTextColor,
                  fontSize: context.responsiveFontSize(12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final secondBoxForPortrait = Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsivePadding(18),
        horizontal: context.responsivePadding(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 8,
            medium: 9,
            large: 10,
            extraLarge: 12,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            color: AppColors.textTertiary,
            size: context.responsiveValue(
              small: 18,
              medium: 20,
              large: 22,
              extraLarge: 24,
            ),
          ),
          SizedBox(width: context.responsivePadding(10)),
          Flexible(
            child: ResponsiveText(
              "No Recent Vehicle To Show",
              style: ResponsiveTextStyle.bodySmall,
              color: AppColors.detailPanelTextColor,
              fontSize: context.responsiveFontSize(12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    final firstBoxForLandscape = Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsivePadding(18),
        horizontal: context.responsivePadding(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 8,
            medium: 9,
            large: 10,
            extraLarge: 12,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fastfood_outlined,
            color: AppColors.textTertiary,
            size: context.responsiveValue(
              small: 24,
              medium: 28,
              large: 30,
              extraLarge: 32,
            ),
          ),
          SizedBox(height: context.responsivePadding(8)),
          Row(
            children: [
              Expanded(
                child: ResponsiveText(
                  "No Ordered Items",
                  style: ResponsiveTextStyle.bodySmall,
                  color: AppColors.textSecondary,
                  fontSize: context.responsiveFontSize(12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final secondBoxForLandscape = Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsivePadding(18),
        horizontal: context.responsivePadding(16),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 8,
            medium: 9,
            large: 10,
            extraLarge: 12,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            color: AppColors.textTertiary,
            size: context.responsiveValue(
              small: 18,
              medium: 20,
              large: 22,
              extraLarge: 24,
            ),
          ),
          SizedBox(width: context.responsivePadding(10)),
          ResponsiveText(
            "No Recent Vehicle To Show",
            style: ResponsiveTextStyle.bodySmall,
            color: AppColors.textSecondary,
            fontSize: context.responsiveFontSize(12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (isLandscape) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: firstBoxForLandscape),
          SizedBox(width: context.responsivePadding(20)),
          Expanded(child: secondBoxForLandscape),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: firstBoxForPortrait),
        SizedBox(width: context.responsivePadding(8)),
        Expanded(child: secondBoxForPortrait),
      ],
    );
  }
}
