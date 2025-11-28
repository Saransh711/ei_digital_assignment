import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/utils/design_utils.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/custom_card.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/compact_guest_info.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

/// Compact guest list item widget
class CompactGuestListItem extends StatelessWidget {
  final Guest guest;
  final bool isSelected;
  final VoidCallback? onTap;

  const CompactGuestListItem({
    super.key,
    required this.guest,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GuestCard(
      isSelected: isSelected,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: UIConstants.avatarSmall,
            height: UIConstants.avatarSmall,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.detailPanelColor,
            ),
            child: Center(
              child: ResponsiveText(
                guest.initials,
                style: ResponsiveTextStyle.labelSmall,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DesignUtils.horizontalSpace(UIConstants.spacingS),
          Expanded(
            child: CompactGuestInfo(guest: guest, isSelected: isSelected),
          ),
        ],
      ),
    );
  }
}
