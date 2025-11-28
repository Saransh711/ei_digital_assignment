import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/constants/ui_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/guest_avatar.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/guest_info_column.dart';
import 'package:flutter/material.dart';

/// Main guest list item widget
class GuestListItem extends StatelessWidget {
  final Guest guest;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showDetails;

  const GuestListItem({
    super.key,
    required this.guest,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // If width is too small, return minimal widget to prevent overflow
        if (availableWidth < 100) {
          return const SizedBox.shrink();
        }

        final horizontalPadding = availableWidth > 200
            ? context.responsivePadding(UIConstants.spacingM)
            : context.responsivePadding(UIConstants.spacingS);
        final spacing = availableWidth > 200
            ? context.responsivePadding(UIConstants.spacingS)
            : context.responsivePadding(UIConstants.spacingXS);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              constraints: BoxConstraints(
                minWidth: 0,
                maxWidth: availableWidth,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: context.responsivePadding(UIConstants.spacingS),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.textPrimary.withValues(alpha: 0.05)
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GuestAvatar(guest: guest),
                  SizedBox(width: spacing),
                  Expanded(
                    child: GuestInfoColumn(
                      guest: guest,
                      showPhone: showDetails,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

