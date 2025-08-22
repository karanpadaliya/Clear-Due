import 'package:equatable/equatable.dart';

abstract class AssetsEvent extends Equatable {
  const AssetsEvent();
  @override
  List<Object?> get props => [];
}

/// Dispatched on initial load (fetches everything in background, tab 0 active)
class InitializeAssetsEvent extends AssetsEvent {
  const InitializeAssetsEvent();
}

/// Dispatched when user taps a tab (updates selected tab and uses cached data if possible)
class TabChanged extends AssetsEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object?> get props => [index];
}

/// Dispatched when user performs a search on asset list
class SearchAssetsEvent extends AssetsEvent {
  final String query;

  const SearchAssetsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Fired when the user selects a category / brand in the filter UI.
class ApplyFilterEvent extends AssetsEvent {
  final String? searchQuery;
  const ApplyFilterEvent({this.searchQuery});
  @override
  List<Object?> get props => [searchQuery];
}


/// Optional pull-to-refresh.
class RefreshAssetsEvent extends AssetsEvent {
  const RefreshAssetsEvent();
}

class UpdateAppliedCategoryEvent extends AssetsEvent {
  final String category;

  const UpdateAppliedCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateAppliedBrandEvent extends AssetsEvent {
  final String brand;

  const UpdateAppliedBrandEvent(this.brand);

  @override
  List<Object?> get props => [brand];
}

