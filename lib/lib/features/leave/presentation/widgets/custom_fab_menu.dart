// custom_fab_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class FabMenuItem {
  final VoidCallback onTap;
  final Widget icon;
  final String label;

  FabMenuItem({required this.onTap, required this.icon, required this.label});
}

class CustomFabMenu extends StatelessWidget {
  final List<FabMenuItem> items;
  final String heroTagOpen;
  final String closeTitle;
  final Key? keyFab;

  const CustomFabMenu({
    required this.items,
    super.key,
    this.keyFab,
    this.heroTagOpen = 'fab_open',
    this.closeTitle = 'close',
  });

  @override
  Widget build(BuildContext context) => ExpandableFab(
    key: keyFab,
    type: ExpandableFabType.up,
    openCloseStackAlignment: Alignment.bottomRight,
    childrenAnimation: ExpandableFabAnimation.none,
    duration: const Duration(milliseconds: 300),
    overlayStyle: ExpandableFabOverlayStyle(
      color: AppTheme.getColor(
        context,
      ).tertiaryContainer.withValues(alpha: 0.5),
    ),

    closeButtonBuilder: FloatingActionButtonBuilder(
      size: 2,
      builder: (context, onPressed, progress) {
        final curvedAnimation = CurvedAnimation(
          parent: progress,
          curve: Curves.easeInOutCubic,
        );
        return IgnorePointer(
          ignoring: progress.value == 0,
          child: AnimatedBuilder(
            animation: curvedAnimation,
            builder: (context, child) => MyCoButton(
              isShadowBottomLeft: true,
              boarderRadius: 50,
              width:
                  (0.2 + (0.3 - 0.2) * curvedAnimation.value) *
                  Responsive.getWidth(context),
              height: 0.18 * Responsive.getWidth(context),
              onTap: onPressed,
              image: Hero(
                tag: heroTagOpen,
                child: Icon(
                  Icons.close,
                  size: 0.07 * Responsive.getWidth(context),
                  color: AppTheme.getColor(context).surface,
                ),
              ),
              textStyle: TextStyle(
                fontSize: 16 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).surface,
                fontWeight: FontWeight.w500,
              ),
              title: LanguageManager().get(closeTitle),
            ),
          ),
        );
      },
    ),

    openButtonBuilder: FloatingActionButtonBuilder(
      size: 0,
      builder: (context, onPressed, progress) {
        final curvedAnimation = CurvedAnimation(
          parent: progress,
          curve: Curves.easeInOutCubic,
        );

        return IgnorePointer(
          ignoring: progress.value == 1,
          child: AnimatedBuilder(
            animation: curvedAnimation,
            builder: (context, child) => MyCoButton(
              isShadowBottomLeft: true,
              boarderRadius: 50,
              width:
                  (0.18 + (0.3 - 0.18) * curvedAnimation.value) *
                  Responsive.getWidth(context),
              height: 0.18 * Responsive.getWidth(context),
              onTap: onPressed,
              title: '',
              image: Icon(
                Icons.add,
                color: AppTheme.getColor(context).surface,
                size: 0.1 * Responsive.getWidth(context),
              ),
            ),
          ),
        );
      },
    ),

    children: items
        .map(
          (item) => InkWell(
            onTap: item.onTap,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.getColor(context).surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(LanguageManager().get(item.label)),
                ),
                SizedBox(width: 0.02 * Responsive.getWidth(context)),
                FloatingActionButton.small(
                  heroTag: null,
                  onPressed: null,
                  child: item.icon,
                ),
              ],
            ),
          ),
        )
        .toList(),
  );
}
