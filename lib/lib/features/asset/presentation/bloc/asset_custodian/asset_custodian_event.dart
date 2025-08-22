import 'package:equatable/equatable.dart';

abstract class CustodianUserEvent extends Equatable {
  const CustodianUserEvent();

  @override
  List<Object> get props => [];
}

// uploaded image and pdf api
class FetchCustodianUser extends CustodianUserEvent {
  final String blockId;
  final String floorId;

  const FetchCustodianUser({required this.blockId, required this.floorId});

  @override
  List<Object> get props => [blockId, floorId];
}
