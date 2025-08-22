import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/take_order/presentation/bloc/take_order_bloc.dart';
import 'package:myco_flutter/features/take_order/presentation/pages/frequent_buy_screen.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/frequent_buy_card.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/shimmer_loading.dart';
import 'package:myco_flutter/features/take_order/presentation/widgets/side_by_side_buttons.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// ignore: must_be_immutable
class TakeOrderPage extends StatefulWidget {
  const TakeOrderPage({super.key});

  @override
  State<TakeOrderPage> createState() => _TakeOrderPageState();
}

class _TakeOrderPageState extends State<TakeOrderPage> {
  List<Widget> screens = [AllProductsScreenV1(), const FrequentsBuyScreen()];

  @override
  void initState() {
    super.initState();
    Future.microtask(loadData);
  }

  void loadData() {
    context.read<TakeOrderMainBloc>().add(GetProductCategoryEvent());
    context.read<FrequentProductsBloc>().add(GetFrequentProductsEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      title: LanguageManager().get('take_order'),
      actions: [
        MyCoButton(
          onTap: () {},
          title: LanguageManager().get('refresh'),
          textStyle: AppTheme.getTextStyle(
            context,
          ).labelMedium!.copyWith(color: AppTheme.getColor(context).onPrimary),
          width: 0.17 * Responsive.getWidth(context),
          height: 0.028 * Responsive.getHeight(context),
          boarderRadius: 20 * Responsive.getResponsive(context),
          isShadowBottomLeft: true,
        ),
        SizedBox(width: 0.01 * Responsive.getWidth(context)),
        Stack(
          alignment: const AlignmentGeometry.directional(1.7, -2.5),
          children: [
            MyCoButton(
              onTap: () {
                context.pushNamed(RoutePaths.offers);
              },
              title: LanguageManager().get('offer'),
              textStyle: AppTheme.getTextStyle(context).labelMedium!.copyWith(
                color: AppTheme.getColor(context).onPrimary,
              ),
              backgroundColor: AppTheme.getColor(context).secondary,
              width: 0.17 * Responsive.getWidth(context),
              height: 0.028 * Responsive.getHeight(context),
              boarderRadius: 20 * Responsive.getResponsive(context),
              borderColor: AppTheme.getColor(context).secondary,
              isShadowBottomLeft: true,
            ),
            Container(
              height: 0.02 * Responsive.getHeight(context),
              width: 0.1 * Responsive.getWidth(context),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: SvgPicture.asset(
                // 'assets/take_order/offer.png',
                AppAssets.offers,
              ),
            ),
          ],
        ),
        SizedBox(width: 0.02 * Responsive.getWidth(context)),
        SvgPicture.asset(
          // 'assets/take_order/cart.png',
          AppAssets.cart,
          width: 0.06 * Responsive.getWidth(context),
        ),
        SizedBox(width: 0.06 * Responsive.getWidth(context)),
      ],
    ),
    body: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.08 * Responsive.getWidth(context),
      ),
      child: Column(
        children: [
          SizedBox(height: 0.01 * Responsive.getHeight(context)),
          BlocBuilder<TabbarBloc, TabbarState>(
            builder: (context, state) {
              final selectedIndex = state is TabChangeState
                  ? state.selectedIndex
                  : 0;
              return MyCustomTabBar(
                tabs: [
                  LanguageManager().get('all_product'),
                  LanguageManager().get('frequent_buy'),
                ],
                selectedBgColors: [
                  AppTheme.getColor(context).primary,
                  AppTheme.getColor(context).secondary,
                ],

                unselectedBorderAndTextColor: AppTheme.getColor(
                  context,
                ).onPrimary,
                tabBarBorderColor: selectedIndex == 0
                    ? AppTheme.getColor(context).primary
                    : AppTheme.getColor(context).secondary,
                tabBarBackgroundColor: AppTheme.getColor(context).surface,
                isShadowBottomLeft: true,
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  context.read<TabbarBloc>().add(TabChangeEvent(index: index));
                },
              );
            },
          ),

          SizedBox(height: 0.015 * Responsive.getHeight(context)),
          Expanded(
            child: BlocBuilder<TabbarBloc, TabbarState>(
              builder: (context, state) {
                final selectedIndex = state is TabChangeState
                    ? state.selectedIndex
                    : 0;
                return screens[selectedIndex];
              },
            ),
          ),
        ],
      ),
    ),
  );
}

