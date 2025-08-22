import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/ui/custom_toggle_switch.dart';

class NotificationSoundSettingCard extends StatelessWidget {
  final bool isSwitched;
  final ValueChanged<bool> onToggle;

  const NotificationSoundSettingCard({
    required this.isSwitched,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      height: isSwitched
          ? 85 * Responsive.getResponsive(context)
          : 80 * Responsive.getResponsive(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.getColor(context).outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0 * Responsive.getResponsive(context),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/images/note-favorite.svg',
              width: 30 * Responsive.getResponsive(context),
              height: 35 * Responsive.getResponsive(context),
            ),
            SizedBox(width: 0.015 * Responsive.getHeight(context)),
            CustomText(
              'attendance',
              fontSize: 12 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).onSurface,
            ),
            const Spacer(),
            CustomToggleSwitch(
              initialValue: isSwitched,
              showLabelBelowOnOnState: true,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    ),
  );
}
