part of 'circular_bloc.dart';

abstract class CircularEvent extends Equatable {
  const CircularEvent();

  @override
  // Use List<Object?> to allow nullable properties in the props list
  // for any subclassed events.
  List<Object?> get props => [];
}

// Event for fetching the list of notices
class NoticeFilterList extends CircularEvent {
  final String startDate;
  final String endDate;

  const NoticeFilterList({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

// Event for fetching a single notice detail
class NoticeSingleFetch extends CircularEvent {
  final String? noticeId;
  const NoticeSingleFetch({this.noticeId});

  @override
  // Corrected syntax for the props list
  List<Object?> get props => [noticeId];
}