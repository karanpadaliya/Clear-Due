import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/take_order/presentation/bloc/take_order_bloc.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/bottomsheet_config.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/distributor_card.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/side_by_side_buttons.dart';
import 'package:myco_flutter/widgets/big_textfield.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field.dart';

class DistributorVisitorPage extends StatefulWidget {
  const DistributorVisitorPage({super.key});

  @override
  State<DistributorVisitorPage> createState() => _DistributorVisitorPageState();
}

class _DistributorVisitorPageState extends State<DistributorVisitorPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TakeOrderBloc>().add(GetRetailerDetailsEvent());
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<TakeOrderBloc, TakeOrderState>(
    builder: (context, state) {
      // Loading State
      if (state is GetRetailerDetailsLoadingState) {
        return Scaffold(
          backgroundColor: AppTheme.getColor(context).surface,
          body: Center(child: CircularProgressIndicator()),
        );
      }

      // Error State
      if (state is GetRetailerDetailsErrorState) {
        return Scaffold(
          backgroundColor: AppTheme.getColor(context).surface,
          body: Center(child: CustomText(state.error)),
        );
      }

      if (state is GetRetailerDetailsSuccessState) {
        final retailerDetails = state.retailerDetailsEntity;
        return Scaffold(
          backgroundColor: AppTheme.getColor(context).surface,

          appBar: CustomAppbar(
            title:
                '${retailerDetails.retailerName} ${retailerDetails.retailerCode}',
          ),
          body: SingleChildScrollView(
            child: Container(
              height: Responsive.getHeight(context),
              padding: EdgeInsets.symmetric(
                horizontal: 0.08 * Responsive.getWidth(context),
              ),
              child: Column(
                children: [
                  // Visitor Details
                  DistributorCard(
                    headerHeight: 0.055 * Responsive.getHeight(context),
                    title: retailerDetails.retailerName ?? 'No Name',
                    isHeaderIconEnabled: true,
                    bottomWidget: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.04 * Responsive.getWidth(context),
                        vertical: 0.01 * Responsive.getHeight(context),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.calling,
                                width: 0.04 * Responsive.getWidth(context),
                              ),
                              SizedBox(
                                width: 0.02 * Responsive.getWidth(context),
                              ),
                              CustomText(
                                retailerDetails.retailerContactPersonNumber ??
                                    '+91 9999999999',

                                decoration: TextDecoration.underline,
                                fontSize:
                                    14 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.01 * Responsive.getHeight(context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.location,
                                width: 0.04 * Responsive.getWidth(context),
                              ),
                              SizedBox(
                                width: 0.02 * Responsive.getWidth(context),
                              ),
                              Expanded(
                                child: CustomText(
                                  retailerDetails.retailerAddress ??
                                      'A-809 World Trade Tower (WTT, Nr BMW Showroom, Sarkhej Gandhinagar Hwy, Makarba, Ahmedabad, Sarkhej-Okaf, Gujarat 380051, India',
                                  fontSize:
                                      12 *
                                      Responsive.getResponsiveText(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0.005 * Responsive.getHeight(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/take_order/geo_location.png',
                                // height: 0.01 * Responsive.getHeight(context),
                                width: 0.06 * Responsive.getWidth(context),
                              ),
                              SizedBox(
                                width: 0.01 * Responsive.getWidth(context),
                              ),
                              CustomText(
                                'get_direction',
                                decoration: TextDecoration.underline,
                                fontSize:
                                    12 * Responsive.getResponsiveText(context),
                                color: AppTheme.getColor(context).primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01 * Responsive.getHeight(context)),
                  // Timer Section
                  BlocBuilder<TakeOrderBloc, TakeOrderState>(
                    builder: (context, state) {
                      final bool isRunning = state is VisitRunning;
                      Duration duration = Duration.zero;

                      if (state is VisitRunning || state is VisitStopped) {
                        if (state is VisitRunning) {
                          duration = state.duration;
                        }
                        if (state is VisitStopped) {
                          duration = state.duration;
                        }
                      }

                      final String formatted = duration
                          .toString()
                          .split('.')
                          .first
                          .padLeft(8, '0');

                      return Container(
                        padding: EdgeInsets.all(
                          12 * Responsive.getResponsive(context),
                        ),
                        width: 0.83 * Responsive.getWidth(context),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.getColor(context).outline,
                          ),
                          // color: AppTheme.getColor(context).onPrimary,
                          borderRadius: BorderRadius.circular(
                            12 * Responsive.getResponsive(context),
                          ),
                        ),
                        child: Column(
                          children: [
                            MyCoButton(
                              onTap: () {
                                if (isRunning) {
                                  getEndVisitBottomSheet(
                                    context,
                                    onTap: () {
                                      Navigator.pop(context);

                                      context.read<TakeOrderBloc>().add(
                                        StopVisitEvent(),
                                      );
                                    },
                                  );
                                } else {
                                  getVisitPurposeBottomSheet(
                                    context,
                                    onTap: () {
                                      Navigator.pop(context);
                                      context.read<TakeOrderBloc>().add(
                                        StartVisitEvent(),
                                      );
                                    },
                                  );
                                }
                              },
                              title: isRunning
                                  ? LanguageManager().get('stop')
                                  : LanguageManager().get('start'),
                              width: 0.2 * Responsive.getWidth(context),
                              height: 0.035 * Responsive.getHeight(context),
                              backgroundColor: AppTheme.getColor(
                                context,
                              ).secondary,
                              boarderRadius:
                                  30 * Responsive.getResponsive(context),
                              borderColor: AppTheme.getColor(context).secondary,
                              isShadowBottomLeft: true,
                              image: isRunning
                                  ? SvgPicture.asset(
                                      AppAssets.stop,
                                      width:
                                          0.05 * Responsive.getWidth(context),
                                    )
                                  : SvgPicture.asset(
                                      AppAssets.start,
                                      width:
                                          0.03 * Responsive.getWidth(context),
                                    ),

                              spacing: 3 * Responsive.getResponsive(context),
                            ),

                            if (state is VisitRunning || state is VisitStopped)
                              isRunning
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:
                                              0.08 *
                                              Responsive.getWidth(context),
                                        ),
                                        CustomText(
                                          textAlign: TextAlign.center,
                                          formatted,
                                          fontSize:
                                              14 *
                                              Responsive.getResponsiveText(
                                                context,
                                              ),
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.getColor(
                                            context,
                                          ).primary,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.refresh,
                                            color: AppTheme.getColor(
                                              context,
                                            ).primary,
                                            size:
                                                20 *
                                                Responsive.getResponsive(
                                                  context,
                                                ),
                                          ),
                                          onPressed: () {
                                            context.read<TakeOrderBloc>().add(
                                              RefreshTimerEvent(),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            isRunning
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height:
                                        0.01 * Responsive.getHeight(context),
                                  ),
                            CustomText(
                              'click_on_start',
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              color: AppColors.error,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                  // 3 UI navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getCommonColumn(
                        context,
                        imagePath: AppAssets.placeOrder,
                        name: 'place_order',
                        onTap: () {
                          context.pushNamed(RoutePaths.takeOrder);
                        },
                      ),
                      getCommonColumn(
                        context,
                        imagePath: AppAssets.orderHistory,
                        name: 'order_history',
                        onTap: () {
                          context.pushNamed(RoutePaths.orderHistory);
                        },
                      ), //show error in assets
                      getCommonColumn(
                        context,
                        imagePath: AppAssets.noOrder,
                        name: 'no_order',
                        onTap: () {
                          context.pushNamed(RoutePaths.noOrder);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                  // Details
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8 * Responsive.getResponsive(context),
                      horizontal: 12 * Responsive.getResponsive(context),
                    ),
                    width: 0.83 * Responsive.getWidth(context),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.getColor(context).outline,
                      ),
                      borderRadius: BorderRadius.circular(
                        12 * Responsive.getResponsive(context),
                      ),
                    ),
                    child: Column(
                      children: [
                        getCommonRow(
                          context,
                          title: 'category',
                          value: retailerDetails.customerCategoryName ?? 'CHPL',
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        getCommonRow(
                          context,
                          title: 'area',
                          value: retailerDetails.areaName ?? '-',
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        getCommonRow(
                          context,
                          title: 'gst',
                          value: retailerDetails.retailerGstNo ?? '-',
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        getCommonRow(
                          context,
                          title: 'retailer_code',
                          value: retailerDetails.retailerCode ?? 'RT43575',
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        getCommonRow(
                          context,
                          title: 'credit_days',
                          value: retailerDetails.retailerCreditDays ?? '0',
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        getCommonRow(
                          context,
                          title: 'credit_limit',
                          value: retailerDetails.retailerCreditLimit ?? '0.00',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.01 * Responsive.getHeight(context)),
                  // Distributor List
                  Expanded(
                    child: ListView.separated(
                      itemCount: retailerDetails.distributors?.length ?? 0,
                      itemBuilder: (context, index) {
                        final distributor =
                            retailerDetails.distributors?[index];
                        return DistributorCard(
                          headerHeight: 0.055 * Responsive.getHeight(context),
                          title: 'distributor',
                          isButton: true,
                          buttonText: LanguageManager().get('change'),
                          onTap: () {
                            context.pushNamed(RoutePaths.allDistributor);
                          },
                          bottomWidget: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8 * Responsive.getResponsive(context),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 0.01 * Responsive.getWidth(context),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        distributor?.distributorName ??
                                            'Mukund (M77)',
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            16 *
                                            Responsive.getResponsiveText(
                                              context,
                                            ),
                                      ),
                                      Transform.scale(
                                        scale: 0.7,
                                        child: Radio(
                                          value: true,
                                          groupValue: '',
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        6.0 * Responsive.getResponsive(context),
                                  ),
                                  child: CustomText(
                                    'contact_person : ${distributor?.distributorContactPerson} (${distributor?.distributorContactPersonNumber})',
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.01 * Responsive.getHeight(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 0.01 * Responsive.getResponsive(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppTheme.getColor(context).surface,
        body: const Center(child: CustomText('Something Went Wrong')),
      );
    },
  );

  Future<dynamic> getEndVisitBottomSheet(
    BuildContext context, {
    required VoidCallback onTap,
  }) => getBottomSheet(
    context,
    Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.08 * Responsive.getWidth(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12 * Responsive.getResponsive(context),
        ),
        // color: AppTheme.getColor(context).onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.03 * Responsive.getHeight(context)),
          CustomText(
            'remark',
            fontSize: 14 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 0.01 * Responsive.getHeight(context)),
          BigMyCoTextField(
            hintText: LanguageManager().get('type_here'),
            prefixImage: SvgPicture.asset(
              AppAssets.messageEdit,
              colorFilter: ColorFilter.mode(
                AppTheme.getColor(context).primary,
                BlendMode.srcIn,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.getColor(context).outline),
              borderRadius: BorderRadius.circular(
                12 * Responsive.getResponsive(context),
              ),
            ),
          ),

          SizedBox(height: 0.02 * Responsive.getHeight(context)),

          SideBySideButtons(
            button1Name: LanguageManager().get('close'),
            button2Name: LanguageManager().get('end_visit'),
            onTap1: () {},
            onTap2: onTap,
          ),
          SizedBox(height: 0.03 * Responsive.getHeight(context)),
        ],
      ),
    ),
  );

  Future<dynamic> getVisitPurposeBottomSheet(
    BuildContext context, {
    required VoidCallback onTap,
  }) => getBottomSheet(
    context,
    Container(
      // color: AppTheme.getColor(context).onPrimary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.08 * Responsive.getWidth(context),
                  vertical: 0.01 * Responsive.getHeight(context),
                ),
                width: Responsive.getWidth(context),
                height: 0.05 * Responsive.getHeight(context),
                decoration: BoxDecoration(
                  color: AppTheme.getColor(context).primary,
                ),
                child: CustomText(
                  'visit_purpose',
                  color: AppTheme.getColor(context).onPrimary,
                  fontSize: 20 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Inner shadow simulation using a white gradient
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.3), // top white fade
                          Colors.transparent, // fade to transparent
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.08 * Responsive.getWidth(context),
            ),
            child: MyCoTextfield(
              hintText: LanguageManager().get('search'),
              isSuffixIconOn: true,
              image1: 'assets/take_order/microphone-2.png',
              preFixImage: 'assets/take_order/search-normal.png',
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.02 * Responsive.getWidth(context),
            ),
            child: Column(
              children: [
                RadioListTile(
                  radioScaleFactor: 0.7,
                  value: true,
                  groupValue: 'groupValue',
                  onChanged: (value) {},
                  title: CustomText(
                    'Vendor Closed',
                    fontSize: 18 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioListTile(
                  radioScaleFactor: 0.7,

                  value: true,
                  groupValue: 'groupValue',
                  onChanged: (value) {},
                  title: CustomText(
                    'Shop Closed',
                    fontSize: 18 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioListTile(
                  radioScaleFactor: 0.7,

                  value: true,
                  groupValue: 'groupValue',
                  onChanged: (value) {},
                  title: CustomText(
                    'Approved',
                    fontSize: 18 * Responsive.getResponsiveText(context),
                    color: AppTheme.getColor(context).primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 0.01 * Responsive.getHeight(context)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 0.08 * Responsive.getWidth(context),
            ),
            child: SideBySideButtons(
              button1Name: LanguageManager().get('close'),
              button2Name: LanguageManager().get('done'),
              onTap1: () {},
              onTap2: onTap,
            ),
          ),
          SizedBox(height: 0.03 * Responsive.getHeight(context)),
        ],
      ),
    ),
  );

  Row getCommonRow(
    BuildContext context, {
    required String title,
    required String value,
  }) => Row(
    children: [
      Expanded(
        flex: 5,
        child: CustomText(
          title,
          fontWeight: FontWeight.w700,
          fontSize: 15 * Responsive.getResponsiveText(context),
        ),
      ),
      const CustomText(':'),
      SizedBox(width: 0.03 * Responsive.getWidth(context)),
      Expanded(
        flex: 5,
        child: CustomText(
          value,
          fontSize: 15 * Responsive.getResponsiveText(context),
          color: AppTheme.getColor(context).outline,
        ),
      ),
    ],
  );

  InkWell getCommonColumn(
    BuildContext context, {
    required String imagePath,
    required String name,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(imagePath, width: 0.13 * Responsive.getWidth(context)),
        SizedBox(height: 0.03 * Responsive.getWidth(context)),
        CustomText(
          name,
          fontWeight: FontWeight.bold,
          fontSize: 16 * Responsive.getResponsiveText(context),
        ),
      ],
    ),
  );
}
