part of 'custom_notification_bloc.dart';

sealed class CustomNotificationState extends Equatable {
  const CustomNotificationState();

  @override
  List<Object?> get props => [];
}

final class CustomNotificationInitial extends CustomNotificationState {}

final class CustomNotificationLoaded extends CustomNotificationState {
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? notificationTime;

  const CustomNotificationLoaded({
    this.imageUrl,
    this.title,
    this.description,
    this.notificationTime,
  });

  @override
  List<Object?> get props => [imageUrl, title, description, notificationTime];
}