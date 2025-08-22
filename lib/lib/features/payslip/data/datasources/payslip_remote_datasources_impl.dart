import 'dart:convert';
import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/payslip/data/datasources/payslip_remote_datasources.dart';
import 'package:myco_flutter/features/payslip/data/models/request/add_salary_issue_request_model.dart';
import 'package:myco_flutter/features/payslip/data/models/request/ctc_details_request_model.dart';
import 'package:myco_flutter/features/payslip/data/models/request/get_other_earnings_request_model.dart';
import 'package:myco_flutter/features/payslip/data/models/request/salary_details_request_model.dart';
import 'package:myco_flutter/features/payslip/data/models/request/salary_request_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/ctc_details_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/get_other_earnings_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/salary_details_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/salary_model.dart';

class PayslipRemoteDataSourceImpl implements PayslipRemoteDatasources {
  final ApiClient apiClient;

  PayslipRemoteDataSourceImpl({required this.apiClient});

  final String controller = 'salary_controller.php';
  // Payslip Screen's Payslip tab + View Summary bottomsheet
  @override
  Future<SalaryModel> getSalary(String salaryYear) async {
    final body = SalaryRequestModel(
      getSalaries: 'getSalaries',
      branchId: await PreferenceManager().getBranchId(),
      languageId: await PreferenceManager().getLanguageId(),
      userId: await PreferenceManager().getUserId(),
      companyId: await PreferenceManager().getCompanyId(),
      departmentId: await PreferenceManager().getDepartmentId(),
      salaryYear: salaryYear,
    ).toJson();

    // log(body.toString(), name: 'BODY_getSalary');
    final response = await apiClient.postFormDynamic(controller, body);

    return SalaryModel.fromJson(json.decode(response));
  }

  // Payslip Screen's Get other earnings tab
  @override
  Future<GetOtherEarningsModel> getOtherEarnings(String leavePayoutYear) async {
    final body = GetOtherEarningsRequestModel(
      getOtherEarning: 'getOtherEarning',
      companyId: await PreferenceManager().getCompanyId(),
      userId: await PreferenceManager().getUserId(),
      languageId: await PreferenceManager().getLanguageId(),
      leavePayoutYear: leavePayoutYear,
    ).toJson();

    // log(body.toString(), name: 'BODY_getOtherEarnings');
    final response = await apiClient.postFormDynamic(controller, body);

    return GetOtherEarningsModel.fromJson(json.decode(response));
  }

  // View CTC screen (Salary Break Up)
  @override
  Future<CtcDetailsModel> getCtcDetails() async {
    final body = CtcDetailsRequestModel(
      getCTCDetails: 'getCTCDetails',
      companyId: await PreferenceManager().getCompanyId(),
      languageId: await PreferenceManager().getLanguageId(),
      userId: await PreferenceManager().getUserId(),
    ).toJson();

    // log(body.toString(), name: 'BODY_getCtcDetails');

    final response = await apiClient.postFormDynamic(controller, body);

    return CtcDetailsModel.fromJson(json.decode(response));
  }

  // Salary Details Screen
  @override
  Future<SalaryDetailsModel> getSalaryDetails(String salarySlipId) async {
    final body = SalaryDetailsRequestModel(
      getSalaryDetails: 'getSalaryDetails',
      companyId: await PreferenceManager().getCompanyId(),
      languageId: await PreferenceManager().getLanguageId(),
      userId: await PreferenceManager().getUserId(),
      salarySlipId: salarySlipId,
    ).toJson();

    // log(body.toString(), name: 'BODY_getSalaryDetails');

    final response = await apiClient.postFormDynamic(controller, body);

    return SalaryDetailsModel.fromJson(json.decode(response));
  }

  // Salary Details Screen Add Issue Bottomsheet
  @override
  Future<CommonResponseModel> addSalaryIssue(
    String issueMessage,
    String salarySlipId,
  ) async {
    final body = AddSalaryIssueRequestModel(
      addSalaryIssue: 'addSalaryIssue',
      companyId: await PreferenceManager().getCompanyId(),
      languageId: await PreferenceManager().getLanguageId(),
      userId: await PreferenceManager().getUserId(),
      salarySlipId: salarySlipId,
      salaryIssue: issueMessage,
      userName: await PreferenceManager().getUserFullName(),
    ).toJson();

    // log(body.toString(), name: 'BODY_addSalaryIssue');

    final response = await apiClient.postFormDynamic(controller, body);

    return CommonResponseModel.fromJson(json.decode(response));
  }
}
