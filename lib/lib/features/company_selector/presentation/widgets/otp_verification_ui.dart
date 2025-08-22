import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/models/domain/common_response_entity.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/firebase_messaging_service.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/di/modules/network_module.dart';
import 'package:myco_flutter/features/company_selector/data/models/request/verify_otp_request_model.dart';
import 'package:myco_flutter/features/company_selector/domain/entites/company_response_entity.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/device_change/device_change_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_event.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_state.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/select_company_step/select_company_step_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/widgets/get_reason_ui.dart';
import 'package:myco_flutter/features/sign_in/presentation/widgets/customotp_bottomsheet.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class OtpVerificationUi extends StatefulWidget {
  final String contactValue;
  final String countryCode;
  final bool isEmail;
  final CommonResponseModelEntity? otpResponse;
  final SocietyEntity? selectedCompany;

  const OtpVerificationUi({
    required this.otpResponse,
    required this.selectedCompany,
    required this.contactValue,
    required this.countryCode,
    super.key,
    this.isEmail = true,
  });

  @override
  State<OtpVerificationUi> createState() => _OtpVerificationUiState();
}

class _OtpVerificationUiState extends State<OtpVerificationUi> {
  String currentOtp = '';

  String? token;

  @override
  void initState() {
    super.initState();
    _initializeToken();
  }

