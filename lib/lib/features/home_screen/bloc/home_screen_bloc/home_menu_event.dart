part of 'home_menu_bloc.dart';

/// Base class for all events related to the Home Menu.
abstract class HomeMenuEvent extends Equatable {
  const HomeMenuEvent();

  @override
  List<Object> get props => [];
}

/// Event to signal that the home menu data should be fetched from the cache.
class HomeMenuFetched extends HomeMenuEvent {}

/// Event to signal that the search query has changed and the menu list should be filtered.
class HomeMenuSearchChanged extends HomeMenuEvent {
  final String query;

  const HomeMenuSearchChanged(this.query);

  @override
  List<Object> get props => [query];
}
