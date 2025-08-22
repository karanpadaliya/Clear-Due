part of 'payslip_bloc.dart';

//======== Main Event Class =========
sealed class PayslipEvent extends Equatable {
  const PayslipEvent();

  @override
  List<Object> get props => [];
}

// ======== Payslip =========
class GetSalaryEvent extends PayslipEvent {
  final String salaryYear;

  const GetSalaryEvent({required this.salaryYear});

  @override
  List<Object> get props => [salaryYear];
}

// ======== Other Earning =========
class GetOtherEarningsEvent extends PayslipEvent {
  final String leavePayoutYear;

  const GetOtherEarningsEvent({required this.leavePayoutYear});

  @override
  List<Object> get props => [leavePayoutYear];
}

// ======== Change Year =========
class ChangeYearEvent extends PayslipEvent {
  final String year;
  final String tagEvent;

  const ChangeYearEvent({required this.tagEvent, required this.year});

  @override
  List<Object> get props => [year, tagEvent];
}

// ======== CTC Details =========
class GetCtcDetailsEvent extends PayslipEvent {}

// ======== Payslip Details =========
class GetSalaryDetailsEvent extends PayslipEvent {
  final String salarySlipId;

  const GetSalaryDetailsEvent({required this.salarySlipId});

  @override
  List<Object> get props => [salarySlipId];
}

// ======== Add Salary Issue =========
class AddSalaryIssueEvent extends PayslipEvent {
  final String issueMessage;
  final String salarySlipId;

  const AddSalaryIssueEvent({
    required this.issueMessage,
    required this.salarySlipId,
  });

  @override
  List<Object> get props => [issueMessage, salarySlipId];
}

// ======== Clear Issue Response ========
class ClearIssueDetailsEvent extends PayslipEvent {}

// ======== Webview Loading =========
class WebviewLoadingEvent extends PayslipEvent {
  final bool? webviewLoading;
  final String? webViewError;

  const WebviewLoadingEvent({
    this.webviewLoading = false,
    this.webViewError = '',
  });

  @override
  List<Object> get props => [webviewLoading ?? false, webViewError ?? ''];
}
