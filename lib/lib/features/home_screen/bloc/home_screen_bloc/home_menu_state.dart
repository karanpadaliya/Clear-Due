part of 'home_menu_bloc.dart';

/// Base class for all states related to the Home Menu.
abstract class HomeMenuState extends Equatable {
  const HomeMenuState();

  @override
  List<Object> get props => [];
}

/// The initial state before any action has been taken.
class HomeMenuInitial extends HomeMenuState {}

/// The state indicating that data is currently being loaded.
class HomeMenuLoading extends HomeMenuState {}

/// The state representing that the menu data has been successfully loaded.
class HomeMenuLoaded extends HomeMenuState {
  /// The original, complete data set from the cache.
  final HomeMenuResponseEntity homeMenuData;
  
  /// The original, complete map of all menu items grouped by category ID.
  final Map<String, List<AppMenuEntity>> allItemsGrouped;

  /// The list of categories to be displayed after applying the search filter.
  final List<MenuCategoryEntity> filteredCategories;

  /// The map of menu items to be displayed after applying the search filter.
  final Map<String, List<AppMenuEntity>> filteredItemsGrouped;

  /// The current search query string.
  final String searchQuery;

  const HomeMenuLoaded({
    required this.homeMenuData,
    required this.allItemsGrouped,
    required this.filteredCategories,
    required this.filteredItemsGrouped,
    this.searchQuery = '',
  });

  /// Creates a copy of the current state with updated values.
  HomeMenuLoaded copyWith({
    HomeMenuResponseEntity? homeMenuData,
    Map<String, List<AppMenuEntity>>? allItemsGrouped,
    List<MenuCategoryEntity>? filteredCategories,
    Map<String, List<AppMenuEntity>>? filteredItemsGrouped,
    String? searchQuery,
  }) {
    return HomeMenuLoaded(
      homeMenuData: homeMenuData ?? this.homeMenuData,
      allItemsGrouped: allItemsGrouped ?? this.allItemsGrouped,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      filteredItemsGrouped: filteredItemsGrouped ?? this.filteredItemsGrouped,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [
        homeMenuData,
        allItemsGrouped,
        filteredCategories,
        filteredItemsGrouped,
        searchQuery,
      ];
}

/// The state indicating that an error occurred while fetching or processing data.
class HomeMenuError extends HomeMenuState {
  final String message;

  const HomeMenuError(this.message);

  @override
  List<Object> get props => [message];
}
