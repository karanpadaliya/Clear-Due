import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/appointments/data/models/request/add_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/approve_appointment_entity_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/delete_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_my_appointments_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/reject_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/send_appointment_reminder_request_model.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class GetAppointmentEvent extends AppointmentEvent {
  final GetAppointmentRequestModel params;

  const GetAppointmentEvent(this.params);
}

class GetMyAppointmentEvent extends AppointmentEvent {
  final GetMyAppointmentsRequestModel params;

  const GetMyAppointmentEvent(this.params);
}

class ApprovedAppointmentEvent extends AppointmentEvent {
  final ApproveAppointmentRequestModel params;

  const ApprovedAppointmentEvent(this.params);
}

class RejectAppointmentEvent extends AppointmentEvent {
  final RejectAppointmentRequestModel params;

  const RejectAppointmentEvent(this.params);
}

class DeleteAppointmentEvent extends AppointmentEvent {
  final DeleteAppointmentRequestModel params;

  const DeleteAppointmentEvent(this.params);
}

class SendAppointmentReminderEvent extends AppointmentEvent {
  final SendAppointmentReminderRequestModel params;

  const SendAppointmentReminderEvent(this.params);
}

class AddAppointmentEvent extends AppointmentEvent {
  final AddAppointmentRequestModel params;

  const AddAppointmentEvent(this.params);
}

class OnSearchEvent extends AppointmentEvent {
  final String query;

  const OnSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}
