import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/delete_nominee_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_common_row.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/common_card.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class NomineeDetailsPage extends StatelessWidget {
  const NomineeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'Nominees'),

    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: CommonCard(
            title: 'Nominees',
            suffixIcon: Row(
              spacing: 10,
              children: [
        
                SvgPicture.asset(AppAssets.edit2Icon),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      builder: (context) => const DeleteNomineeBottomSheet(),
                    );
                  },
                  child: SvgPicture.asset(AppAssets.trashIcon),
                ),
              ],
            ),

            bottomWidget: Container(
              padding: EdgeInsets.all(12 * Responsive.getResponsive(context)),
              child: Column(
                children: [
                  CommonRow(
                    title: LanguageManager().get('nomination_for'),
                    value: 'Yash Soni',
                  ),
                  CommonRow(
                    title: LanguageManager().get('employee_name'),
                    value: 'Manish Chandra',
                  ),
                  CommonRow(
                    title: LanguageManager().get('nominee_name'),
                    value: 'Bg',
                  ),
                  CommonRow(
                    title: LanguageManager().get('nominee_relation'),
                    value: 'Jub d',
                  ),
                  CommonRow(
                    title: LanguageManager().get('aadhar_number'),
                    value: '935387853834',
                  ),
                  CommonRow(
                    title: LanguageManager().get('mobile_number'),
                    value: '9043248873',
                  ),
                  CommonRow(
                    title: LanguageManager().get('email_address'),
                    value: 'test@chpl.org',
                  ),
                  CommonRow(
                    title: LanguageManager().get('address'),
                    value: 'Wtt Sarkhej',
                  ),
                  CommonRow(
                    title: LanguageManager().get('percentage'),
                    value: '68',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    floatingActionButton: MyCoButton(
      isShadowBottomLeft: true,
      onTap: () {
        context.push('/add_nominess');
      },

      height: 0.080 * Responsive.getHeight(context),
      width: 0.080 * Responsive.getHeight(context),
      title: '',
      boarderRadius: VariableBag.buttonBorderRadius,
      // image: Icon(
      //   Icons.add,
      //   color: AppTheme.getColor(context).onPrimary,
      //   size: 50,
      // ),
      image: Icon(
        Icons.add,
        size: 50,
        color: AppTheme.getColor(context).onPrimary,
      ),
    ),
  );
}
