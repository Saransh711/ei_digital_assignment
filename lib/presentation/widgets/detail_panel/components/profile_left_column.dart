import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/core/utils/design_utils.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/app_common_button.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Left column showing guest avatar, name, email, phone, and add tags button
class ProfileLeftColumn extends StatelessWidget {
  final Guest guest;

  const ProfileLeftColumn({super.key, required this.guest});

  @override
  Widget build(BuildContext context) {
    final double avatarSize = context
        .responsiveValue(small: 70, medium: 80, large: 90, extraLarge: 100)
        .toDouble();
    final rawImageUrl = (guest.avatarUrl)?.trim();
    final imageUrl = rawImageUrl != null && rawImageUrl.isNotEmpty
        ? rawImageUrl
        : null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: imageUrl != null
                ? Colors.transparent
                : AppColors.detailPanelColor,
            image: imageUrl != null
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl != null
              ? null
              : Center(
                  child: ResponsiveText(
                    guest.initials,
                    style: ResponsiveTextStyle.displaySmall,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: context.responsiveFontSize(24),
                  ),
                ),
        ),
        SizedBox(height: context.responsivePadding(16)),
        ResponsiveText(
          guest.name,
          style: ResponsiveTextStyle.headlineMedium,
          fontWeight: FontWeight.bold,
          color: AppColors.detailPanelTextColor,
          textAlign: TextAlign.center,
          fontSize: context.responsiveFontSize(16),
        ),
        SizedBox(height: context.responsivePadding(4)),
        ResponsiveText(
          guest.email,
          style: ResponsiveTextStyle.bodySmall,
          color: AppColors.detailPanelTextColor,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
          fontSize: context.responsiveFontSize(12),
        ),
        SizedBox(height: context.responsivePadding(2)),
        ResponsiveText(
          DesignUtils.formatPhoneNumber(guest.phone),
          style: ResponsiveTextStyle.bodySmall,
          fontWeight: FontWeight.bold,
          color: AppColors.detailPanelTextColor,
          textAlign: TextAlign.center,
          fontSize: context.responsiveFontSize(12),
        ),
        SizedBox(height: context.responsivePadding(16)),
        AppCommonButton(
          text: "Add Tags",
          padding: context.isLandscape
              ? EdgeInsets.symmetric(
                  horizontal: context.responsivePadding(10),
                  vertical: context.responsivePadding(8),
                )
              : EdgeInsets.symmetric(
                  horizontal: context.responsivePadding(30),
                  vertical: context.responsivePadding(12),
                ),
          fontSize: context.responsiveFontSize(14),
          fontWeight: FontWeight.bold,
          onPressed: () {},
        ),
      ],
    );
  }
}
