import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_entity.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_state.dart';
import 'package:myco_flutter/features/asset/presentation/pages/all_assets_qr_generate_page.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/active_assets_card.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/all_assets_card.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/asset_simmer_widget.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/past_assets_card.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/silver_tab_bar_widget.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field.dart';

class AssetsHomePage extends StatefulWidget {
  const AssetsHomePage({super.key});

  @override
  State<AssetsHomePage> createState() => _AssetsHomePageState();
}

class _AssetsHomePageState extends State<AssetsHomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AssetsBloc>();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'assets',
        isKey: true,
        titleSpacing: 0,
        actions: [
          BlocBuilder<AssetsBloc, AssetsState>(
            builder: (context, state) {
              final int viewOtherAssetsAccess = (state is AssetsLoaded)
                  ? state.viewOtherAssetsAccess
                  : 0;

              return viewOtherAssetsAccess != 0
                  ? Padding(
                      padding: EdgeInsets.only(
                        right:
                            VariableBag.screenHorizontalPadding *
                            Responsive.getResponsive(context),
                      ),
                      child: GestureDetector(
                        onTap: () => context.push('/add-assets'),
                        // onTap: () async {
                        //   final dataMap = {
                        //     'getAssetDetailsNew': 'getAssetDetailsNew',
                        //     'society_id': '1',
                        //     'language_id': '1',
                        //     'user_id': '1679',
                        //     'assets_id': 'MjAyNTA4MDQwMzI2MTYtMTIx',
                        //   };
                        //   log(
                        //     name: '----- dataMap -------',
                        //     dataMap.toString(),
                        //   );

                        //   final encryptedBody = GzipUtil.encryptAES(
                        //     jsonEncode(dataMap),
                        //   );
                        //   log(name: '---- Encrypt Data -----', encryptedBody);
                        //   final response = await GetIt.I<ApiClient>(
                        //     instanceName: VariableBag.employeeMobileApi,
                        //   ).postDynamic('assets_controller.php', encryptedBody);
                        //   log(
                        //     name: '----- Decrypt Data --------',
                        //     GzipUtil.decryptAES(response),
                        //   );
                        // },
                        // onTap: () async {
                        //   final prefs = GetIt.I<PreferenceManager>();

                        //   final userId = await prefs.getUserId();
                        //   final companyId = await prefs.getCompanyId();
                        //   final languageId = await prefs.getLanguageId();

                        //   final dataMap = {
                        //     'tag': 'getAssetsUserSwap',
                        //     'languageId': languageId,
                        //     'userId': '1401',
                        //     'societyId': companyId,
                        //   };
                        //   log(
                        //     name: '----- dataMap -------',
                        //     dataMap.toString(),
                        //   );

                        //   final encryptedBody = GzipUtil.encryptAES(
                        //     jsonEncode(dataMap),
                        //   );
                        //   log(name: '---- Encrypt Data -----', encryptedBody);
                        //   final response =
                        //       await GetIt.I<ApiClient>(
                        //         instanceName: VariableBag.employeeMobileApi,
                        //       ).postDynamic(
                        //         'view_member_list_controller.php',
                        //         encryptedBody,
                        //       );
                        //   log(
                        //     name: '----- Decrypt Data --------',
                        //     GzipUtil.decryptAES(response),
                        //   );
                        // },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              size: 0.035 * Responsive.getWidth(context),
                              color: AppTheme.getColor(context).onSurface,
                            ),
                            CustomText(
                              'add_assets',
                              fontSize:
                                  16 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: CustomScrollView(
          slivers: [
            // Pinned TabBar
            tabBar(context, bloc),

            // Asset List
            ..._buildAssetListByTab(context, bloc),

            // Extra spacing at the bottom
            SliverToBoxAdapter(
              child: SizedBox(
                height:
                    VariableBag.formContentSpacingVertical *
                    Responsive.getResponsive(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar(
    BuildContext context,
    AssetsBloc bloc,
  ) => SliverPersistentHeader(
    pinned: true,
    delegate: SliverTabBarDelegate(
      height:
          (VariableBag.searchFiledAfterSpace + 120) *
          Responsive.getResponsive(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<AssetsBloc, AssetsState>(
            builder: (context, state) {
              final int viewOtherAssetsAccess = (state is AssetsLoaded)
                  ? state.viewOtherAssetsAccess
                  : 0;

              return MyCoTextfield(
                key: ValueKey(state.selectedIndex),
                autoFocus: false,
                hintText: LanguageManager().get('search'),
                maxLines: 1,
                textAlignment: TextAlign.start,
                hintTextStyle: AppTheme.getTextStyle(
                  context,
                ).labelLarge!.copyWith(color: AppColors.textSecondary),
                preFixImage: AppAssets.imageSearch,
                isSuffixIconOn: viewOtherAssetsAccess != 0 ? true : false,
                suFixImage: viewOtherAssetsAccess != 0
                    ? AppAssets.imageScanner
                    : null,
                suFixImageWidth: 25,
                onTap1: () => context.push('/qr-scanner'),
                contentPadding: EdgeInsets.only(
                  top: 0.012 * Responsive.getHeight(context),
                ),
                onChanged: (value) {
                  if (state.selectedIndex == 2) {
                    context.read<AssetsBloc>().add(
                      ApplyFilterEvent(searchQuery: value),
                    );
                  } else {
                    context.read<AssetsBloc>().add(SearchAssetsEvent(value));
                  }
                },
                boarderRadius: 12 * Responsive.getResponsive(context),
              );
            },
          ),
          SizedBox(
            height:
                VariableBag.searchFiledAfterSpace *
                Responsive.getResponsive(context),
          ),
          SizedBox(
            height: 60 * Responsive.getResponsive(context),
            child: BlocBuilder<AssetsBloc, AssetsState>(
              builder: (context, state) {
                final int viewOtherAssetsAccess = (state is AssetsLoaded)
                    ? state.viewOtherAssetsAccess
                    : 0;

                return MyCustomTabBar(
                  isShadowBottomLeft: true,
                  tabBarBorderColor: getTabIndexColor(
                    context,
                    state.selectedIndex,
                  ),
                  selectedBgColors: [
                    AppTheme.getColor(context).secondary,
                    AppTheme.getColor(context).primary,
                    if (viewOtherAssetsAccess != 0) const Color(0xFF08A4BB),
                  ],
                  selectedIndex: state.selectedIndex,
                  tabs: [
                    'Active Assets (${state is AssetsLoaded ? state.activeAssets.length : 0})',
                    'Past Assets (${state is AssetsLoaded ? state.pastAssets.length : 0})',
                    if (viewOtherAssetsAccess != 0)
                      'All Assets (${state is AssetsLoaded ? state.allAssets.length : 0})',
                  ],
                  onTabChange: (int index) {
                    bloc.add(TabChanged(index));
                  },
                  unselectedTextStyles: [
                    TextStyle(
                      fontSize: 10 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).secondary,
                      fontFamily: 'Gilroy-Bold',
                      fontWeight: FontWeight.w700,
                    ),
                    TextStyle(
                      fontSize: 10 * Responsive.getResponsiveText(context),
                      color: AppTheme.getColor(context).primary,
                      fontFamily: 'Gilroy-Bold',
                      fontWeight: FontWeight.w700,
                    ),
                    TextStyle(
                      fontSize: 10 * Responsive.getResponsiveText(context),
                      color: const Color(0xFF08A4BB),
                      fontFamily: 'Gilroy-Bold',
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                  selectedTextStyle: TextStyle(
                    fontSize: 10 * Responsive.getResponsiveText(context),
                    color: Colors.white,
                    fontFamily: 'Gilroy-Bold',
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedBorderAndTextColor: AppTheme.getColor(
                    context,
                  ).outline,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );

  List<Widget> _buildAssetListByTab(BuildContext context, AssetsBloc bloc) {
    final state = context.watch<AssetsBloc>().state;

    switch (state.selectedIndex) {
      case 0:
        return [
          SliverToBoxAdapter(
            child: SizedBox(
              height:
                  VariableBag.tabBarAfterSpace *
                  Responsive.getResponsive(context),
            ),
          ),
          AssetsListPage(oldItems: state.selectedIndex.toString()),
        ];
      case 1:
        return [
          SliverToBoxAdapter(
            child: SizedBox(
              height:
                  VariableBag.tabBarAfterSpace *
                  Responsive.getResponsive(context),
            ),
          ),
          AssetsListPage(oldItems: state.selectedIndex.toString()),
        ];
      case 2:
        return _buildAllAssetsTab(context, bloc);
    }

    return [const SizedBox.shrink()];
  }

  List<Map<String, String>> categoryDataList = [];

  List<Map<String, String>> brandDataList = [];

  // ignore: prefer_expression_function_bodies
  List<Widget> _buildAllAssetsTab(BuildContext context, AssetsBloc bloc) {
    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverTabBarDelegate(
          height: 65 * Responsive.getResponsive(context),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0 * Responsive.getResponsive(context),
            ),
            child: Row(
              children: [
                Expanded(
                  child: BlocBuilder<AssetsBloc, AssetsState>(
                    builder: (context, state) {
                      if ((state is AssetsLoaded) &&
                          state.categories.isNotEmpty) {
                        categoryDataList = state.categories.isNotEmpty
                            ? state.categories
                                  .map(
                                    (e) => {
                                      'id': e.assetsCategoryId ?? '',
                                      'name': e.assetsCategory ?? '',
                                    },
                                  )
                                  .toList()
                            : [];
                      }

                      final category =
                          (state is AssetsLoaded &&
                              state.appliedCategory != null &&
                              state.appliedCategory!.isNotEmpty)
                          ? state.appliedCategory!
                          : 'All Category';

                      return DropDownTextField(
                        context,
                        title: category,
                        onTap: () async {
                          final data = await showCustomSimpleBottomSheet(
                            context: context,
                            heading: 'Select Category',
                            dataList: categoryDataList,
                          );
                          if (data != null && state is AssetsLoaded) {
                            bloc.add(UpdateAppliedCategoryEvent(data['name']));
                            log(name: 'category select', data.toString());
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width:
                      VariableBag.buttonRowSpacing *
                      Responsive.getResponsive(context),
                ),
                Expanded(
                  child: BlocBuilder<AssetsBloc, AssetsState>(
                    builder: (context, state) {
                      if ((state is AssetsLoaded) && state.brands.isNotEmpty) {
                        brandDataList = state.brands.isNotEmpty
                            ? state.brands
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => {
                                      'id': entry.key.toString(), // index as id
                                      'name': entry.value.brandName ?? '',
                                    },
                                  )
                                  .toList()
                            : [];
                      }

                      final brand =
                          (state is AssetsLoaded &&
                              state.appliedBrand != null &&
                              state.appliedBrand!.isNotEmpty)
                          ? state.appliedBrand!
                          : 'All Brand';

                      return DropDownTextField(
                        context,
                        title: brand,
                        onTap: () async {
                          final data = await showCustomSimpleBottomSheet(
                            context: context,
                            heading: 'Select Brand',
                            dataList: brandDataList,
                          );
                          if (data != null) {
                            bloc.add(UpdateAppliedBrandEvent(data['name']));
                            log(name: 'brand data', data.toString());
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(height: 10 * Responsive.getResponsive(context)),
      ),
      const AllAssetsListPage(),
    ];
  }

  Color getTabIndexColor(BuildContext context, int index) {
    switch (index) {
      case 0:
        return AppTheme.getColor(context).secondary;
      case 1:
        return AppTheme.getColor(context).primary;
      case 2:
        return const Color(0xFF08A4BB);
    }

    return AppTheme.getColor(context).outline;
  }

  Widget DropDownTextField(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 8 * Responsive.getResponsive(context),
        horizontal: 6 * Responsive.getResponsive(context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10 * Responsive.getResponsive(context),
        ),
        border: Border.all(color: AppTheme.getColor(context).secondary),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              title,
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).secondary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.getColor(context).secondary,
          ),
        ],
      ),
    ),
  );
}

class AssetsListPage extends StatelessWidget {
  final String oldItems;

  const AssetsListPage({required this.oldItems, super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AssetsBloc, AssetsState>(
    builder: (context, state) {
      if (state is AssetsLoading) {
        return SliverToBoxAdapter(
          child: Column(
            children: List.generate(
              4,
              (index) => Padding(
                padding: EdgeInsets.only(
                  bottom: 0.020 * Responsive.getHeight(context),
                ),
                child: const AssetsShimmerWidget(),
              ),
            ),
          ),
        );
      } else if (state is AssetsLoaded) {
        // final assets = state.currentAssets;

        final assets = state.currentAssets as List<AssetEntity>;

        return SliverList.separated(
          itemCount: assets.length,
          separatorBuilder: (_, __) => SizedBox(
            height:
                VariableBag.formContentSpacingVertical *
                Responsive.getResponsive(context),
          ),
          itemBuilder: (_, index) {
            final item = assets[index];

            if (oldItems == '1') {
              return PastAssetsCard(
                mainImageKey: Key('main_image_${item.assetsIdView ?? index}'),
                handoverImageKey: Key(
                  'asset_${item.assetsIdView ?? index}_handover',
                ),
                takeoverImageKey: Key(
                  'asset_${item.assetsIdView ?? index}_takeover',
                ),
                title: item.assetsName ?? '',
                subTitle: '(${item.assetsIdView ?? ''})',
                image: item.assetsFile ?? AppAssets.imageLaptop,
                brand: item.assetsBrandName ?? '',
                srNo: item.srNo ?? '',
                handover: item.handoverDate ?? '',
                takeover: item.takeoverDate ?? '',
                handoverImageList:
                    item.assetsFiles?.map((e) => e.document ?? '').toList() ??
                    [],
                takeoverImageList:
                    item.assetsFilesTakeover
                        ?.map((e) => e['file']?.toString())
                        .whereType<String>()
                        .toList() ??
                    [],
              );
            }

            return ActiveAssetsCard(
              imageKey: Key('handover_image_${item.assetsIdView ?? index}'),
              mainImageKey: Key('main_image_${item.assetsIdView ?? index}'),
              title: item.assetsName ?? '',
              subTitle: '(${item.assetsIdView ?? ''})',
              image: item.assetsFile ?? AppAssets.imageLaptop,
              brand: item.assetsBrandName ?? '',
              srNo: item.srNo ?? '--',
              handOverDate: item.handoverDate ?? '',
              handoverImageList:
                  item.assetsFiles?.map((e) => e.document ?? '').toList() ?? [],
            );
          },
        );
      } else if (state is AssetsError) {
        return SliverToBoxAdapter(child: Center(child: Text(state.message)));
      }

      return const SliverToBoxAdapter(child: SizedBox());
    },
  );
}

class AllAssetsListPage extends StatelessWidget {
  const AllAssetsListPage({super.key});

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    // Using SliverPadding wrapped inside a BlocBuilder to react to AssetsState
    return BlocBuilder<AssetsBloc, AssetsState>(
      builder: (context, state) {
        // Show loading state
        if (state is AssetsLoading) {
          return SliverList.separated(
            itemCount: 6, // shimmer placeholders count
            separatorBuilder: (_, __) => SizedBox(
              height:
                  VariableBag.formContentSpacingVertical *
                  Responsive.getResponsive(context),
            ),

            itemBuilder: (_, __) => const AssetsShimmerWidget(),
          );
        }

        // Show error state
        if (state is AssetsError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        }

        // When data is loaded
        if (state is AssetsLoaded) {
          final allAssets = state.currentAssets;

          if (allAssets.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text('No assets found')),
            );
          }

          return SliverList.separated(
            itemCount: allAssets.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: 0.02 * Responsive.getHeight(context)),
            itemBuilder: (_, index) {
              final asset = allAssets[index];
              return AllAssetsCard(
                key: Key(asset.assetsId),
                title: asset.assetsName ?? 'No Name',
                subTitle: '(${asset.assetsIdView ?? ''})',
                image: asset.assetsFile ?? '',
                brand: asset.assetsBrandName ?? '',
                srNo: asset.srNo ?? '',
                category: asset.assetsCategory ?? '',
                createdBy: asset.createdByName ?? 'Unknown',
                custodian: asset.custodian,
                onViewDetailsTap: () {
                  // if (asset.assetsId != null) {
                  //   context.read<GetAssetInformationBloc>().add(
                  //     FetchAssetInformationEvent(assetId: asset.assetsId),
                  //   );
                  // }
                  // log(name: 'asset.assetsId', asset.assetsId.toString());

                  context.push('/assets-details', extra: asset);
                },
                onEditTap: () => context.push('/edit-assets', extra: asset),
                onScannerTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AllAssetsQrGeneratePage(qr: asset.qrCode ?? ''),
                    ),
                  );
                },
              );
            },
          );
        }

        // Default to empty to avoid build error
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}


  // onTap: () async {
              //   final dataMap = {
              //     "getAssetsNew": "getAssetsNew",
              //     "society_id": "1",
              //     "unit_id": "1718",
              //     "user_id": "1679",
              //     "language_id": "1",
              //     "floor_id": "1",
              //     "old_items": "1",
              //   };

              //   final encryptedBody = GzipUtil.encryptAES(jsonEncode(dataMap));
              //   final response =
              //       await GetIt.I<ApiClient>(
              //         instanceName: VariableBag.masterAPICall,
              //       ).postDynamic(
              //         'https://dev.my-company.app/india/employeeMobileApi/assets_controller.php',
              //         encryptedBody,
              //       );
              //   // log(GzipUtil.decryptAES(response));
              //   log(jsonEncode(json.decode(GzipUtil.decryptAES(response))));

              //   // log(json.decode(GzipUtil.decryptAES(response)));
              // },