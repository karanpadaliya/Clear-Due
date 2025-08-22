import 'package:equatable/equatable.dart';

abstract class LostAndFoundEvent extends Equatable {
  const LostAndFoundEvent();

  @override
  List<Object?> get props => [];
}

class GetLostAndFoundItemsEvent extends LostAndFoundEvent {
  final Map<String, String?> request;
  const GetLostAndFoundItemsEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class AddLostAndFoundItemsEvent extends LostAndFoundEvent {
  final Map<String, String?> request;
  const AddLostAndFoundItemsEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class EditLostAndFoundItemsEvent extends LostAndFoundEvent {
  final Map<String, String?> request;
  const EditLostAndFoundItemsEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class DeleteLostAndFoundItemsEvent extends LostAndFoundEvent {
  final Map<String, String?> request;
  const DeleteLostAndFoundItemsEvent(this.request);

  @override
  List<Object?> get props => [request];
}
