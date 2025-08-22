import 'package:equatable/equatable.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';

abstract class LostAndFoundState extends Equatable {
  const LostAndFoundState();

  @override
  List<Object?> get props => [];
}

class LostAndFoundInitial extends LostAndFoundState {}

class LostAndFoundLoading extends LostAndFoundState {}

class LostAndFoundLoaded extends LostAndFoundState {
  final List<LostFoundEntity> items;
  final String userId;
  final bool menuChat;

  const LostAndFoundLoaded(
      this.items,
      this.userId, {
        required this.menuChat,
      });

  @override
  List<Object?> get props => [items, userId, menuChat];
}

class LostAndFoundError extends LostAndFoundState {
  final String message;
  const LostAndFoundError(this.message);

  @override
  List<Object?> get props => [message];
}

class LostAndFoundItemAddedSuccess extends LostAndFoundState {
  final CommonResponseModelEntity response;
  const LostAndFoundItemAddedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LostAndFoundItemEditedSuccess extends LostAndFoundState {
  final CommonResponseModelEntity response;
  const LostAndFoundItemEditedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LostAndFoundItemDeletedSuccess extends LostAndFoundState {
  final CommonResponseModelEntity response;
  const LostAndFoundItemDeletedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}