// ignore: must_be_immutable
class AllProductsScreenV1 extends StatelessWidget {
  const AllProductsScreenV1({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TakeOrderMainBloc, TakeOrderMainState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const ShimmerLoading(loadingFor: 'v1');
          }

          if (state.error.isNotEmpty) {
            return Center(child: Text(state.error));
          }

          final productCategory =
              state.getProductCategoryEntity.productCategories ?? [];

          if (productCategory.isEmpty && state.isLoading == false) {
            return Center(child: Text(LanguageManager().get('no_data')));
          }

          return Column(
            children: [
              // Search Field
              CustomSearchField(hintText: 'Search', onChanged: (value) {}),

              SizedBox(height: 0.025 * Responsive.getHeight(context)),

              Expanded(
                child: ListView.separated(
                  itemCount: productCategory.length, // productList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => context.pushNamed(
                      RoutePaths.products,
                      extra: productCategory[index].products,
                    ),
                    child: Container(
                      height: 0.055 * Responsive.getHeight(context),
                      width: Responsive.getWidth(context),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.getColor(context).outline,
                        ),
                        borderRadius: BorderRadius.circular(
                          12 * Responsive.getResponsive(context),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10.0 * Responsive.getResponsive(context),
                          ),
                          child: CustomText(
                            productCategory[index].categoryName,
                            textAlign: TextAlign.justify,
                            color: AppTheme.getColor(context).primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 0.01 * Responsive.getHeight(context)),
                ),
              ),
            ],
          );
        },
      );
}

class AllProductsScreenV2 extends StatefulWidget {
  const AllProductsScreenV2({super.key});

  @override
  State<AllProductsScreenV2> createState() => _AllProductsScreenV2State();
}

class _AllProductsScreenV2State extends State<AllProductsScreenV2> {
  // Set to keep track of which menu items are currently expanded
  // Index 0 (Cold Drink) is expanded by default to match the design
  Set<int> expandedItems = {0};
  List<Map<String, dynamic>> items = [
    {
      'title': 'Cold Drink',
      'children': ['Soda', 'Thanda', 'Milk Shake'],
    },
    {
      'title': 'Waffers Food',
      'children': ['Item 1', 'Item 2', 'Item 3'],
    },
    {
      'title': 'Electronics',
      'children': ['Item 1', 'Item 2', 'Item 3'],
    },
    {
      'title': 'Outdoor Sports',
      'children': ['Item 1', 'Item 2', 'Item 3'],
    },
    {
      'title': 'Indoor Sports',
      'children': ['Item 1', 'Item 2', 'Item 3'],
    },
  ];
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const CustomSearchField(hintText: 'Search'),
      SizedBox(height: 0.02 * Responsive.getHeight(context)),
      Expanded(
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) => buildExpandableItem(
            index: index,
            title: items[index]['title'],
            children: items[index]['children'],
            isExpanded: expandedItems.contains(index),
          ),
          separatorBuilder: (context, index) =>
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
        ),
      ),
    ],
  );

  Widget buildExpandableItem({
    required int index, // Unique identifier for state management
    required String title, // Display text for the menu header
    required List<String> children, // List of sub-menu items
    required bool isExpanded, // Current expansion state
  }) => Container(
    // Main container styling with rounded corners and shadow
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        8 * Responsive.getResponsive(context),
      ),
      // Subtle shadow for depth and separation between items
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 1), // Shadow appears below the container
        ),
      ],
    ),
    child: Column(
      children: [
        // Header section - clickable area that toggles expansion
        InkWell(
          // Handle tap to expand/collapse the menu item
          onTap: () {
            // Put this logic in bloc when api calls are added
            setState(() {
              // Toggle expansion state: remove if present, add if absent
              if (expandedItems.contains(index)) {
                expandedItems.remove(index);
              } else {
                expandedItems.add(index);
              }
            });
          },
          borderRadius: BorderRadius.circular(
            8 * Responsive.getResponsive(context),
          ), // Ripple effect boundary
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * Responsive.getResponsive(context),
              vertical: 16 * Responsive.getResponsive(context),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.getColor(context).outline,
                width: 0.7,
              ),
              // Dynamic background color based on expansion state
              color: isExpanded
                  ? AppTheme.getColor(context).primary
                  : AppTheme.getColor(context).surface,
              // Dynamic border radius - rounded only at top when expanded with children
              borderRadius: isExpanded && children.isNotEmpty
                  ? BorderRadius.only(
                      topLeft: Radius.circular(
                        8 * Responsive.getResponsive(context),
                      ),
                      topRight: Radius.circular(
                        8 * Responsive.getResponsive(context),
                      ),
                    )
                  : BorderRadius.circular(8), // Fully rounded when collapsed
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Menu title text
                CustomText(
                  title,
                  fontSize: 16 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w700,
                  // White text when expanded (blue background), dark when collapsed
                  color: isExpanded
                      ? AppTheme.getColor(context)
                            .onPrimary // Colors.white
                      : AppTheme.getColor(context).primary,
                ),
                // Expand/collapse arrow icon
                Icon(
                  // Arrow direction changes based on expansion state
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: isExpanded
                      ? AppTheme.getColor(context).onPrimary
                      : AppTheme.getColor(context).primary,
                  size: 24 * Responsive.getResponsive(context),
                ),
              ],
            ),
          ),
        ),

        // Children section - only visible when expanded and has items
        if (isExpanded && children.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              // Light primary color background for child items (lighter shade than header)
              color: AppTheme.getColor(context).outline.withValues(alpha: 0.01),
              border: Border.all(
                color: AppTheme.getColor(context).outline,
                width: 0.7,
              ),
              // Rounded corners only at bottom to connect with header
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  8 * Responsive.getResponsive(context),
                ),
                bottomRight: Radius.circular(
                  8 * Responsive.getResponsive(context),
                ),
              ),
            ),
            child: Column(
              // Generate list of child items dynamically
              children: children.asMap().entries.map((entry) {
                int childIndex = entry.key; // Index of current child
                String child = entry.value; // Child item text

                return InkWell(
                  // Handle tap on individual child items
                  onTap: () {
                    // Placeholder for child item selection logic
                    print('Tapped on $child');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16 * Responsive.getResponsive(context),
                      vertical: 14 * Responsive.getResponsive(context),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        // Add bottom border to all items except the last one
                        bottom: childIndex < children.length - 1
                            ? BorderSide(
                                color: AppTheme.getColor(context).outline,
                                width: 0.5,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Child item text
                        CustomText(
                          child,
                          fontSize: 16 * Responsive.getResponsiveText(context),
                          color: AppTheme.getColor(context).onSurface,
                          fontWeight: FontWeight.w700,
                        ),

                        // arrow forward ios indicating this item is clickable
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppTheme.getColor(context).onSurface,
                          size: 20 * Responsive.getResponsive(context),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(), // Convert map result to List<Widget>
            ),
          ),
      ],
    ),
  );
}

