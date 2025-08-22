import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'custom_notification_event.dart';
part 'custom_notification_state.dart';

class CustomNotificationBloc extends Bloc<CustomNotificationEvent, CustomNotificationState> {
  CustomNotificationBloc() : super(CustomNotificationInitial()) {
    on<LoadCustomNotification>(_onLoadCustomNotification);
  }

  void _onLoadCustomNotification(
    LoadCustomNotification event,
    Emitter<CustomNotificationState> emit,
  ) {
    emit(CustomNotificationLoaded(
      imageUrl: event.imageUrl,
      title: event.title,
      description: event.description,
      notificationTime: event.notificationTime,
    ));
  }
}