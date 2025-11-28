import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Notes section showing various note categories
class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsivePadding(24)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 10,
            medium: 11,
            large: 12,
            extraLarge: 13,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText(
            "NOTES",
            style: ResponsiveTextStyle.labelSmall,
            fontWeight: FontWeight.bold,
            color: AppColors.textTertiary,
            fontSize: context.responsiveFontSize(14),
          ),
          SizedBox(height: context.responsivePadding(8)),
          _buildNoteItem(
            context,
            Icons.sticky_note_2_outlined,
            "General",
            "Add notes",
          ),
          _buildDivider(),
          _buildNoteItem(
            context,
            Icons.star_border,
            "Special Relation",
            "Add notes",
          ),
          _buildDivider(),
          _buildNoteItem(
            context,
            Icons.chair_outlined,
            "Seating Preferences",
            "Add notes",
          ),
          _buildDivider(),
          _buildNoteItem(
            context,
            Icons.edit_note,
            "Special Note*",
            "Add notes",
          ),
          _buildDivider(),
          _buildNoteItem(
            context,
            Icons.warning_amber_rounded,
            "Allergies",
            "Add notes",
          ),
        ],
      ),
    );
  }

  Widget _buildNoteItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.responsivePadding(12)),
      child: Row(
        children: [
          Icon(
            icon,
            size: context.responsiveValue(
              small: 20,
              medium: 22,
              large: 24,
              extraLarge: 26,
            ),
            color: AppColors.textPrimary,
          ),
          SizedBox(width: context.responsivePadding(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText(
                title,
                style: ResponsiveTextStyle.bodyMedium,
                fontWeight: FontWeight.bold,
                fontSize: context.responsiveFontSize(16),
              ),
              SizedBox(height: context.responsivePadding(2)),
              ResponsiveText(
                subtitle,
                style: ResponsiveTextStyle.bodySmall,
                color: AppColors.textTertiary,
                fontSize: context.responsiveFontSize(14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.5));
  }
}
