import 'package:equatable/equatable.dart';

abstract class TakeoverAssetEvent extends Equatable {
  const TakeoverAssetEvent();

  @override
  List<Object> get props => [];
}

// uploaded image and pdf api
class HandoverToOtherEmployeeEvent extends TakeoverAssetEvent {
  final bool toOtherEmployeee;

  const HandoverToOtherEmployeeEvent({required this.toOtherEmployeee});

  @override
  List<Object> get props => [toOtherEmployeee];
}
