import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

/// Guest avatar widget showing initials or image
class GuestAvatar extends StatelessWidget {
  final Guest guest;
  final double? size;

  const GuestAvatar({super.key, required this.guest, this.size});

  @override
  Widget build(BuildContext context) {
    final avatarSize =
        size ??
        context.responsiveValue(
          small: 36.0,
          medium: 40.0,
          large: 44.0,
          extraLarge: 48.0,
        );

    final rawImageUrl = (guest.avatarUrl)?.trim();
    final imageUrl = rawImageUrl != null && rawImageUrl.isNotEmpty
        ? rawImageUrl
        : null;

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: imageUrl != null
            ? Colors.transparent
            : AppColors.detailPanelColor,
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
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
    );
  }
}
