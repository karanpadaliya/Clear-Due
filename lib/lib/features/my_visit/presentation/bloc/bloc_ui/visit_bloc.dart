import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'visit_event.dart';
part 'visit_state.dart';

class VisitBloc extends Bloc<VisitEvent, VisitState> {
  CameraController? _controller;
  Timer? _dateTimeTimer, _scanningTimer;
  String _dateTime = '';
  String _scanState = 'scanning';

  VisitBloc() : super(VisitInitial()) {
    on<InitVisit>(_onInitVisit);
    on<LaunchCamera>(_onLaunchCamera);
    on<StartDateTime>(_onStartDateTime);
    on<UpdateDateTime>(_onUpdateDateTime);
    on<UpdateScanningState>(_onUpdateScanningState);
    on<StartScanningTimer>(_onStartScanningTimer);
    on<UpdateProgress>(_onUpdateProgress);
    on<AddBranchTagFromSheet>(_onAddBranch);
    on<RemoveBranchTag>(_onRemoveBranch);
    on<AddDepartmentTagFromSheet>(_onAddDepartment);
    on<RemoveDepartmentTag>(_onRemoveDepartment);
    on<TabChanged>(_ontabchange);
    on<UpdateSelectedDate>(_onDateUpdate);
    on<NextDate>(_onNextDate);
    on<PreviousDate>(_onPreviousDate);
    on<ToggleEmployeeSelection>(_onToggleEmployeeSelection);
    on<ToggleAutoExpence>(_onTapAutoExpence);
    on<UpdateContactPerson>(_onContactPersonCodeUpdate);
    on<UpdateAlternativePhone>(_onAlternativePhoneUpdate);
    on<CitySelectionEvent>(_onCitySelection);
    on<AreaSelectionEvent>(_onAreaSelection);
    on<UpdateVisitTypeAndTapEvent>(_onUpdateVisitTypeAndTap);
  }

  ///face Detection
  Future<void> _onLaunchCamera(
    LaunchCamera event,
    Emitter<VisitState> emit,
  ) async {
    emit(VisitLoading());
    try {
      _controller?.dispose();
      final cams = await availableCameras();
      final front = cams.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
      );
      _controller = CameraController(
        front,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      emit(
        VisitLoaded(
          cameraController: _controller,
          dateTime: '',
          scanningState: _scanState,
          remainingTime: '02:00',
          progress: 0.0,
        ),
      );
      add(StartDateTime());
      add(StartScanningTimer());
    } catch (err) {
      emit(VisitError(message: err.toString()));
    }
  }

