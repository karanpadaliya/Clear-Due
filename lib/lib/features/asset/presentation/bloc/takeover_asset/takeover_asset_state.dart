import 'package:equatable/equatable.dart';

abstract class TakeoverAssetState extends Equatable {
  const TakeoverAssetState();

  @override
  List<Object> get props => [];
}

class TakeoverAssetInitial extends TakeoverAssetState {}

// block api success
class TakeoverAssetApiSuccess extends TakeoverAssetState {
  final bool toOtherEmployee;
  const TakeoverAssetApiSuccess({required this.toOtherEmployee});

  @override
  List<Object> get props => [toOtherEmployee];
}
