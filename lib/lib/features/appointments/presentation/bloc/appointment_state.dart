import 'package:equatable/equatable.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/features/appointments/domain/entities/appointment_entities_model.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {
  const AppointmentInitial();
}

class AppointmentLoading extends AppointmentState {
  const AppointmentLoading();
}

class AppointmentLoaded extends AppointmentState {
  final AppointmentEntityModel appointmentRequestsData;
  final AppointmentEntityModel myAppointmentsData;
  final CommonResponseModelEntity commonResponse;
  final String searchQuery;

  const AppointmentLoaded({
    this.appointmentRequestsData = const AppointmentEntityModel(),
    this.myAppointmentsData = const AppointmentEntityModel(),
    this.searchQuery = '',
    this.commonResponse = const CommonResponseModelEntity(),
  });

  List<MyAppointmentEntity> get filteredAppointmentRequests {
    final all = appointmentRequestsData.myAppointments ?? [];
    if (searchQuery.trim().isEmpty) return all;

    return all.where((item) {
      final name = item.userFullName?.toLowerCase() ?? '';
      final agenda = item.appointmentAgenda?.toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return name.contains(query) || agenda.contains(query);
    }).toList();
  }

  List<MyAppointmentEntity> get filteredMyAppointments {
    final all = myAppointmentsData.myAppointments ?? [];
    if (searchQuery.trim().isEmpty) return all;

    return all.where((item) {
      final name = item.userFullName?.toLowerCase() ?? '';
      final agenda = item.appointmentAgenda?.toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return name.contains(query) || agenda.contains(query);
    }).toList();
  }

  @override
  List<Object?> get props => [
    appointmentRequestsData,
    myAppointmentsData,
    searchQuery,
    commonResponse,
  ];

  AppointmentLoaded copyWith({
    AppointmentEntityModel? appointmentRequestsData,
    AppointmentEntityModel? myAppointmentsData,
    String? searchQuery,
    CommonResponseModelEntity? commonResponse,
  }) => AppointmentLoaded(
    appointmentRequestsData:
        appointmentRequestsData ?? this.appointmentRequestsData,
    myAppointmentsData: myAppointmentsData ?? this.myAppointmentsData,
    searchQuery: searchQuery ?? this.searchQuery,
    commonResponse: commonResponse ?? this.commonResponse,
  );
}

class CommonResponseAppointment extends AppointmentState {
  final CommonResponseModelEntity commonResponse;

  const CommonResponseAppointment(this.commonResponse);

  @override
  List<Object?> get props => [commonResponse];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object?> get props => [message];
}
