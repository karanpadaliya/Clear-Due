import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/my_team/custom_myteam.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_section.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';

class MyTeamSection extends StatelessWidget {
  final List<MyTeamEntity>? myTeam;

  const MyTeamSection({super.key, this.myTeam});

  @override
  Widget build(BuildContext context) {
    if (myTeam == null || myTeam!.isEmpty) {
      return const SizedBox.shrink();
    }
    return CustomSection(
      title: 'my_team',
      subtitle: 'make_it_happen',
      icon: Image.asset(
        AppAssets.quickAccessGif,
        height: 32 * Responsive.getDashboardResponsiveText(context),
      ),
      hasViewMoreButton: true,
      count: myTeam!.length.toString().padLeft(2, '0'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: BorderContainerWraper(
        // Center the widget to match the Figma design
        child: Center(
          child: OverlappingPeopleCard(
            people: List.generate(myTeam!.length > 4 ? 4 : myTeam!.length, (
              index,
            ) {
              final teamMember = myTeam![index];

              // Split the full name into first and last name for proper display
              final List<String>? names = teamMember.userFullName?.split(' ');
              final String firstName = names!.isNotEmpty ? names[0] : '';
              final String lastName = names.length > 1
                  ? names.sublist(1).join(' ')
                  : '';

              // NOTE: The 'isActive' field is not in 'MyTeamEntity'.
              // Using placeholder logic. You should replace this with your actual data.
              final bool isActive = index == 0 || index == 2 || index == 3;

              return PersonData(
                firstName: firstName,
                lastName: lastName,
                imagePath: teamMember.userProfilePic ?? '',
                isActive: isActive,
              );
            }),
          ),
        ),
      ),
    );
  }
}
