import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_section.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/your_department/custom_department_container.dart';

class YourDepartmentSection extends StatelessWidget {
  final List<MyMemberEntity>? members;
  const YourDepartmentSection({super.key, this.members});

  @override
  Widget build(BuildContext context) {
    if (members?.isEmpty ?? true) {
      return const SizedBox.shrink();
    }
    return CustomSection(
      title: 'your_department',
      subtitle: 'make_things_happen',
      icon: Image.asset(
        AppAssets.quickAccessGif,
        height: 32 * Responsive.getDashboardResponsiveText(context),
      ),
      count: members?.length.toString().padLeft(2, '0') ?? '0',
      hasViewMoreButton: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              members
                  ?.map(
                    (member) => Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: ProfileCard(
                        imagePath: member.userProfilePic ?? '',
                        name: member.userFullName ?? '',
                        department: member.userDesignation ?? '',
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
      // child: SizedBox(
      //   width: Responsive.getWidth(context),
      //   height: 0.3 * Responsive.getHeight(context),
      //   child: ListView.builder(
      //     itemCount: 3,
      //     shrinkWrap: true,
      //     scrollDirection: Axis.horizontal,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: const EdgeInsets.only(right: 24.0),
      //         child: ProfileCard(
      //           imagePath: members?[index].userProfilePic ?? '',
      //           name: members?[index].userFullName ?? '',
      //           department: members?[index].userDesignation ?? '',
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
