import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:myco_flutter/features/dashboard/data/models/home_menu_response.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';

part 'home_menu_event.dart';
part 'home_menu_state.dart';

class HomeMenuBloc extends Bloc<HomeMenuEvent, HomeMenuState> {
  final DashboardLocalDataSource _localDataSource;

  HomeMenuBloc({required DashboardLocalDataSource localDataSource})
      : _localDataSource = localDataSource,
        super(HomeMenuInitial()) {
    on<HomeMenuFetched>(_onHomeMenuFetched);
    on<HomeMenuSearchChanged>(_onHomeMenuSearchChanged);
  }

  /// Handles the event to fetch the initial menu data from the cache.
  Future<void> _onHomeMenuFetched(
    HomeMenuFetched event,
    Emitter<HomeMenuState> emit,
  ) async {
    emit(HomeMenuLoading());
    try {
      // Fetch the raw model from the local data source.
      final cachedMenuModel = await _localDataSource.getHomeMenu();
      if (cachedMenuModel != null) {
        // Convert the model to an entity for the domain/presentation layer.
        final homeMenuEntity = cachedMenuModel.toEntity();
        final groupedItems = _groupMenuItems(homeMenuEntity.appmenu??[]);
        
        // Emit the success state with the initial, unfiltered data.
        emit(HomeMenuLoaded(
          homeMenuData: homeMenuEntity,
          allItemsGrouped: groupedItems,
          filteredCategories: homeMenuEntity.menuCategory??[],
          filteredItemsGrouped: groupedItems,
        ));
      } else {
        emit(const HomeMenuError('No cached data found. Please refresh.'));
      }
    } catch (e) {
      emit(HomeMenuError('Failed to load menu: ${e.toString()}'));
    }
  }

  /// Handles the event for when the search query changes.
  void _onHomeMenuSearchChanged(
    HomeMenuSearchChanged event,
    Emitter<HomeMenuState> emit,
  ) {
    final currentState = state;
    if (currentState is HomeMenuLoaded) {
      final query = event.query.toLowerCase();

      // If the query is empty, reset the filter to show all items.
      if (query.isEmpty) {
        emit(currentState.copyWith(
          filteredCategories: currentState.homeMenuData.menuCategory,
          filteredItemsGrouped: currentState.allItemsGrouped,
          searchQuery: '',
        ));
        return;
      }

      // Perform the filtering logic.
      final Map<String, List<AppMenuEntity>> filteredGroupedMenu = {};
      final List<MenuCategoryEntity> filteredCategories = [];

      for (final category in currentState.homeMenuData.menuCategory??[]) {
        final List<AppMenuEntity> matchingItems =
            (currentState.allItemsGrouped[category.menuCategoryId] ?? [])
                .where((item) {
          final title = item.menuTitle?.toLowerCase() ?? '';
          final searchTitle = item.menuTitleSearch?.toLowerCase() ?? '';
          return title.contains(query) || searchTitle.contains(query);
        }).toList();

        // Only include categories that have matching items.
        if (matchingItems.isNotEmpty) {
          filteredCategories.add(category);
          filteredGroupedMenu[category.menuCategoryId!] = matchingItems;
        }
      }

      // Emit a new state with the filtered results.
      emit(currentState.copyWith(
        filteredCategories: filteredCategories,
        filteredItemsGrouped: filteredGroupedMenu,
        searchQuery: event.query,
      ));
    }
  }

  /// Helper function to group a flat list of menu items into a map by category ID.
  Map<String, List<AppMenuEntity>> _groupMenuItems(List<AppMenuEntity> menuItems) {
    final Map<String, List<AppMenuEntity>> categorizedMenu = {};
    for (AppMenuEntity item in menuItems) {
      if (item.menuCategoryId != null) {
        if (!categorizedMenu.containsKey(item.menuCategoryId!)) {
          categorizedMenu[item.menuCategoryId!] = [];
        }
        categorizedMenu[item.menuCategoryId!]!.add(item);
      }
    }
    return categorizedMenu;
  }
}
