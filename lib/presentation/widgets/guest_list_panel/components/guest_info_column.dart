import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Guest information column showing name, email, and phone
class GuestInfoColumn extends StatelessWidget {
  final Guest guest;
  final bool showPhone;

  const GuestInfoColumn({
    super.key,
    required this.guest,
    this.showPhone = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ResponsiveText(
          guest.name,
          style: ResponsiveTextStyle.bodyMedium,
          color: AppColors.detailPanelTextColor,
          fontWeight: FontWeight.bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontSize: context.responsiveFontSize(20),
        ),
        SizedBox(height: context.responsivePadding(UIConstants.spacingXS)),
        ResponsiveText(
          guest.email,
          style: ResponsiveTextStyle.bodySmall,
          color: AppColors.detailPanelTextColor,
          fontWeight: FontWeight.bold,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontSize: context.responsiveFontSize(14),
        ),
        if (showPhone) ...[
          SizedBox(height: context.responsivePadding(UIConstants.spacingXS)),
          ResponsiveText(
            guest.phone,
            style: ResponsiveTextStyle.bodySmall,
            color: AppColors.detailPanelTextColor,
            fontWeight: FontWeight.bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: context.responsiveFontSize(14),
          ),
        ],
      ],
    );
  }
}
