import 'package:myco_flutter/core/models/data/common_response_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/ctc_details_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/get_other_earnings_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/salary_details_model.dart';
import 'package:myco_flutter/features/payslip/data/models/response/salary_model.dart';

abstract class PayslipRemoteDatasources {
  Future<SalaryModel> getSalary(String salaryYear);
  Future<GetOtherEarningsModel> getOtherEarnings(String leavePayoutYear);
  Future<CtcDetailsModel> getCtcDetails();
  Future<SalaryDetailsModel> getSalaryDetails(String salarySlipId);
  Future<CommonResponseModel> addSalaryIssue(
    String issueMessage,
    String salarySlipId,
  );
}
