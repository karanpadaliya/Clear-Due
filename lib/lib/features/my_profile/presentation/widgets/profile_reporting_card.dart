import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/circle_image_employee_card.dart';

class ProfileReportingCard extends StatelessWidget {
  final List reportingPersonsList;

  const ProfileReportingCard({super.key, required this.reportingPersonsList});

  @override
  Widget build(BuildContext context) => CommonCard(
    title: LanguageManager().get('reporting_person'),
    bottomWidget: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: VariableBag.commonCardHorizontalPadding * Responsive.getResponsive(context),
        vertical: VariableBag.commonCardVerticalPadding * Responsive.getResponsive(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: 10 * Responsive.getResponsive(context),
                right: 10 * Responsive.getResponsive(context),
                bottom: 10 * Responsive.getResponsive(context),
                left: 10 * Responsive.getResponsive(context),
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.getGridConfig(context).itemCount,
                mainAxisSpacing: Responsive.getGridConfig(context).spacing,
                crossAxisSpacing: Responsive.getGridConfig(context).spacing,
                childAspectRatio: 2 / 2.7,
              ),
              itemCount: reportingPersonsList.length,
              // example count
              itemBuilder: (context, index) {
                final ReportingPersonEntity reportingPerson =
                    reportingPersonsList[index];
                return CircleImageEmployeeCard(
                  imageWidget: CachedImage(
                    imageProvider: NetworkImage(
                      reportingPerson.reportingPersonProfilePic.toString(),
                    ),
                  ),
                  name: reportingPerson.reportingPersonLevelName.toString(),
                  department: reportingPerson.reportingPersonUserDesignation
                      .toString(),
                  isSelected: false,
                );
              },
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    ),
  );
}