class AllProductsScreenV3 extends StatelessWidget {
  const AllProductsScreenV3({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<TakeOrderMainBloc, TakeOrderMainState>(
    builder: (context, state) {
      if (state.isLoading) {
        return const ShimmerLoading();
      }

      if (state.error != '') {
        return Center(child: Text(state.error));
      }

      final productCategory =
          state.getProductCategoryEntity.productCategories ?? [];

      if (productCategory.isEmpty) {
        return const Center(child: CustomText('no_data'));
      }

      return Column(
        children: [
          CustomSearchField(
            hintText: 'Search',
            isSuffixIconOn: true,
            suffixIcon: SvgPicture.asset(AppAssets.scan),
          ),

          SizedBox(height: 0.02 * Responsive.getHeight(context)),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 0.025 * Responsive.getHeight(context),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: productCategory.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        context.read<TakeOrderMainBloc>().add(
                          GetProductByCategoryEvent(selectedIndex: index),
                        );
                      },
                      child: getCategoryChip(
                        context,
                        categories: productCategory[index].categoryName,
                        isSelected: index == state.selectedCategoryIndex,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: 0.01 * Responsive.getWidth(context)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),

          Expanded(
            child: ListView.separated(
              itemCount:
                  productCategory[state.selectedCategoryIndex].products.length,
              itemBuilder: (context, index) => FrequentBuyCard(
                productId: productCategory[state.selectedCategoryIndex]
                    .products[index]
                    .productId,
                productName: productCategory[state.selectedCategoryIndex]
                    .products[index]
                    .productName,
                productVariantName: productCategory[state.selectedCategoryIndex]
                    .products[index]
                    .productVariantName,
                unitMeasurementType:
                    productCategory[state.selectedCategoryIndex]
                        .products[index]
                        .unitMeasurementName,
                variantImage: productCategory[state.selectedCategoryIndex]
                    .products[index]
                    .variantPhoto,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: 0.015 * Responsive.getHeight(context)),
            ),
          ),

          SideBySideButtons(
            button1Name: LanguageManager().get('reset_cart'),
            button2Name: LanguageManager().get('add_order'),
            onTap1: () {},
            onTap2: () {
              context.pushNamed(RoutePaths.orderSummary);
            },
          ),
          SizedBox(height: 0.03 * Responsive.getHeight(context)),
        ],
      );
    },
  );

  Container getCategoryChip(
    BuildContext context, {
    required String categories,
    required bool isSelected,
  }) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: 8 * Responsive.getResponsive(context),
      vertical: 2 * Responsive.getResponsive(context),
    ),
    decoration: BoxDecoration(
      color: isSelected
          ? AppTheme.getColor(context).primary
          : AppTheme.getColor(context).surface,
      border: Border.all(color: AppTheme.getColor(context).outline),
      borderRadius: BorderRadius.circular(
        12 * Responsive.getResponsive(context),
      ),
    ),
    child: CustomText(
      categories,
      color: isSelected
          ? AppTheme.getColor(context).onPrimary
          : AppTheme.getColor(context).primary,
      fontWeight: FontWeight.w600,
      fontSize: 14 * Responsive.getResponsiveText(context),
    ),
  );
}
