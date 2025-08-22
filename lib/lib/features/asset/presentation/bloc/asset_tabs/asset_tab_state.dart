import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/asset/domain/entities/all_assets_entity.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_entity.dart';

abstract class AssetsState extends Equatable {
  final int selectedIndex;
  const AssetsState({required this.selectedIndex});
  @override
  List<Object?> get props => [selectedIndex];
}

class AssetsInitial extends AssetsState {
  const AssetsInitial() : super(selectedIndex: 0);
}

class AssetsLoading extends AssetsState {
  const AssetsLoading({required super.selectedIndex});
}

class AssetsLoaded extends AssetsState {
  // ───────────────────── Raw Lists ─────────────────────
  final List<AssetEntity> activeAssets;
  final List<AssetEntity> pastAssets;
  final List<AssetDetailEntity> allAssets;
  final List<dynamic> currentAssets;

  final List<CategoryListEntity> categories;
  final List<BrandListEntity> brands;
  final String? appliedCategory;
  final String? appliedBrand;
  final int viewOtherAssetsAccess;

  const AssetsLoaded({
    required super.selectedIndex,
    required this.activeAssets,
    required this.pastAssets,
    required this.allAssets,
    required this.currentAssets,
    required this.categories,
    required this.brands,
    this.appliedCategory,
    this.appliedBrand,
    required this.viewOtherAssetsAccess,
  });

  @override
  List<Object?> get props => [
    activeAssets,
    pastAssets,
    allAssets,
    currentAssets,
    categories,
    brands,
    appliedCategory,
    appliedBrand,
    selectedIndex,
    viewOtherAssetsAccess,
  ];

  AssetsLoaded copyWith({
    List<AssetEntity>? activeAssets,
    List<AssetEntity>? pastAssets,
    List<AssetDetailEntity>? allAssets,
    List<dynamic>? currentAssets,
    List<CategoryListEntity>? categories,
    List<BrandListEntity>? brands,
    String? appliedCategory,
    String? appliedBrand,
    int? selectedIndex,
    int? viewOtherAssetsAccess,
  }) => AssetsLoaded(
    activeAssets: activeAssets ?? this.activeAssets,
    pastAssets: pastAssets ?? this.pastAssets,
    allAssets: allAssets ?? this.allAssets,
    currentAssets: currentAssets ?? this.currentAssets,
    categories: categories ?? this.categories,
    brands: brands ?? this.brands,
    appliedCategory: appliedCategory ?? this.appliedCategory,
    appliedBrand: appliedBrand ?? this.appliedBrand,
    selectedIndex: selectedIndex ?? this.selectedIndex,
    viewOtherAssetsAccess: viewOtherAssetsAccess ?? this.viewOtherAssetsAccess,
  );
}

class AssetsError extends AssetsState {
  final String message;
  const AssetsError({required this.message, required super.selectedIndex});
  @override
  List<Object?> get props => [message, selectedIndex];
}
