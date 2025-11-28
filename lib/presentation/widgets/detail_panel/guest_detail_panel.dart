import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/landscape/landscape_guest_detail.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/portrait/portrait_guest_detail.dart';
import 'package:flutter/material.dart';

/// Guest detail panel that decides between portrait and landscape layouts
class GuestDetailPanel extends StatelessWidget {
  final Guest guest;

  const GuestDetailPanel({super.key, required this.guest});

  @override
  Widget build(BuildContext context) {
    if (context.isLandscape) {
      return LandscapeGuestDetail(guest: guest);
    } else {
      return PortraitGuestDetail(guest: guest);
    }
  }
}
