import 'package:equatable/equatable.dart';

abstract class GetAssetInformationEvent extends Equatable {
  const GetAssetInformationEvent();

  @override
  List<Object?> get props => [];
}

class FetchAssetInformationEvent extends GetAssetInformationEvent {
  final String assetId ;

  const FetchAssetInformationEvent({required this.assetId});

  @override
  List<Object?> get props => [assetId];
}
