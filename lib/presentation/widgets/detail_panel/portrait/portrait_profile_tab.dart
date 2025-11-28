import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/domain/entities/guest_entity.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/allergies_card.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/main_summary_card.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/notes_section.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/section_card.dart';
import 'package:ei_digital_assignment/presentation/widgets/detail_panel/components/upcoming_visits_card.dart';
import 'package:flutter/material.dart';

/// Portrait orientation profile tab content
class PortraitProfileTab extends StatelessWidget {
  final Guest guest;

  const PortraitProfileTab({super.key, required this.guest});

  @override
  Widget build(BuildContext context) {
    final sectionSpacing = context.responsivePadding(20);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Main White Card (Profile + Stats)
          PortraitMainSummaryCard(guest: guest),
          SizedBox(height: sectionSpacing),

          // 2. Allergies & Upcoming Visits
          AllergiesCard(),
          SizedBox(height: context.responsivePadding(16)),
          UpcomingVisitsCard(),
          SizedBox(height: sectionSpacing),

          // 3. Notes
          NotesSection(),
          SizedBox(height: sectionSpacing),

          // 4. Recent Orders
          SectionCard(
            title: "RECENT ORDERS",
            icon: Icons.restaurant_menu,
            emptyText: "No Recent Orders to Show",
          ),
          SizedBox(height: sectionSpacing),

          // 5. Online Reviews
          SectionCard(
            title: "ONLINE REVIEWS",
            icon: Icons.chat_bubble_outline,
            emptyText: "No Online Review to Show",
          ),
        ],
      ),
    );
  }
}
