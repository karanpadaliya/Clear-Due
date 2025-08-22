import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_section.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

part 'custom_upcoming_celebration_card.dart';

class UpcomingCelebrationSection extends StatelessWidget {
  final List<TodayBirthDayEntity>? birthdays;
  const UpcomingCelebrationSection({super.key, this.birthdays});

  @override
  Widget build(BuildContext context) {
    if (birthdays == null || birthdays!.isEmpty) {
      return const SizedBox.shrink();
    }
    return CustomSection(
      title: 'upcoming_birthdays',
      subtitle: 'celebrate_someone_today',
      icon: Image.asset(
        AppAssets.quickAccessGif,
        height: 32 * Responsive.getDashboardResponsiveText(context),
      ),
      count: birthdays?.length.toString().padLeft(2, '0') ?? '0',
      hasViewMoreButton: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              birthdays
                  ?.map(
                    (birthday) => UpcomingCelebrationCard(
                      name: birthday.userFullName ?? '',
                      description:
                          '${birthday.userDesignation ?? ''}\n${birthday.blockName ?? ''}-${birthday.floorName ?? ''}',
                      imagePath: birthday.userProfilePic ?? '',
                      chipLabel: birthday.totalYearView ?? '',
                      onButtonPressed: () {},
                      cardWidth:
                          300 * Responsive.getDashboardResponsiveText(context),
                      cardPadding: EdgeInsets.zero,
                      // contentPadding: EdgeInsets.zero,
                      buttonLabel: 'Celebrate',
                      buttonBorderRadius:
                          32 * Responsive.getDashboardResponsiveText(context),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
