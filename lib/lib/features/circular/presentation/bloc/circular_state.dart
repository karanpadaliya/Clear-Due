part of 'circular_bloc.dart';

abstract class CircularState extends Equatable {
  const CircularState();

  @override
  List<Object> get props => [];
}

class CircularInitial extends CircularState {}

class CircularApiLoading extends CircularState {}

class CircularSingleApiLoading extends CircularState {}


// block api success
class NoticeFilterApiSuccess extends CircularState {
  final NoticeBoardResponseEntity response;
  const NoticeFilterApiSuccess(this.response);

  @override
  List<Object> get props => [response];
}

// block api success
class NoticeSingleApiSuccess extends CircularState {
  final NoticeBoardResponseEntity response;
  const NoticeSingleApiSuccess(this.response);

  @override
  List<Object> get props => [response];
}


class CircularApiError extends CircularState {
  final String message;
  const CircularApiError(this.message);

  @override
  List<Object> get props => [message];
}

class CircularSingleApiError extends CircularState {
  final String message;
  const CircularSingleApiError(this.message);

  @override
  List<Object> get props => [message];
}