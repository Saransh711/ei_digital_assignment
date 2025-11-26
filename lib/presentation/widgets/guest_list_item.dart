import 'package:flutter/material.dart';
import '../../domain/entities/guest_entity.dart';
import '../../core/constants/ui_constants.dart';
import '../../core/constants/color_constants.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/utils/design_utils.dart';
import 'common/responsive_text.dart';
import 'common/custom_card.dart';

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
                  _buildAvatar(context),

                  SizedBox(width: spacing),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ResponsiveText(
                          guest.name,
                          style: ResponsiveTextStyle.bodyMedium,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(
                          height: context.responsivePadding(UIConstants.spacingXS),
                        ),

                        ResponsiveText(
                          guest.email,
                          style: ResponsiveTextStyle.bodySmall,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: context.responsivePadding(UIConstants.spacingXS),
                        ),

                        ResponsiveText(
                          guest.phone,
                          style: ResponsiveTextStyle.bodySmall,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

  Widget _buildAvatar(BuildContext context) {
    final avatarSize = context.responsiveValue(
      small: 36.0,
      medium: 40.0,
      large: 44.0,
      extraLarge: 48.0,
    );

    final avatarColor = DesignUtils.getAvatarColor(guest.name);

    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: avatarColor),
        child: Center(
          child: ResponsiveText(
            guest.initials,
            style: ResponsiveTextStyle.bodyMedium,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

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
              color: DesignUtils.getAvatarColor(guest.name),
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
            child: Column(
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
            ),
          ),
        ],
      ),
    );
  }
}
