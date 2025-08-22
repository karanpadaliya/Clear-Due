import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/asset/domain/entities/asset_information_entity.dart';

abstract class GetAssetInformationState extends Equatable {
  const GetAssetInformationState();

  @override
  List<Object?> get props => [];
}

class GetAssetInformationInitial extends GetAssetInformationState {}

class GetAssetInformationLoading extends GetAssetInformationState {}

class GetAssetInformationLoaded extends GetAssetInformationState {
  final AssetInformationEntity assetInformation;

  const GetAssetInformationLoaded({required this.assetInformation});

  @override
  List<Object?> get props => [assetInformation];
}

class GetAssetInformationError extends GetAssetInformationState {
  final String message;

  const GetAssetInformationError({required this.message});

  @override
  List<Object?> get props => [message];
}
