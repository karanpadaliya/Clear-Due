import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/asset/domain/entities/all_assets_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_entity.dart';
import 'package:myco_flutter/features/asset/domain/usecases/asset_use_case.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_tabs/asset_tab_state.dart';

class AssetsBloc extends Bloc<AssetsEvent, AssetsState> {
  final AssetsUseCases assetsUseCases; // tabs 0 & 1
  final AllAssetsUseCases allAssetsUseCases; // tab 2

  AssetsEntity? _activeAssetsEntity, _pastAssetsEntity;
  AllAssetsEntity? _allAssetsEntity;

  AssetsBloc(this.assetsUseCases, this.allAssetsUseCases)
    : super(const AssetsInitial()) {
    on<InitializeAssetsEvent>(_onInitialize);
    on<TabChanged>(_onTabChanged);
    on<SearchAssetsEvent>(_onSearch);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<RefreshAssetsEvent>(_onRefreshAssets);
    on<UpdateAppliedCategoryEvent>(_onUpdateAppliedCategory);
    on<UpdateAppliedBrandEvent>(_onUpdateAppliedBrand);
  }

  /* ───────────────────────── INITIALIZATION ───────────────────────── */

  Future<void> _onInitialize(
    InitializeAssetsEvent event,
    Emitter<AssetsState> emit,
  ) async {
    emit(const AssetsLoading(selectedIndex: 0));

    final viewOtherAssets =
        await PreferenceManager().readString('viewOtherAssets') ?? '0';
    final access = int.tryParse(viewOtherAssets) ?? 0;

    final results = await Future.wait([
      _fetchActiveOrPastAssets(0), // Active
      _fetchActiveOrPastAssets(1), // Past
      if (access != 0) _fetchAllAssets(), // All assets + categories + brands
    ]);

    _activeAssetsEntity = results[0] as AssetsEntity?;
    _pastAssetsEntity = results[1] as AssetsEntity?;
    if (access != 0) _allAssetsEntity = results[2] as AllAssetsEntity?;

    // if (_allAssetsEntity == null) {
    //   emit(
    //     const AssetsError(message: 'Unable to fetch assets', selectedIndex: 0),
    //   );
    //   return;
    // }

    emit(
      AssetsLoaded(
        selectedIndex: 0,
        activeAssets: _activeAssetsEntity?.assets ?? <AssetEntity>[],
        pastAssets: _pastAssetsEntity?.assets ?? <AssetEntity>[],
        allAssets: _allAssetsEntity?.assets ?? <AssetDetailEntity>[],
        currentAssets: _activeAssetsEntity?.assets ?? <AssetEntity>[],
        categories: _allAssetsEntity?.categoryList ?? <CategoryListEntity>[],
        brands: _allAssetsEntity?.brandList ?? <BrandListEntity>[],
        appliedCategory: 'All Categories',
        appliedBrand: 'All Brands',
        viewOtherAssetsAccess: access,
      ),
    );
  }

  /* ───────────────────────── TAB CHANGE ───────────────────────── */

  void _onTabChanged(TabChanged event, Emitter<AssetsState> emit) {
    final s = state;
    if (s is! AssetsLoaded) return;

    switch (event.index) {
      case 0:
        emit(s.copyWith(selectedIndex: 0, currentAssets: s.activeAssets));
        break;
      case 1:
        emit(s.copyWith(selectedIndex: 1, currentAssets: s.pastAssets));
        break;
      case 2:
        emit(
          s.copyWith(
            selectedIndex: 2,
            currentAssets: s.allAssets,
            appliedCategory: 'All Categories',
            appliedBrand: 'All Brands',
          ),
        );
        break;
    }
  }

  /* ───────────────────────── SEARCH ───────────────────────── */

  void _onSearch(SearchAssetsEvent event, Emitter<AssetsState> emit) {
    final s = state;
    if (s is! AssetsLoaded) return;

    final query = event.query.trim().toLowerCase();
    if (query.isEmpty) {
      // Reset to full list for the active tab.
      add(TabChanged(s.selectedIndex));
      return;
    }

    List<dynamic> base = _tabList(s.selectedIndex, s);
    List<dynamic> filtered;

    if (s.selectedIndex == 2) {
      // Tab 2 uses AssetDetailEntity → same fields but safer to cast.
      filtered = (base as List<AssetDetailEntity>).where((e) {
        final name = (e.assetsName ?? '').toLowerCase();
        final id = (e.assetsIdView ?? '').toLowerCase();
        return name.contains(query) || id.contains(query);
      }).toList();
    } else {
      filtered = (base as List<AssetEntity>).where((e) {
        final name = (e.assetsName ?? '').toLowerCase();
        final id = (e.assetsIdView ?? '').toLowerCase();
        return name.contains(query) || id.contains(query);
      }).toList();
    }

    emit(s.copyWith(currentAssets: filtered));
  }

  /* ───────────────────────── FILTER (Tab 2 only) ───────────────────────── */

