import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/payslip/domain/entities/ctc_details_entity.dart';
import 'package:myco_flutter/features/payslip/domain/entities/get_other_earnings_entity.dart';
import 'package:myco_flutter/features/payslip/domain/entities/salary_details_entity.dart';
import 'package:myco_flutter/features/payslip/domain/entities/salary_entity.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/add_salary_issue_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_ctc_details_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_other_earnings_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_details_usecase.dart';
import 'package:myco_flutter/features/payslip/domain/usecases/get_salary_usecase.dart';

part 'payslip_event.dart';
part 'payslip_state.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  final GetSalaryUsecase getSalary;
  final GetCtcDetailsUsecase getCtcDetails;
  final GetSalaryDetailsUsecase getSalaryDetails;
  final AddSalaryIssueUsecase addSalaryIssue;

  PayslipBloc(
    this.getSalary,
    this.getCtcDetails,
    this.getSalaryDetails,
    this.addSalaryIssue,
  ) : super(PayslipMainInitialState()) {
    // Payslip
    on<GetSalaryEvent>(getPayslip);
    // CTC
    on<GetCtcDetailsEvent>(getCtcDetail);
    // Salary Details
    on<GetSalaryDetailsEvent>(getSalaryDetailsEvent);
    // Change Year
    on<ChangeYearEvent>(changeYearEvent);
    // Raise Issue
    on<AddSalaryIssueEvent>(raiseSalaryIssue);
    // Clear Issue Details
    on<ClearIssueDetailsEvent>(clearIssueDetails);

    on<WebviewLoadingEvent>(handleWebviewLoading);
  }

  FutureOr<void> getPayslip(
    GetSalaryEvent event,
    Emitter<PayslipState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final salary = await getSalary.call(event.salaryYear);

    salary.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (result) => emit(state.copyWith(isLoading: false, salaryEntity: result)),
    );
  }

  FutureOr<void> getCtcDetail(
    GetCtcDetailsEvent event,
    Emitter<PayslipState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final result = await getCtcDetails();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (response) =>
          emit(state.copyWith(isLoading: false, ctcDetailsEntity: response)),
    );
  }

  FutureOr<void> getSalaryDetailsEvent(
    GetSalaryDetailsEvent event,
    Emitter<PayslipState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final result = await getSalaryDetails.call(event.salarySlipId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (response) =>
          emit(state.copyWith(isLoading: false, salaryDetailsEntity: response)),
    );
  }

  // This method is used to select a particular year or increment or decrement it by 1 using tagEvent
  FutureOr<void> changeYearEvent(
    ChangeYearEvent event,
    Emitter<PayslipState> emit,
  ) {
    // We take the year from event and either increment it or decrement it based on tag event and set as it is if it is selected from time picker
    if (event.tagEvent == 'increase') {
      emit(state.copyWith(year: (int.parse(event.year) + 1).toString()));
    } else if (event.tagEvent == 'decrease') {
      emit(state.copyWith(year: (int.parse(event.year) - 1).toString()));
    } else {
      emit(state.copyWith(year: event.year));
    }
  }

  FutureOr<void> raiseSalaryIssue(
    AddSalaryIssueEvent event,
    Emitter<PayslipState> emit,
  ) async {
    final result = await addSalaryIssue.call(
      event.issueMessage,
      event.salarySlipId,
    );

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (response) => emit(state.copyWith(issueResponse: response.message)),
    );
  }

  // Clearing issue response and error from the previous state,
  // Needed for listener in payslip_detail page
  FutureOr<void> clearIssueDetails(
    ClearIssueDetailsEvent event,
    Emitter<PayslipState> emit,
  ) {
    emit(state.copyWith(issueResponse: '', error: ''));
  }

  FutureOr<void> handleWebviewLoading(
    WebviewLoadingEvent event,
    Emitter<PayslipState> emit,
  ) {
    emit(
      state.copyWith(
        isWebviewLoading: event.webviewLoading,
        webViewError: event.webViewError,
      ),
    );
  }
}

// Other Earnings Bloc in order to prevent issues with tabbar view
class OtherEarningsBloc extends Bloc<PayslipEvent, PayslipState> {
  final GetOtherEarningsUsecase otherEarningsUsecase;

  OtherEarningsBloc(this.otherEarningsUsecase)
    : super(PayslipMainInitialState()) {
    on<GetOtherEarningsEvent>(getOtherEarningsEvent);
  }

  FutureOr<void> getOtherEarningsEvent(
    GetOtherEarningsEvent event,
    Emitter<PayslipState> emit,
  ) async {
    emit(
      state.copyWith(getOtherEarningsLoading: true, getOtherEarningsError: ''),
    );

    final otherEarnings = await otherEarningsUsecase.call(
      event.leavePayoutYear,
    );

    otherEarnings.fold(
      (failure) => emit(
        state.copyWith(
          getOtherEarningsLoading: false,
          getOtherEarningsError: failure.message,
        ),
      ),
      (result) => emit(
        state.copyWith(
          getOtherEarningsLoading: false,
          otherEarningsEntity: result,
        ),
      ),
    );
  }
}
