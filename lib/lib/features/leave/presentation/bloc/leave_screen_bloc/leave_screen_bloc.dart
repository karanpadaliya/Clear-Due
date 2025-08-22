import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_state.dart';

import 'leave_screen_event.dart';
import 'leave_screen_state.dart';

class LeaveScreenBloc extends Bloc<LeaveScreenEvent, LeaveScreenState> {
  final LeaveBloc leaveBloc;
  late final StreamSubscription leaveBlocSubscription;

  LeaveScreenBloc(this.leaveBloc) : super(LeaveScreenState.initial()) {
    on<LoadLeaves>((event, emit) {
      emit(state.copyWith(isLoading: true));
      leaveBloc.add(
        FetchLeaveHistoryNew(
          state.month.toString().padLeft(2, '0'),
          state.year.toString(),
        ),
      );
    });

    on<ChangeFilter>((event, emit) {
      emit(state.copyWith(filter: event.filter));
    });

    on<ChangeMonthYear>((event, emit) {
      emit(
        state.copyWith(month: event.month, year: event.year, isLoading: true),
      );
      leaveBloc.add(
        FetchLeaveHistoryNew(
          event.month.toString().padLeft(2, '0'),
          event.year.toString(),
        ),
      );
    });

    on<LeavesLoaded>((event, emit) {
      emit(
        state.copyWith(
          isLoading: false,
          leaves: event.leaves,
          isTeamLeave: event.isTeamLeave,
        ),
      );
    });

    // Subscribe to LeaveBloc state changes
    leaveBlocSubscription = leaveBloc.stream.listen((leaveState) {
      if (leaveState is LeaveHistoryNewFetched) {
        add(
          LeavesLoaded(
            leaves: leaveState.newLeaveList.leaveHistory ?? [],
            isTeamLeave: leaveState.newLeaveList.teamLeave ?? false,
          ),
        );
      } else if (leaveState is LeaveError) {
        add(LeavesLoaded(leaves: [], isTeamLeave: false));
      }
    });
  }

  @override
  Future<void> close() {
    leaveBlocSubscription.cancel();
    return super.close();
  }
}