  void _onStartDateTime(StartDateTime event, Emitter<VisitState> emit) {
    _dateTimeTimer?.cancel();
    _dateTimeTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _dateTime = DateFormat('d-MM-yyyy h:mm:ss a').format(DateTime.now());
      add(UpdateDateTime(formattedDateAndTime: _dateTime));
    });
  }

  void _onUpdateDateTime(UpdateDateTime event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      emit(
        (state as VisitLoaded).copyWith(dateTime: event.formattedDateAndTime),
      );
    }
  }

  void _onUpdateScanningState(
    UpdateScanningState event,
    Emitter<VisitState> emit,
  ) {
    _scanState = event.scanningState;
    if (state is VisitLoaded) {
      emit((state as VisitLoaded).copyWith(scanningState: _scanState));
    }
  }

  void _onStartScanningTimer(
    StartScanningTimer event,
    Emitter<VisitState> emit,
  ) {
    const total = 120;
    int counter = 0;
    _scanningTimer?.cancel();
    _scanningTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state is! VisitLoaded) return t.cancel();
      if (counter >= total || _scanState == 'success') {
        t.cancel();
        if (_scanState != 'success') {
          add(UpdateScanningState(scanningState: 'failure'));
        }
        return;
      }
      counter++;
      final rem =
          '${((total - counter) ~/ 60).toString().padLeft(2, '0')}:${((total - counter) % 60).toString().padLeft(2, '0')}';
      final prog = counter / total;
      add(UpdateProgress(progress: prog, remainingTime: rem));
    });
  }

  void _onUpdateProgress(UpdateProgress event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      emit(
        (state as VisitLoaded).copyWith(
          progress: event.progress,
          remainingTime: event.remainingTime,
        ),
      );
    }
  }

  ///Tag_input logic
  void _onInitVisit(InitVisit event, Emitter<VisitState> emit) {
    if (state is! VisitLoaded) {
      emit(
        VisitLoaded(
          dateTime: '',
          scanningState: 'idle',
          remainingTime: '00:00',
          progress: 0.0,
          branchTags: [],
          departmentTags: [],
        ),
      );
    }
  }

  void _onAddBranch(AddBranchTagFromSheet event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      final updatedBranchTags = List<Map<String, String>>.from(
        currentState.branchTags,
      )..add({'id': event.id, 'name': event.branchTag});

      emit(currentState.copyWith(branchTags: updatedBranchTags));
    }
  }

  void _onRemoveBranch(RemoveBranchTag event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final newState = state as VisitLoaded;
      final updatedBranchTags = List<Map<String, String>>.from(
        newState.branchTags,
      )..removeWhere((tag) => tag['name'] == event.branchTag);

      final updatedDepartmentTags = updatedBranchTags.isEmpty
          ? <Map<String, String>>[]
          : newState.departmentTags;

      emit(
        newState.copyWith(
          branchTags: updatedBranchTags,
          departmentTags: updatedDepartmentTags,
        ),
      );
    }
  }

  void _onAddDepartment(
    AddDepartmentTagFromSheet event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final newState = state as VisitLoaded;
      final updatedDepartmentTags = List<Map<String, String>>.from(
        newState.departmentTags,
      )..add({'id': event.id, 'name': event.departmentTag});

      emit(newState.copyWith(departmentTags: updatedDepartmentTags));
    }
  }

  void _onRemoveDepartment(
    RemoveDepartmentTag event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final newState = state as VisitLoaded;
      final updatedDepartmentTags = List<Map<String, String>>.from(
        newState.departmentTags,
      )..removeWhere((tag) => tag['name'] == event.departmentTag);

      emit(newState.copyWith(departmentTags: updatedDepartmentTags));
    }
  }

  void _onToggleEmployeeSelection(
    ToggleEmployeeSelection event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      final updatedIndexes = List<int>.from(
        currentState.selectedEmployeeIndexes,
      );

      if (updatedIndexes.contains(event.index)) {
        updatedIndexes.remove(event.index);
      } else {
        updatedIndexes.add(event.index);
      }
      emit(currentState.copyWith(selectedEmployeeIndexes: updatedIndexes));
    }
  }

  /// visit With

  ///MyVisit page
  void _ontabchange(TabChanged event, Emitter<VisitState> emit) {
    final newstate = state;
    if (newstate is VisitLoaded) {
      emit(newstate.copyWith(selectedIndex: event.newIndex));
    }
  }

  void _onDateUpdate(UpdateSelectedDate event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      emit((state as VisitLoaded).copyWith(selectedDate: event.newDate));
    }
  }

  void _onNextDate(NextDate event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final current = (state as VisitLoaded).selectedDate;
      emit(
        (state as VisitLoaded).copyWith(
          selectedDate: current.add(const Duration(days: 1)),
        ),
      );
    }
  }

  void _onPreviousDate(PreviousDate event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final current = (state as VisitLoaded).selectedDate;
      emit(
        (state as VisitLoaded).copyWith(
          selectedDate: current.subtract(const Duration(days: 1)),
        ),
      );
    }
  }

  void _onTapAutoExpence(ToggleAutoExpence event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      emit(
        currentState.copyWith(
          ToggleAutoExpence: !currentState.ToggleAutoExpence,
        ),
      );
    }
  }

  ///Add New Visit Page
  void _onUpdateVisitTypeAndTap(
    UpdateVisitTypeAndTapEvent event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;

      emit(
        currentState.copyWith(
          selectedVisitType: event.selectedVisitType,
          isButtonTapped: event.isTapped,
          actionType: event.actionType,
        ),
      );
    }
  }

  /// Add Customer Form
  void _onContactPersonCodeUpdate(
    UpdateContactPerson event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      emit(currentState.copyWith(contactCode: event.code, contactId: event.id));
    }
  }

  void _onAlternativePhoneUpdate(
    UpdateAlternativePhone event,
    Emitter<VisitState> emit,
  ) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      emit(
        currentState.copyWith(
          alternativeCode: event.code,
          alternativeId: event.id,
        ),
      );
    }
  }

  void _onCitySelection(CitySelectionEvent event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      emit(currentState.copyWith(cityName: event.cityName));
    }
  }

  void _onAreaSelection(AreaSelectionEvent event, Emitter<VisitState> emit) {
    if (state is VisitLoaded) {
      final currentState = state as VisitLoaded;
      emit(currentState.copyWith(areaName: event.areaName));
    }
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    _dateTimeTimer?.cancel();
    _scanningTimer?.cancel();
    return super.close();
  }
}
