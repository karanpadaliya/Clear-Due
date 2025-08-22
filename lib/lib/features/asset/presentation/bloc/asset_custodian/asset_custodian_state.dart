import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/asset/domain/entities/add_asset_user_entity.dart';

abstract class CustodianUserState extends Equatable {
  const CustodianUserState();

  @override
  List<Object> get props => [];
}

class CustodianUserInitial extends CustodianUserState {}

class CustodianUserLoading extends CustodianUserState {}

// block api success
class CustodianUserApiSuccess extends CustodianUserState {
  final AddAssetUserEntity userEntity;
  const CustodianUserApiSuccess(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}


class CustodianUserApiError extends CustodianUserState {
  final String message;
  const CustodianUserApiError(this.message);

  @override
  List<Object> get props => [message];
}