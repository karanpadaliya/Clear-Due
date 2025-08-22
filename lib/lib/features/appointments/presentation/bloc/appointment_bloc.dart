import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/appointments/domain/usecases/appointment_usecase.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentUseCase useCase;

  AppointmentBloc(this.useCase) : super(const AppointmentInitial()) {
    on<GetAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());
      try {
        final result = await useCase.getAppointment(event.params);
        result.fold((failure) => emit(AppointmentError(failure.message)), (
          getAppointment,
        ) {
          final currentState = state is AppointmentLoaded
              ? state as AppointmentLoaded
              : const AppointmentLoaded();
          emit(currentState.copyWith(appointmentRequestsData: getAppointment));
        });
      } catch (e) {
        emit(const AppointmentError('Failed to load getAppointment'));
      }
    });

    on<GetMyAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());
      try {
        final result = await useCase.getMyAppointment(event.params);
        result.fold(
          (failure) {
            emit(AppointmentError(failure.message));
          },
          (getMyAppointment) {
            final currentState = state is AppointmentLoaded
                ? state as AppointmentLoaded
                : const AppointmentLoaded();
            emit(currentState.copyWith(myAppointmentsData: getMyAppointment));
          },
        );
      } catch (e) {
        emit(const AppointmentError('Failed to load getMyAppointment'));
      }
    });

    on<ApprovedAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());
      try {
        final result = await useCase.approvedAppointment(event.params);
        result.fold((failure) => emit(AppointmentError(failure.message)), (
          approvedAppointment,
        ) {
          emit(CommonResponseAppointment(approvedAppointment));
        });
      } catch (e) {
        emit(const AppointmentError('Failed to load approved appointment'));
      }
    });

    on<RejectAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());
      try {
        final result = await useCase.rejectAppointment(event.params);
        result.fold((failure) => emit(AppointmentError(failure.message)), (
          rejectAppointment,
        ) {
          emit(CommonResponseAppointment(rejectAppointment));
        });
      } catch (e) {
        emit(const AppointmentError('Failed to load reject appointment'));
      }
    });

    on<DeleteAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());

      try {
        final result = await useCase.deleteAppointment(event.params);
        result.fold((failure) => emit(AppointmentError(failure.message)), (
          deleteAppointment,
        ) {
          emit(CommonResponseAppointment(deleteAppointment));
        });
      } catch (e) {
        emit(const AppointmentError('Failed to load Delete Appointment'));
      }
    });

    on<SendAppointmentReminderEvent>((event, emit) async {
      emit(const AppointmentLoading());

      try {
        final result = await useCase.sendAppointmentReminder(event.params);
        result.fold(
          (failure) => emit(AppointmentError(failure.message)),
          (sendAppointmentReminder) =>
              emit(CommonResponseAppointment(sendAppointmentReminder)),
        );
      } catch (e) {
        emit(const AppointmentError('Failed to Send Reminder Appointment'));
      }
    });

    on<OnSearchEvent>((event, emit) {
      if (state is AppointmentLoaded) {
        final currentState = state as AppointmentLoaded;
        emit(currentState.copyWith(searchQuery: event.query));
      }
    });

    on<AddAppointmentEvent>((event, emit) async {
      emit(const AppointmentLoading());
      try {
        final result = await useCase.addAppointment(event.params);
        result.fold((failure) => emit(AppointmentError(failure.message)), (
          addAppointment,
        ) {
          emit(CommonResponseAppointment(addAppointment));
        });
      } catch (e) {
        emit(const AppointmentError('Failed to Add Appointment'));
      }
    });
  }
}
