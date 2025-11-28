import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/core/utils/design_utils.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Compact guest information for compact list items
class CompactGuestInfo extends StatelessWidget {
  final Guest guest;
  final bool isSelected;

  const CompactGuestInfo({
    super.key,
    required this.guest,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ResponsiveText(
          guest.name,
          style: ResponsiveTextStyle.bodySmall,
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
        ),
        if (guest.hasUpcomingVisits) ...[
          DesignUtils.verticalSpace(UIConstants.spacingXS),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: context.responsiveFontSize(10),
                color: AppColors.primary,
              ),
              DesignUtils.horizontalSpace(UIConstants.spacingXS),
              ResponsiveText(
                '${guest.upcomingVisits}',
                style: ResponsiveTextStyle.labelSmall,
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

