import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/customer_page_custom_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/floating_action_btn.dart';

class CustomerPage extends StatelessWidget {
  CustomerPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customerCardList = [
      {
        'title': 'Ganesh Auto Garage (RT4982)',
        'buttonName': 'no_order',
        'headerColor': AppTheme.getColor(context).primary,
        'isOnlyVisit': false,
        'isOrderTaken': false,
      },
      {
        'title': 'Ganesh Auto Garage (RT4982)',
        'buttonName': 'order_taken',
        'headerColor': AppTheme.getColor(context).secondary,
        'isOnlyVisit': false,
        'isOrderTaken': true,
      },
      {
        'title': 'Ganesh Auto Garage (RT4982)',
        'buttonName': 'only_visit',
        'headerColor': AppColors.spanishYellow,
        'isOnlyVisit': true,
        'isOrderTaken': false,
      },
      {
        'title': 'Ganesh Auto Garage (RT4982)',
        'buttonName': 'no_order',
        'headerColor': AppTheme.getColor(context).primary,
        'isOnlyVisit': false,
        'isOrderTaken': false,
      },
      {
        'title': 'Ganesh Auto Garage (RT4982)',
        'buttonName': 'only_visit',
        'headerColor': AppColors.spanishYellow,
        'isOnlyVisit': true,
        'isOrderTaken': false,
      },
    ];
    return Scaffold(
      appBar: CustomAppbar(
        title: 'customer',
        isKey: true,
        actions: [
          MyCoButton(
            title: 'refresh',
            onTap: () {},
            width: 0.20 * Responsive.getWidth(context),
            height: 0.038 * Responsive.getHeight(context),
            backgroundColor: AppTheme.getColor(context).secondary,
            textStyle: TextStyle(
              color: AppTheme.getColor(context).onSecondary,
              fontSize: 12 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
            boarderRadius:
                VariableBag.buttonBorderRadius *
                Responsive.getResponsive(context),
            borderColor: AppTheme.getColor(context).secondary,
            isShadowBottomLeft: true,
          ),
          SizedBox(
            width:
                VariableBag.buttonRowSpacing *
                Responsive.getResponsive(context),
          ),
          MyCoButton(
            title: 'reset',
            onTap: () {},
            width: 0.20 * Responsive.getWidth(context),
            height: 0.038 * Responsive.getHeight(context),
            backgroundColor: AppColors.primary,
            textStyle: TextStyle(
              color: AppTheme.getColor(context).onSecondary,
              fontSize: 12 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
            ),
            boarderRadius:
                VariableBag.buttonBorderRadius *
                Responsive.getResponsive(context),
            isShadowBottomLeft: true,
          ),
          SizedBox(
            width:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.commonCardHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchField(
                controller: searchController,
                hintText: 'search',
              ),
              SizedBox(
                height:
                    VariableBag.searchFiledAfterSpace *
                    Responsive.getResponsive(context),
              ),

              /// Cards
              Column(
                spacing:
                    VariableBag.commonCardVerticalPadding *
                    Responsive.getResponsive(context),
                children: customerCardList
                    .map(
                      (customer) => Column(
                        children: [
                          CustomerCard(
                            title: customer['title'],
                            buttonName: customer['buttonName'],
                            headerColor: customer['headerColor'],
                            isOnlyVisit: customer['isOnlyVisit'],
                            isOrderTaken: customer['isOrderTaken'],
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        innericonsize: 30 * Responsive.getResponsive(context),
        imageSize: 70 * Responsive.getResponsive(context),
        onTap: () {
          context.pushNamed('add-customer');
        },
        openIcon: Icons.add,
        closeIcon: Icons.close,
        actions: const [],
      ),
    );
  }
}
