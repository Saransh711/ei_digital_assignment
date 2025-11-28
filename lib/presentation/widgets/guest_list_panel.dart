import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/panel_header.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/components/search_bar.dart';
import 'package:ei_digital_assignment/presentation/widgets/guest_list_panel/guest_list_content.dart';
import 'package:flutter/material.dart';

/// Main guest list panel widget
/// Routes to appropriate components based on layout constraints
class GuestListPanel extends StatelessWidget {
  const GuestListPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // If width is too small, return empty container to prevent overflow
        if (availableWidth < 150) {
          return const SizedBox.shrink();
        }

        return Container(
          color: AppColors.surface,
          width: availableWidth,
          constraints: BoxConstraints(minWidth: 0, maxWidth: availableWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PanelHeader(),

              const GuestSearchBar(),

              Expanded(child: GuestListContent()),
            ],
          ),
        );
      },
    );
  }
}
