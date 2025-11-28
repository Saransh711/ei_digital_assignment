import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_bloc.dart';
import 'package:ei_digital_assignment/presentation/bloc/tab_bloc/tab_state.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/detail_header.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/tab_placeholder.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/portrait/portrait_profile_tab.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/portrait/portrait_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Portrait orientation guest detail panel
class PortraitGuestDetail extends StatelessWidget {
  final Guest guest;

  const PortraitGuestDetail({super.key, required this.guest});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Padding(
        padding: EdgeInsets.all(context.responsivePadding(24)),
        child: Column(
          children: [
            SizedBox(height: context.responsivePadding(16)),
            // 1. Header Section (Icon + Title + Desc)
            Row(children: [Expanded(child: DetailHeader())]),

            SizedBox(height: context.responsivePadding(16)),
            // 2. Tab Bar
            // PortraitTabBar(),
            Row(children: [Expanded(child: PortraitTabBar())]),

            // 3. Scrollable Content
            Expanded(
              child: BlocBuilder<TabBloc, TabState>(
                builder: (context, tabState) {
                  return IndexedStack(
                    index: tabState.selectedTabIndex ?? 0,
                    children: [
                      PortraitProfileTab(guest: guest),
                      TabPlaceholder(title: 'Reservation'),
                      TabPlaceholder(title: 'Payment'),
                      TabPlaceholder(title: 'Feedback'),
                      TabPlaceholder(title: 'Order History'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
