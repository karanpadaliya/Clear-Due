import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/bloc/phone_number_field_event.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/bloc/phone_number_field_state.dart';

class PhoneNumberFieldBloc
    extends Bloc<PhoneNumberFieldEvent, PhoneNumberFieldState> {
  PhoneNumberFieldBloc() : super(PhoneNumberFieldInitial()) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<PhoneNumberFieldState> emit,
  ) {
    emit(PhoneNumberFieldLoaded(event.PhoneNumber));
  }
}