  void _initializeToken() async {
    try {
      token = await GetIt.I<FirebaseMessagingService>().getSavedFcmToken();
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final String title = widget.isEmail
        ? 'Sign In Email'
        : 'Sign In Phone Number';
    final String message = widget.isEmail
        ? 'Sign in code has been sent to ${widget.contactValue}, check your inbox to continue.'
        : 'Sign in code has been sent to ${widget.countryCode} ${widget.contactValue}, check your messages to continue.';

    final bool isEmailOtp = widget.otpResponse?.isEmailOtp ?? false;
    final bool isVoiceOtp = widget.otpResponse?.isVoiceOtp ?? false;


    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is OtpVerifiedState) {
            final PreferenceManager preference = GetIt.I<PreferenceManager>();
            preference.setLoginSession(true);

            // preferenceManager.setObject(loginResponse.societyId, loginResponse) TODO SETOBJECT LOGINRESPONSE

            preference.setUserId(state.response.userId ?? '');
            preference.setShiftTimeId(state.response.shiftTimeId ?? '');
            preference.setUserMobileNo(state.response.userMobile ?? '');
            preference.setCountryId(state.response.countryId ?? '');
            preference.setStateId(state.response.stateId ?? '');
            preference.setCityId(state.response.cityId ?? '');
            preference.setCompanyId(state.response.companyId ?? '');
            preference.setCompanyAddress(state.response.societyAddress ?? '');
            preference.setCompanyName(state.response.societyName ?? '');
            preference.setBaseUrl(state.response.baseUrl ?? '');
            preference.setUnitId(state.response.unitId ?? '');
            preference.setUnitName(state.response.unitName ?? '');
            preference.setBranchId(state.response.branchId ?? '');
            preference.setBranchName(state.response.branchName ?? '');
            preference.setZoneId(state.response.zoneId ?? '');
            preference.setLevelId(state.response.levelId ?? '');
            preference.setDepartmentId(state.response.departmentId ?? '');
            preference.setDepartmentName(state.response.departmentName ?? '');
            preference.setDesignation(state.response.designation ?? '');
            preference.setLabelMemberType(state.response.labelMemberType ?? '');
            preference.setLabelSettingApartment(
              state.response.labelSettingApartment ?? '',
            );
            preference.setLabelSettingResident(
              state.response.labelSettingResident ?? '',
            );
            preference.setMemberStatus(state.response.memberStatus ?? '');
            preference.setGender(state.response.gender ?? '');
            preference.setUserType(state.response.userType ?? '');
            preference.setMemberDateOfBirth(
              state.response.memberDateOfBirth ?? '',
            );
            preference.setWeddingAnniversaryDate(
              state.response.weddingAnniversaryDate ?? '',
            );
            preference.setUserProfilePic(state.response.userProfilePic ?? '');
            preference.setUserFirstName(state.response.userFirstName ?? '');
            preference.setUserLastName(state.response.userLastName ?? '');
            preference.setUserFullName(state.response.userFullName ?? '');
            preference.setUserEmail(state.response.userEmail ?? '');
            preference.setBloodGroup(state.response.bloodGroup ?? '');
            preference.setAltMobile(state.response.altMobile ?? '');
            preference.setCountryCode(state.response.countryCode ?? '');
            preference.setCountryCodeAlt(state.response.countryCodeAlt ?? '');
            preference.setPublicMobile(state.response.publicMobile ?? '');
            preference.setPlotLatitude(state.response.plotLattitude ?? '');
            preference.setPlotLongitude(state.response.plotLongitude ?? '');
            preference.setIsExpenseON(state.response.isExpenseON ?? false);
            preference.setMaxExpenseAmount(
              state.response.maxExpenseAmount ?? '',
            );
            preference.setStateIdEmployee(state.response.stateIdEmployee ?? '');
            preference.setUnitStatus(state.response.unitStatus ?? '');

            // preferenceManager.setObject("familyMembar", loginResponse.member) TODO SETOBJECT MEMBER
            // preferenceManager.setObject("emergencyNum", loginResponse.emergency) TODO SETOBJECT EMERGENCY

            preference.setFacebook(state.response.facebook ?? '');
            preference.setInstagram(state.response.instagram ?? '');
            preference.setLinkedin(state.response.linkedin ?? '');

            refreshApiServiceCompany(GetIt.instance);

            context.go(RoutePaths.home);
          } else if (state is OtpVerificationFailedState) {
            if (state.response.viewDialogApiCall == true) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CustomAlertDialog(
                    alertType: AlertType.custom,
                    icon: 'assets/login/device_change_icon.svg',
                    content: state.response.message,
                    cancelText: 'Cancel',
                    confirmText: 'Request',
                    onConfirm: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BlocProvider(
                          create: (context) => GetIt.I<DeviceChangeBloc>(),
                          child: const GetReasonUi(title: 'Change Request *'),
                        ),
                      );
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            } else if (state.response.viewDialog == true) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CustomAlertDialog(
                    alertType: AlertType.defaultType,
                    content: state.response.message,
                    confirmText: 'Ok',
                    onConfirm: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            } else {
              Fluttertoast.showToast(msg: state.response.message ?? '');
            }
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24 * Responsive.getResponsive(context),
          ),
          width: Responsive.getWidth(context),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40 * Responsive.getResponsive(context)),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomText(
                  title,
                  fontSize: 18 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                CustomText(
                  message,
                  fontSize: 14 * Responsive.getResponsiveText(context),
                  color: AppTheme.getColor(context).onSurface,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 0.025 * Responsive.getHeight(context)),
                OTPInputField(
                  length: 6,
                  onCompleted: (otp) {
                    currentOtp = otp;
                    // TODO: Optionally auto-submit when completed
                  },
                  onChanged: (code) {
                    currentOtp = code;
                  },
                  inputFormaters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 0.03 * Responsive.getHeight(context)),
                Row(
                  children: [
                    CustomText(
                      "Haven't received the code? ",
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w500,
                      color: AppTheme.getColor(context).onSurface,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomText(
                        'Resend it.',
                        fontSize: 15 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getColor(context).primary,
                      ),
                    ),
                  ],
                ),
                if (isEmailOtp || isVoiceOtp) ...[
                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Email for OTP',
                            style: TextStyle(
                              color: AppTheme.getColor(context).primary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                            ),
                          ),
                        ),
                        SizedBox(width: 0.01 * Responsive.getHeight(context)),
                        const Text('or'),
                        SizedBox(width: 0.01 * Responsive.getHeight(context)),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Call for OTP',
                            style: TextStyle(
                              color: AppTheme.getColor(context).primary,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(height: 0.03 * Responsive.getHeight(context)),
                MyCoButton(
                  onTap: () {
                    if (currentOtp.length == 6) {
                      final model = VerifyOtpRequestModel(
                        societyId: widget.selectedCompany?.companyId ?? '',
                        userMobile: widget.contactValue,
                        countryCode: widget.countryCode,
                        userToken: token??'',
                        device: Platform.operatingSystem,
                        otp: currentOtp,
                        isFirebase: widget.otpResponse?.isFirebase ?? false,
                        userMacAddress: '',
                        macAddressDevice: '',
                        macAddressPhoneModal: '',
                        androidSdkVersion: '',
                        androidVersion: '',
                        androidOsName: '',
                        loginVia: widget.selectedCompany?.loginVia ?? '0',
                        languageId: '1',
                      );
                      context.read<LoginBloc>().add(
                        VerifyOtpEvent(model: model),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid 6-digit OTP.'),
                        ),
                      );
                    }
                  },
                  title: 'Submit',
                  boarderRadius: 50 * Responsive.getResponsive(context),
                  isShadowBottomLeft: true,
                ),
                SizedBox(height: 0.025 * Responsive.getHeight(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      'Sign in with different method ',
                      fontSize: 16 * Responsive.getResponsiveText(context),
                    ),
                    InkWell(
                      onTap: () => context.read<SelectCompanyStepBloc>().add(
                        GoToPreviousStep(),
                      ),
                      child: CustomText(
                        'Here.',
                        fontSize: 16 * Responsive.getResponsiveText(context),
                        color: AppTheme.getColor(context).primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
