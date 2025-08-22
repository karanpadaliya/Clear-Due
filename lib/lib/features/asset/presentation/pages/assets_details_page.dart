import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_information_entity.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_state.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/active_assets_card.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/asset_simmer_widget.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/image_grid_preview_widget.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/dashed_border_container.dart';
import 'package:myco_flutter/widgets/cached_image_holder.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class AssetsDetailsPage extends StatelessWidget {
  const AssetsDetailsPage({super.key});

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        isKey: true,
        title: 'assets_details',
        titleSpacing: 0,
        actions: [
          BlocBuilder<GetAssetInformationBloc, GetAssetInformationState>(
            builder: (context, state) {
              bool showHandOver = false;
              AssetInformationEntity? assetInfo;

              if (state is GetAssetInformationLoaded) {
                assetInfo = state.assetInformation;
                showHandOver = (state.assetInformation.history ?? []).every(
                  (entry) => (entry.takeoverByName?.trim().isEmpty ?? true),
                );
              }
              return showHandOver
                  ? GestureDetector(
                      onTap: () =>
                          context.push('/handover-assets', extra: assetInfo),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 0.035 * Responsive.getWidth(context),
                            color: AppTheme.getColor(context).onSurface,
                          ),
                          CustomText(
                            'handover_assets',
                            fontSize:
                                16 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
        actionsPadding: EdgeInsets.only(
          right:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: BlocBuilder<GetAssetInformationBloc, GetAssetInformationState>(
          builder: (context, state) {
            // log(name: '--------- State ----------------', state.toString());

            if (state is GetAssetInformationLoading) {
              return SingleChildScrollView(
                child: Column(
                  spacing:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AssetDetailsShimmerWidget(),
                    Shimmer.fromColors(
                      baseColor: AppTheme.getColor(
                        context,
                      ).primary.withAlpha(180),
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 0.06 * Responsive.getHeight(context),
                        decoration: BoxDecoration(
                          color: AppTheme.getColor(context).surfaceBright,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(
                            VariableBag.commonCardBorderRadius *
                                Responsive.getResponsive(context),
                          ),
                        ),
                      ),
                    ),
                    const AssetHistoryShimmerWidget(),
                  ],
                ),
              );
            } else if (state is GetAssetInformationError) {
              return Center(child: Text(state.message));
            } else if (state is GetAssetInformationLoaded) {
              final assetInfo = state.assetInformation;

              return SingleChildScrollView(
                child: Column(
                  spacing:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    detailsCard(context, assetInfo),

                    // -- Assets History Label --
                    CommonCard(
                      headerColor: AppTheme.getColor(context).primary,
                      title: 'assets_history',
                      bottomWidget: const SizedBox.shrink(),
                      showBlackShadowInChild: true,
                      headerBottomBorderRadius:
                          VariableBag.commonCardBorderRadius *
                          Responsive.getResponsive(context),
                      titleFontSize: 18 * Responsive.getResponsiveText(context),
                    ),

                    // -- Assets History Cards --
                    if (assetInfo.history != null &&
                        (assetInfo.history ?? []).isNotEmpty)
                      ...assetInfo.history!.map(
                        (entry) => buildAssetHistoryCard(
                          context: context,
                          assetInfo: assetInfo,
                          history: entry,
                        ),
                      ),

                    SizedBox(
                      height:
                          VariableBag.formContentSpacingVertical *
                          Responsive.getResponsive(context),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CustomText('No Data'));
          },
        ),
      ),
    );
  }

  Widget detailsCard(
    BuildContext context,
    AssetInformationEntity assetInfo,
  ) => CommonCard(
    title: assetInfo.assetsName ?? 'Name Not Available',
    showBlackShadowInChild: true,
    suffixIcon: Row(
      children: [
        GestureDetector(
          // onTap: onEditTap,
          onTap: () => context.push('/edit-assets'),
          child: Image.asset(
            AppAssets.imageMassageEdit,
            color: AppTheme.getColor(context).onPrimary,
            width: 0.07 * Responsive.getWidth(context),
          ),
        ),
        SizedBox(width: 0.045 * Responsive.getWidth(context)),
        GestureDetector(
          // onTap: onScannerTap,
          child: Image.asset(
            AppAssets.imageScanner,
            width: 0.07 * Responsive.getWidth(context),
            color: AppTheme.getColor(context).onPrimary,
          ),
        ),
      ],
    ),
    bottomWidget: Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.commonCardHorizontalPadding *
            Responsive.getResponsive(context),
        vertical:
            VariableBag.commonCardVerticalPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 0.35 * Responsive.getWidth(context),
            height: 0.35 * Responsive.getWidth(context),
            padding: EdgeInsets.all(8 * Responsive.getResponsive(context)),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(
                12 * Responsive.getResponsive(context),
              ),
            ),
            child: Center(
              child: CachedImage(
                imageUrl: assetInfo.assetsFile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
          Row(
            children: [
              SizedBox(
                width: 0.32 * Responsive.getWidth(context),
                child: AssetsVerticalData(
                  title: 'created_by',
                  data: assetInfo.createdByName ?? ' -- ',
                  titleFontStyle: FontStyle.italic,
                ),
              ),
              // const SizedBox(width: 4),
              Expanded(
                child: AssetsVerticalData(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: 'created_date',
                  data: assetInfo.iteamCreatedDate ?? '-- / -- / ----',
                  titleFontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Divider(
            color: AppTheme.getColor(context).secondary,
            height: 25 * Responsive.getResponsive(context),
          ),
          SizedBox(height: 0.015 * Responsive.getHeight(context)),

          ..._buildRowDataList(context, {
            'category': assetInfo.assetsCategory,
            'brand_name': assetInfo.assetsBrandName,
            'sr_no': assetInfo.srNo,
            'purchase_date': assetInfo.itemPurchaseDate,
            'item_price': assetInfo.itemPrice,
          }),
          Divider(
            color: AppTheme.getColor(context).secondary,
            height: 25 * Responsive.getResponsive(context),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: AssetsVerticalData(
                  title: 'credential',
                  data: assetInfo.assetCredential ?? ' -- ',
                  titleFontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          VariableBag.bottomSheetBorderRadius *
                              Responsive.getResponsive(context),
                        ),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        top:
                            VariableBag.bottomSheetTopPadding *
                            Responsive.getResponsive(context),
                        left:
                            VariableBag.bottomSheetLeftPadding *
                            Responsive.getResponsive(context),
                        right:
                            VariableBag.bottomSheetRightPadding *
                            Responsive.getResponsive(context),
                        bottom:
                            VariableBag.bottomSheetBottomPadding *
                            Responsive.getResponsive(context),
                      ),
                      child: Column(
                        spacing:
                            VariableBag.formContentSpacingVertical *
                            Responsive.getResponsive(context),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            'attachment',
                            fontSize:
                                20 * Responsive.getResponsiveText(context),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.getColor(context).onSurfaceVariant,
                          ),
                          CustomPaint(
                            painter: DashedBorderPainter(
                              color: AppColors.primary,
                              radius: 12 * Responsive.getResponsive(context),
                            ),
                            child: Container(
                              width: 0.35 * Responsive.getWidth(context),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF7FD),
                                borderRadius: BorderRadius.circular(
                                  13 * Responsive.getResponsive(context),
                                ),
                              ),
                              padding: EdgeInsets.all(
                                12 * Responsive.getResponsive(context),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 0.3 * Responsive.getWidth(context),
                                    height: 0.3 * Responsive.getWidth(context),
                                    child: Center(
                                      child: CachedImage(
                                        imageUrl: assetInfo.assetsInvoice,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        0.01 * Responsive.getHeight(context),
                                  ),
                                  CustomText(
                                    assetInfo.assetsInvoiceName ?? ' -- ',
                                    maxLines: 1,
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //  Button
                          MyCoButton(
                            onTap: () => context.pop(),
                            title: 'Close',
                            isShadowBottomLeft: true,
                            boarderRadius:
                                VariableBag.buttonBorderRadius *
                                Responsive.getResponsive(context),
                            fontFamily: 'Gilroy-Bold',
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: CustomText(
                  'invoice',
                  fontWeight: FontWeight.w700,
                  color: AppTheme.getColor(context).primary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.getColor(context).primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget buildAssetHistoryCard({
    required BuildContext context,
    required AssetInformationEntity assetInfo,
    required AssetHistoryEntity history,
  }) {
    final responsive = Responsive.getResponsive(context);

    final hasHandoverFiles = (history.assetsFilesHandover ?? [])
        .where((e) => (e.document ?? '').isNotEmpty)
        .isNotEmpty;
    final hasTakeoverFiles = (history.assetsFilesTakeover ?? [])
        .where((e) => (e.document ?? '').isNotEmpty)
        .isNotEmpty;

    final showHandoverBy = (history.handoverByName?.trim().isNotEmpty ?? false);
    final showTakeoverBy = (history.takeoverByName?.trim().isNotEmpty ?? false);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.getColor(context).outline),
        borderRadius: BorderRadius.circular(
          VariableBag.containerBorderRadius * responsive,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(
              VariableBag.commonContainerPadding * responsive,
            ),
            child: _historyProfileRowData(
              context: context,
              userId: history.userId ?? history.userFullName ?? '',
              image: history.userProfilePic ?? '',
              title: history.userFullName ?? '--',
              subTitle: history.userDesignation ?? '',
              address:
                  '${history.floorName ?? ''} - ${history.blockName ?? ''}',
            ),
          ),
          Divider(color: AppTheme.getColor(context).outline, height: 0),
          Padding(
            padding: EdgeInsets.all(
              VariableBag.commonContainerPadding * responsive,
            ),
            child: Column(
              spacing: 0.015 * Responsive.getHeight(context),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (history.handoverDate != null &&
                    (history.handoverDate ?? '').trim().isNotEmpty)
                  Row(
                    children: [
                      SizedBox(
                        width: 0.34 * Responsive.getWidth(context),
                        child: AssetsVerticalData(
                          title: 'handover',
                          data: history.handoverDate ?? '--',
                        ),
                      ),
                      const Spacer(),
                      if (hasHandoverFiles)
                        ImageGridPreviewWidget(
                          boxHeight: 0.14 * Responsive.getWidth(context),
                          boxWidth: 0.14 * Responsive.getWidth(context),
                          borderRadius: 10,
                          imageList: (history.assetsFilesHandover ?? [])
                              .map((e) => e.document ?? '')
                              .where((url) => url.isNotEmpty)
                              .toList(),
                        ),
                    ],
                  ),

                if (history.takeoverDate != null &&
                    (history.takeoverDate ?? '').trim().isNotEmpty)
                  Row(
                    children: [
                      SizedBox(
                        width: 0.34 * Responsive.getWidth(context),
                        child: AssetsVerticalData(
                          title: 'takeover',
                          data: history.takeoverDate ?? '--',
                        ),
                      ),
                      const Spacer(),
                      if (hasTakeoverFiles)
                        ImageGridPreviewWidget(
                          boxHeight: 0.14 * Responsive.getWidth(context),
                          boxWidth: 0.14 * Responsive.getWidth(context),
                          borderRadius: 10,
                          imageList: (history.assetsFilesTakeover ?? [])
                              .map((e) => e.document ?? '')
                              .where((url) => url.isNotEmpty)
                              .toList(),
                        ),
                    ],
                  ),

                Row(
                  children: [
                    showHandoverBy
                        ? Expanded(
                            child: AssetsVerticalData(
                              title: 'handover_by',
                              data: history.handoverByName!,
                              titleFontStyle: FontStyle.italic,
                            ),
                          )
                        : const Spacer(),
                    showTakeoverBy
                        ? Expanded(
                            child: AssetsVerticalData(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              title: 'takeover_by',
                              data: history.takeoverByName!,
                              titleFontStyle: FontStyle.italic,
                            ),
                          )
                        : const Spacer(),
                  ],
                ),
                if (!showTakeoverBy)
                  Row(
                    children: [
                      const Spacer(),
                      MyCoButton(
                        onTap: () => context.push('/takeover-assets', extra: assetInfo),
                        title: 'takeover_assets',
                        textStyle: TextStyle(
                          fontSize: 13 * Responsive.getResponsiveText(context),
                          fontFamily: 'Gilroy-semiBold',
                          fontWeight: FontWeight.w700,
                          color: AppTheme.getColor(context).onPrimary,
                        ),
                        width: 0.3 * Responsive.getWidth(context),
                        height: 45 * Responsive.getResponsive(context),
                        boarderRadius:
                            VariableBag.buttonBorderRadius *
                            Responsive.getResponsive(context),
                        isShadowBottomLeft: true,
                      ),
                      SizedBox(
                        width:
                            VariableBag.buttonRowSpacing *
                            Responsive.getResponsive(context),
                      ),
                      MyCoButton(
                        onTap: () {
                          final data = {
                            'assetsIdTwo': assetInfo.assetsId.toString(),
                            'handoverUserIdTwo': history.userId.toString(),
                            'assetsCategoryIdTwo': assetInfo.assetsCategoryId
                                .toString(),
                            'floorIdTwo': assetInfo.assetsCategoryId.toString(),
                            'inventoryIdTwo': history.inventoryId.toString(),
                          };
                          context.push('/swap-assets', extra: data);
                        },
                        title: 'swap',
                        textStyle: TextStyle(
                          fontFamily: 'Gilroy-semiBold',
                          fontSize: 13 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w700,
                          color: AppTheme.getColor(context).onPrimary,
                        ),
                        width: 0.28 * Responsive.getWidth(context),
                        height: 45 * Responsive.getResponsive(context),
                        boarderRadius:
                            VariableBag.buttonBorderRadius *
                            Responsive.getResponsive(context),
                        borderColor: const Color(0xFF08A4BB),
                        backgroundColor: const Color(0xFF08A4BB),
                        isShadowBottomLeft: true,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyProfileRowData({
    required BuildContext context,
    required String userId,
    required String image,
    required String title,
    required String subTitle,
    required String address,
  }) => Row(
    children: [
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 1),
              color: Colors.black26,
              blurRadius: 4,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 0.06 * Responsive.getWidth(context),
          child: ClipOval(
            child: image.startsWith('http') || image.startsWith('https')
                ? CachedImage(
                    key: Key(userId),
                    imageUrl: image,
                    width: 0.34 * Responsive.getWidth(context),
                    height: 0.34 * Responsive.getWidth(context),
                  )
                : SvgPicture.asset(
                    key: Key(userId),
                    image.isEmpty ? AppAssets.assetProfileCircle : image,
                    fit: BoxFit.cover,
                    width: 0.34 * Responsive.getWidth(context),
                    height: 0.34 * Responsive.getWidth(context),
                  ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            fontSize: 16 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w700,
            color: AppTheme.getColor(context).primary,
          ),
          CustomText(
            subTitle,
            fontSize: 12 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
          CustomText(
            address,
            fontSize: 12 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onSurfaceVariant,
          ),
        ],
      ),
    ],
  );

  List<Widget> _buildRowDataList(
    BuildContext context,
    Map<String, String?> dataMap,
  ) => dataMap.entries
      .where(
        (entry) => entry.value != null && (entry.value ?? '').trim().isNotEmpty,
      )
      .map(
        (entry) => _rowData(
          context: context,
          title: entry.key,
          data: entry.value ?? ' -- ',
        ),
      )
      .toList();

  Widget _rowData({
    required BuildContext context,
    required String title,
    required String data,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 0.35 * Responsive.getWidth(context),
            child: CustomText(
              title,
              color: AppTheme.getColor(context).onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 14 * Responsive.getResponsiveText(context),
            ),
          ),
          CustomText(
            ' :   ',
            fontWeight: FontWeight.w700,
            color: AppTheme.getColor(context).onSurface,
            fontSize: 14 * Responsive.getResponsiveText(context),
          ),
          Expanded(
            child: CustomText(
              data,
              color: AppTheme.getColor(context).onSurfaceVariant,
              fontSize: 14 * Responsive.getResponsiveText(context),
            ),
          ),
        ],
      ),
      SizedBox(height: 0.015 * Responsive.getHeight(context)),
    ],
  );
}
