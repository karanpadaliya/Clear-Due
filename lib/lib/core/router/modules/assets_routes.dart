import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/di/injector.dart';
import 'package:myco_flutter/features/asset/domain/entities/all_assets_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_information_entity.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_information/asset_information_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/pages/add_assets.dart';
import 'package:myco_flutter/features/asset/presentation/pages/assets_details_page.dart';
import 'package:myco_flutter/features/asset/presentation/pages/assets_home_page.dart';
import 'package:myco_flutter/features/asset/presentation/pages/edit_assets_page.dart';
import 'package:myco_flutter/features/asset/presentation/pages/handover_assets.dart';
import 'package:myco_flutter/features/asset/presentation/pages/qr_scanner_page.dart';
import 'package:myco_flutter/features/asset/presentation/pages/swap_assets.dart';
import 'package:myco_flutter/features/asset/presentation/pages/takeover_asset.dart';
import 'package:myco_flutter/features/common_api/domain/usecase/common_api_usercase.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';

List<RouteBase> assetsRoutes = [
  GoRoute(
    path: RoutePaths.assetsHome,
    name: 'AssetsManagementVC',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<AssetsBloc>(
          create: (_) => sl<AssetsBloc>()..add(const InitializeAssetsEvent()),
        ),
      ],
      child: const AssetsHomePage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.qrScanner,
    name: 'qr-scanner',
    builder: (context, state) => const QRScannerPage(),
  ),
  GoRoute(
    path: RoutePaths.assetsDetails,
    name: 'assets-details',
    builder: (context, state) {
      final asset = state.extra as AssetDetailEntity;

      return BlocProvider<GetAssetInformationBloc>(
        create: (_) =>
            sl<GetAssetInformationBloc>()
              ..add(FetchAssetInformationEvent(assetId: asset.assetsId ?? '')),
        child: const AssetsDetailsPage(),
      );
    },
  ),
  GoRoute(
    path: RoutePaths.addAssets,
    name: 'add-assets',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<AddAssetBloc>(
          create: (_) =>
              sl<AddAssetBloc>()..add(const FetchAddAssetAndUserEvent()),
        ),
        BlocProvider(
          create: (context) =>
              CommonApiBloc(commonApiUserCase: GetIt.I<CommonApiUserCase>()),
        ),
        BlocProvider<CommonApiBloc>(
          create: (_) =>
              sl<CommonApiBloc>()..add(const LoadBranch('1', '1679')),
        ),
        BlocProvider<CustodianUserBloc>(create: (_) => sl<CustodianUserBloc>()),
      ],
      child: const AddAssets(),
    ),
  ),
  GoRoute(
    path: RoutePaths.editAssets,
    name: 'edit-assets',
    builder: (context, state) => const EditAssetsPage(),
  ),
  GoRoute(
    path: RoutePaths.handoverAssets,
    name: 'handover-assets',
    builder: (context, state) {
      final handoverAsset = state.extra as AssetInformationEntity;

      log(name: '------ Handover Data --------', handoverAsset.toString());
      //
      return MultiBlocProvider(
        providers: [
          BlocProvider<CommonApiBloc>(
            create: (_) =>
                sl<CommonApiBloc>()..add(const LoadBranch('1', '1679')),
          ),
          BlocProvider<CustodianUserBloc>(
            create: (_) => sl<CustodianUserBloc>(),
          ),
        ],
        child: HandoverAssetsPage(assetId: handoverAsset.assetsId),
      );
    },
  ),
  GoRoute(
    path: RoutePaths.takeoverAssets,
    name: 'takeover-assets',
    builder: (context, state) {
      final takeoverAsset = state.extra as AssetInformationEntity;
      return MultiBlocProvider(
        providers: [
          BlocProvider<CommonApiBloc>(
            create: (_) =>
                sl<CommonApiBloc>()..add(const LoadBranch('1', '1679')),
          ),
          BlocProvider<CustodianUserBloc>(
            create: (_) => sl<CustodianUserBloc>(),
          ),
          BlocProvider<TakeoverAssetBloc>(
            create: (_) => sl<TakeoverAssetBloc>(),
          ),
        ],
        child: TakeoverAssets(assetId: takeoverAsset.assetsId),
      );
    },
  ),
  GoRoute(
    path: RoutePaths.swapAssets,
    name: 'swap-assets',
    builder: (context, state) {
      final swapAsset = state.extra as Map<String, String>;

      // log(name: '------ Swap Data --------', swapAsset.toString());
      return SwapAssetsPage(
        assetsIdTwo: swapAsset['assetsIdTwo'],
        assetsCategoryIdTwo: swapAsset['assetsCategoryIdTwo'],
        floorIdTwo: swapAsset['floorIdTwo'],
        handoverUserIdTwo: swapAsset['handoverUserIdTwo'],
        inventoryIdTwo: swapAsset['inventoryIdTwo'],
      );
    },
  ),
];
