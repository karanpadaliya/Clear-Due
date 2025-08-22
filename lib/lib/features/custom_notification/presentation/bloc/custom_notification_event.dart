part of 'custom_notification_bloc.dart';

sealed class CustomNotificationEvent extends Equatable {
  const CustomNotificationEvent();

  @override
  List<Object?> get props => [];
}

class LoadCustomNotification extends CustomNotificationEvent {
  final String? imageUrl;
  final String? title;
  final String? description;
  final String? notificationTime;

  const LoadCustomNotification({
    this.imageUrl,
    this.title,
    this.description,
    this.notificationTime,
  });

  @override
  List<Object?> get props => [imageUrl, title, description, notificationTime];
}