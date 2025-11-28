import 'package:ei_digital_assignment/core/constants/color_constants.dart';
import 'package:ei_digital_assignment/core/extensions/context_extensions.dart';
import 'package:ei_digital_assignment/presentation/widgets/common/responsive_text.dart';
import 'package:flutter/material.dart';

/// Form fields section showing loyalty number, customer since, birthday, and anniversary
class FormFields extends StatelessWidget {
  const FormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildInlineField(context, "Loyalty No", "RF|", isValueBold: true),
        SizedBox(height: context.responsivePadding(12)),
        _buildInlineField(context, "Since", "Enter"),
        SizedBox(height: context.responsivePadding(12)),
        _buildInlineField(
          context,
          "Birthday",
          "Enter",
          icon: Icons.cake_outlined,
        ),
        SizedBox(height: context.responsivePadding(12)),
        _buildInlineField(
          context,
          "Anniversary",
          "Enter",
          icon: Icons.celebration_outlined,
        ),
      ],
    );
  }

  Widget _buildInlineField(
    BuildContext context,
    String label,
    String value, {
    IconData? icon,
    bool isValueBold = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsivePadding(10),
        horizontal: context.responsivePadding(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 6, medium: 7, large: 8, extraLarge: 9),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: ResponsiveText(
                    label,
                    style: ResponsiveTextStyle.bodySmall,
                    color: AppColors.detailPanelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontSize(14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (icon != null) ...[
                  SizedBox(width: context.responsivePadding(6)),
                  Icon(
                    icon,
                    size: context.responsiveValue(
                      small: 14,
                      medium: 16,
                      large: 18,
                      extraLarge: 20,
                    ),
                    color: AppColors.textSecondary,
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ResponsiveText(
                  value,
                  fontWeight: isValueBold ? FontWeight.bold : FontWeight.normal,
                  color: isValueBold
                      ? AppColors.detailPanelTextColor
                      : AppColors.detailPanelColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
