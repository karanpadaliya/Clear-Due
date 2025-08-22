part of 'payslip_bloc.dart';

class PayslipState {
  final bool isLoading;
  final bool getOtherEarningsLoading;
  final String getOtherEarningsError;
  final String error;
  // Getting main payslip
  final SalaryEntity salaryEntity;
  // Other Earnings
  final GetOtherEarningsEntity otherEarningsEntity;
  // CTC
  final CtcDetailsEntity ctcDetailsEntity;
  // Saary Details
  final SalaryDetailsEntity salaryDetailsEntity;
  final String year;
  // Salary Issue
  final String issueResponse;

  final bool isWebviewLoading;
  final String webViewError;

  const PayslipState({
    required this.isLoading,
    required this.error,
    required this.salaryEntity,
    required this.otherEarningsEntity,
    required this.ctcDetailsEntity,
    required this.salaryDetailsEntity,
    required this.year,
    required this.issueResponse,
    required this.isWebviewLoading,
    required this.webViewError,
    required this.getOtherEarningsLoading,
    required this.getOtherEarningsError,
  });

  PayslipState copyWith({
    bool? isLoading,
    String? error,
    SalaryEntity? salaryEntity,
    GetOtherEarningsEntity? otherEarningsEntity,
    CtcDetailsEntity? ctcDetailsEntity,
    SalaryDetailsEntity? salaryDetailsEntity,
    String? year,
    String? issueResponse,
    bool? isWebviewLoading,
    String? webViewError,
    bool? getOtherEarningsLoading,
    String? getOtherEarningsError,
  }) => PayslipState(
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    salaryEntity: salaryEntity ?? this.salaryEntity,
    otherEarningsEntity: otherEarningsEntity ?? this.otherEarningsEntity,
    ctcDetailsEntity: ctcDetailsEntity ?? this.ctcDetailsEntity,
    salaryDetailsEntity: salaryDetailsEntity ?? this.salaryDetailsEntity,
    year: year ?? this.year,
    issueResponse: issueResponse ?? this.issueResponse,
    isWebviewLoading: isWebviewLoading ?? this.isWebviewLoading,
    webViewError: webViewError ?? this.webViewError,
    getOtherEarningsLoading:
        getOtherEarningsLoading ?? this.getOtherEarningsLoading,
    getOtherEarningsError: getOtherEarningsError ?? this.getOtherEarningsError,
  );

  List<Object> get props => [
    isLoading,
    error,
    salaryEntity,
    otherEarningsEntity,
    ctcDetailsEntity,
    salaryDetailsEntity,
    year,
    issueResponse,
    isWebviewLoading,
    webViewError,
    getOtherEarningsLoading,
    getOtherEarningsError,
  ];
}

// Initial State
class PayslipMainInitialState extends PayslipState {
  // Setting Initial Data in State
  PayslipMainInitialState()
    : super(
        isLoading: false,
        error: '',
        salaryEntity: SalaryEntity(),
        otherEarningsEntity: GetOtherEarningsEntity(),
        ctcDetailsEntity: CtcDetailsEntity(),
        salaryDetailsEntity: const SalaryDetailsEntity(),
        year: DateTime.now().year.toString(),
        issueResponse: '',
        isWebviewLoading: false,
        webViewError: '',
        getOtherEarningsLoading: false,
        getOtherEarningsError: '',
      );
}