  void _onApplyFilter(ApplyFilterEvent event, Emitter<AssetsState> emit) {
    final s = state;
    if (s is! AssetsLoaded || s.selectedIndex != 2) return;

    final query = event.searchQuery?.trim().toLowerCase() ?? '';

    if (query.isEmpty) {
      // If query is empty, show full list again
      emit(s.copyWith(currentAssets: s.allAssets));
      return;
    }

    final filtered = s.allAssets.where((e) {
      final name = (e.assetsName ?? '').toLowerCase();
      final id = (e.assetsIdView ?? '').toLowerCase();
      return name.contains(query) || id.contains(query);
    }).toList();

    emit(s.copyWith(currentAssets: filtered));
  }

  /* ───────────────────────── REFRESH ───────────────────────── */

  Future<void> _onRefreshAssets(
    RefreshAssetsEvent event,
    Emitter<AssetsState> emit,
  ) async {
    final s = state;
    if (s is! AssetsLoaded) return;

    emit(s.copyWith()); // UI shows pull-to-refresh indicator

    final freshActive = await _fetchActiveOrPastAssets(0);
    final freshPast = await _fetchActiveOrPastAssets(1);
    final freshAll = await _fetchAllAssets();

    _activeAssetsEntity = freshActive;
    _pastAssetsEntity = freshPast;
    _allAssetsEntity = freshAll;

    emit(
      s.copyWith(
        activeAssets: freshActive?.assets ?? <AssetEntity>[],
        pastAssets: freshPast?.assets ?? <AssetEntity>[],
        allAssets: freshAll?.assets ?? <AssetDetailEntity>[],
        categories: freshAll?.categoryList ?? <CategoryListEntity>[],
        brands: freshAll?.brandList ?? <BrandListEntity>[],
        currentAssets: _tabList(
          s.selectedIndex,
          s, // old state, but we only need index
          freshActive?.assets,
          freshPast?.assets,
          freshAll?.assets,
        ),
      ),
    );
  }

  /* ───────────────────────── HELPERS ───────────────────────── */

  List<dynamic> _tabList(
    int index,
    AssetsLoaded s, [
    List<AssetEntity>? freshActive,
    List<AssetEntity>? freshPast,
    List<AssetDetailEntity>? freshAll,
  ]) {
    switch (index) {
      case 0:
        return freshActive ?? s.activeAssets;
      case 1:
        return freshPast ?? s.pastAssets;
      case 2:
        return freshAll ?? s.allAssets;
      default:
        return <dynamic>[];
    }
  }

  Future<AssetsEntity?> _fetchActiveOrPastAssets(int index) async {
    final dataMap = {
      'getAssetsNew': 'getAssetsNew',
      'society_id': '1',
      'unit_id': '1718',
      'user_id': '1679',
      'language_id': '1',
      'floor_id': '1',
      'old_items': _mapIndexToOldItems(index),
    };

    final result = await assetsUseCases.getAssets(dataMap);
    return result.fold((l) => null, (r) => r);
  }

  Future<AllAssetsEntity?> _fetchAllAssets() async {
    final dataMap = {
      'getOtherAssets': 'getOtherAssets',
      'user_id': '1679',
      'society_id': '1',
      'language_id': '1',
      'floor_id': '1',
      'assets_category_id': '',
      'brand_name': '',
      'filter': '1',
      'view_other_assets': '2',
    };
    final result = await allAssetsUseCases.getAllAssets(dataMap);
    return result.fold((l) => null, (r) => r);
  }

  String _mapIndexToOldItems(int i) => i == 1 ? '1' : '0';

  /* ───────────────────────── CATEGORY FILTER ───────────────────────── */
  void _onUpdateAppliedCategory(
    UpdateAppliedCategoryEvent event,
    Emitter<AssetsState> emit,
  ) {
    final s = state;
    if (s is! AssetsLoaded) return;

    final newCategory = event.category;
    final currentBrand = s.appliedBrand ?? 'All Brands';

    if (s.selectedIndex == 2) {
      final filtered = s.allAssets.where((e) {
        final catOk =
            newCategory == 'All Categories' || e.assetsCategory == newCategory;
        final brOk =
            currentBrand == 'All Brands' || e.assetsBrandName == currentBrand;
        return catOk && brOk;
      }).toList();

      emit(s.copyWith(appliedCategory: newCategory, currentAssets: filtered));
    } else {
      emit(s.copyWith(appliedCategory: newCategory));
    }
  }

  /* ───────────────────────── BRAND FILTER ───────────────────────── */
  void _onUpdateAppliedBrand(
    UpdateAppliedBrandEvent event,
    Emitter<AssetsState> emit,
  ) {
    final s = state;
    if (s is! AssetsLoaded) return;

    final newBrand = event.brand;
    final currentCategory = s.appliedCategory ?? 'All Categories';

    if (s.selectedIndex == 2) {
      final filtered = s.allAssets.where((e) {
        final catOk =
            currentCategory == 'All Categories' ||
            e.assetsCategory == currentCategory;
        final brOk = newBrand == 'All Brands' || e.assetsBrandName == newBrand;
        return catOk && brOk;
      }).toList();

      emit(s.copyWith(appliedBrand: newBrand, currentAssets: filtered));
    } else {
      emit(s.copyWith(appliedBrand: newBrand));
    }
  }
}
