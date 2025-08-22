import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myco_flutter/features/sign_in/presentation/custom_bloc/my_form_event.dart';
import 'package:myco_flutter/features/sign_in/presentation/custom_bloc/my_form_state.dart';

// In my_form_bloc.dart

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc() : super(const MyFormState()) {
    on<UpdateSelectedData>(_onUpdateSelectedData);
  }

  void _onUpdateSelectedData(UpdateSelectedData event, Emitter<MyFormState> emit,) {

    final newState = state.copyWith(
      selectedId: event.id,
      selectedName: event.name,
      fieldKey: event.fieldKey,
      status: FormStatus.success,
    );
    emit(newState);
  }
}