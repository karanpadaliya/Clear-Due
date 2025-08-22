import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/bloc/custom_toggle_switch_event.dart';
import 'package:myco_flutter/widgets/custom_toggle_switch/bloc/custom_toggle_switch_state.dart';

class CustomToggleSwitchBloc
    extends Bloc<CustomToggleSwitchEvent, CustomToggleSwitchState> {
  CustomToggleSwitchBloc(bool initialValue)
    : super(CustomToggleSwitchState(isOn: initialValue)) {
    on<ToggleSwitchToggled>((event, emit) {
      emit(CustomToggleSwitchState(isOn: !state.isOn));
    });

    on<ToggleSwitchSetInitial>((event, emit) {
      emit(CustomToggleSwitchState(isOn: event.initialValue));
    });
  }
}
