import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/device_change/device_change_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/login/login_state.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/select_company_step/select_company_step_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/widgets/get_reason_ui.dart';
import 'package:myco_flutter/features/company_selector/presentation/widgets/login_ui.dart';
import 'package:myco_flutter/features/company_selector/presentation/widgets/otp_verification_ui.dart';
import 'package:myco_flutter/features/company_selector/presentation/widgets/select_company_ui.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_inner_outer_shadow.dart';

// class SelectCompanyPage extends StatelessWidget {
//   const SelectCompanyPage({super.key});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: SafeArea(
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => SelectCompanyStepBloc()),
//           BlocProvider(create: (context) => GetIt.I<CompanyBloc>()),
//           BlocProvider(create: (context) => GetIt.I<LoginBloc>()),
//         ],
//         child: const CompanySearchBody(),
//       ),
//     ),
//   );
// }

class SelectCompanyPage extends StatefulWidget {
  const SelectCompanyPage({super.key});

  @override
  State<SelectCompanyPage> createState() => _CompanySearchBodyState();
}

class _CompanySearchBodyState extends State<SelectCompanyPage> {
  // Local UI state is now managed here in the stateful widget.
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final Map<String, String> countryMap = {
    'IND': '+91',
    'USA': '+1',
    'INA': '+62',
  };
  String selectedCountry = 'IND';
  bool isChecked = true;

  @override
  void dispose() {
    // Ensure controllers are disposed to prevent memory leaks.
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // This listener reacts to state changes in the LoginBloc to trigger
      // navigation events in the SelectCompanyStepBloc.
      BlocListener<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState is OtpSentState) {
            final stepBloc = context.read<SelectCompanyStepBloc>();
            final stepState = stepBloc.state;

            if (stepState is SelectCompanyStepLogin) {
              final isEmail = stepState.selectedCompany.loginVia == '1';
              // The contact value is now accessed from the local state controllers.
              final contactValue = isEmail
                  ? emailController.text
                  : phoneController.text;
              final countryCode = countryMap[selectedCountry] ?? '';

              // Dispatch event to move to the OTP step.
              stepBloc.add(
                GoToOtpStep(
                  otpResponse: loginState.response,
                  selectedCompany: stepState.selectedCompany,
                  contactValue: contactValue,
                  countryCode: countryCode,
                ),
              );
            }
          } else if (loginState is OtpNotSentState) {
            if (loginState.response.viewDialogApiCall == true) {
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
                    content: loginState.response.message,
                    cancelText: LanguageManager().get('cancel'),
                    confirmText: LanguageManager().get('request'),
                    onConfirm: () {
                      Navigator.of(context).pop();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => BlocProvider(
                          create: (context) => GetIt.I<DeviceChangeBloc>(),
                          child: GetReasonUi(
                            title:
                                '${LanguageManager().get('change_request')} *',
                          ),
                        ),
                      );
                    },
                    onCancel: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            } else if (loginState.response.viewDialog == true) {
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
                    content: loginState.response.message,
                    confirmText: LanguageManager().get('ok'),
                    onConfirm: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              );
            } else {
              Fluttertoast.showToast(msg: loginState.response.message ?? '');
            }
          }
        }, // This builder reacts to the page flow state to show the correct UI.
        child: BlocBuilder<SelectCompanyStepBloc, SelectCompanyStepState>(
          builder: (context, stepState) {
            if (stepState is SelectCompanyStepLogin) {
              final PreferenceManager preference = GetIt.I<PreferenceManager>();
              preference.setCompanyId(
                stepState.selectedCompany.companyId ?? '',
              );
              preference.setCompanyName(
                stepState.selectedCompany.companyName ?? '',
              );
              preference.setCompanyAddress(
                stepState.selectedCompany.companyAddress ?? '',
              );
              preference.setCountryId(
                stepState.selectedCompany.countryId ?? '',
              );
              preference.setStateId(stepState.selectedCompany.stateId ?? '');
              preference.setCityId(stepState.selectedCompany.cityId ?? '');

              // Pass the local state and callbacks down to the LoginUi widget.
              return LoginUi(
                selectedCompany: stepState.selectedCompany,
                phoneController: phoneController,
                emailController: emailController,
                countryMap: countryMap,
                selectedCountry: selectedCountry,
                isChecked: isChecked,
                onCountryChanged: (value, index) {
                  if (value != null) {
                    setState(() {
                      selectedCountry = value;
                    });
                  }
                },
                onCheckChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                // The previousStep and nextStep callbacks are now handled by BLoC events
                // within the LoginUi widget itself.
                previousStep: () => context.read<SelectCompanyStepBloc>().add(
                  GoToPreviousStep(),
                ),
                nextStep: () {
                  /* This is handled by the LoginBloc listener */
                },
              );
            }
            if (stepState is SelectCompanyStepOtp) {
              final isEmail = stepState.selectedCompany.loginVia == '1';
              final imagePath = isEmail
                  ? 'assets/sign_in/email.png'
                  : 'assets/sign_in/phone.png';

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 70 * Responsive.getResponsive(context),
                    ),
                    child: OtpVerificationUi(
                      contactValue: stepState.contactValue,
                      countryCode: stepState.countryCode,
                      isEmail: stepState.selectedCompany.loginVia == '1',
                      otpResponse: stepState.otpResponse,
                      selectedCompany: stepState.selectedCompany,
                    ),
                  ),

                  Positioned(
                    top: -45,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10 * Responsive.getResponsive(context),
                        ),
                        child: CustomInnerOuterShadow(
                          innerShadows: [
                            BoxShadow(
                              offset: const Offset(0, 1),
                              blurRadius: 1.4,
                              spreadRadius: 1,
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                            const BoxShadow(
                              offset: Offset(4, -3),
                              blurRadius: 4,
                              color: Colors.black26,
                            ),
                          ],
                          child: Container(
                            height: 100 * Responsive.getResponsive(context),
                            width: 100 * Responsive.getResponsive(context),
                            decoration: BoxDecoration(
                              color: AppTheme.getColor(context).primary,
                            ),
                            child: Image.asset(
                              imagePath,
                              height: 0.035 * Responsive.getHeight(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            // The default and initial state is to show the company selection UI.
            return const SelectCompanyUi();
          },
        ),
      );
}

// A simple helper class to hold state for LoginUi, managed with Provider.
// This is a pragmatic choice to avoid passing many controllers.
class LoginUiState extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final Map<String, String> countryMap = {
    'IND': '+91',
    'USA': '+1',
    'INA': '+62',
  };
  String _selectedCountry = 'IND';
  bool _isChecked = false;

  String get selectedCountry => _selectedCountry;
  bool get isChecked => _isChecked;

  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }

  void setChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
// class _CompanySearchBody extends StatefulWidget {
//   const _CompanySearchBody();

//   @override
//   State<_CompanySearchBody> createState() => _CompanySearchBodyState();
// }

// class _CompanySearchBodyState extends State<_CompanySearchBody> {
//   PreferenceManager preference = GetIt.I<PreferenceManager>();
//   String selectedCountry = 'IND';
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   bool isChecked = false;

//   final Map<String, String> countryMap = {
//     'IND': '+91',
//     'USA': '+1',
//     'INA': '+62',
//   };

//   int _currentStep = 0;

//   final TextEditingController _controller = TextEditingController();

//   Timer? _debounce;

//   // void _onSearchChanged(String value) {
//   //   if (_debounce?.isActive ?? false) _debounce!.cancel();

//   //   _debounce = Timer(const Duration(milliseconds: 300), () {
//   //     if (value.length >= 3) {
//   //       context.read<CompanyBloc>().add(SearchCompany(value));
//   //     } else {
//   //       context.read<CompanyBloc>().add(InitialView());
//   //     }
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     // _controller.addListener(() {
//     //   _onSearchChanged(_controller.text);
//     // });
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   void _nextStep() {
//     if (_currentStep == 0) {
//       phoneController.clear();
//       emailController.clear();
//     }

//     if (_currentStep < 2) {
//       setState(() => _currentStep++);
//     }
//   }

//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() => _currentStep--);
//     }
//   }

//   @override
//   Widget build(BuildContext buildContext) {
//     switch (_currentStep) {
//       case 0:
//         return SelectCompanyUi(controller: _controller, nextStep: _nextStep);
//       case 1:
//         return FutureBuilder<String?>(
//           future: preference.readString('selectedCompany'),
//           builder: (context, instance) {
//             if (instance.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (instance.hasError || instance.data == null) {
//               return const Center(
//                 child: Text('Failed to load selected company.'),
//               );
//             } else {
//               final companyJson = instance.data!;
//               final selectedCompany = SocietyEntity.fromJson(
//                 jsonDecode(companyJson),
//               );

//               return BlocProvider(
//                 create: (BuildContext context) => GetIt.I<LoginBloc>(),
//                 child: BlocListener<LoginBloc, LoginState>(
//                   listener: (context, state) async {
//                     if (state is OtpSentState) {
//                       final prefs = GetIt.I<PreferenceManager>();
//                       await prefs.writeString(
//                         'otpResponse',
//                         jsonEncode(state.response.toJson()),
//                       );
//                       _nextStep();
//                     } else if (state is OtpNotSentState) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(state.response.message ?? '')),
//                       );
//                       if (state.response.viewDialogApiCall == true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Device Change Dialog')),
//                         );
//                         // Device Change Dialog
//                       } else if (state.response.viewDialog == true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Custom Alert Dialog')),
//                         );
//                         // Custom Alert Dialog
//                       }
//                     }
//                   },
//                   child: LoginUi(
//                     previousStep: _previousStep,
//                     nextStep: _nextStep,
//                     // You can remove this if not used inside LoginUi
//                     selectedCountry: selectedCountry,
//                     countryMap: countryMap,
//                     onCountryChanged: (value, index) {
//                       setState(() {
//                         selectedCountry = value!;
//                       });
//                     },
//                     phoneController: phoneController,
//                     emailController: emailController,
//                     isChecked: isChecked,
//                     onCheckChanged: (val) {
//                       setState(() {
//                         isChecked = val;
//                       });
//                     },
//                     selectedCompany: selectedCompany,
//                   ),
//                 ),
//               );
//             }
//           },
//         );
//       case 2:
//         return FutureBuilder<List<String?>>(
//           future: Future.wait([
//             preference.readString('otpResponse'),
//             preference.readString('selectedCompany'),
//           ]),
//           builder: (context, instance) {
//             if (instance.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (instance.hasError ||
//                 instance.data == null ||
//                 instance.data!.any((e) => e == null)) {
//               return const Center(child: Text('Failed to load required data.'));
//             } else {
//               final otpResponseJson = instance.data![0]!;
//               final selectedCompanyJson = instance.data![1]!;

//               final otpResponse = CommonResponseModel.fromJson(
//                 jsonDecode(otpResponseJson),
//               );
//               final selectedCompany = SocietyEntity.fromJson(
//                 jsonDecode(selectedCompanyJson),
//               );

//               final bool isEmail = selectedCompany.loginVia == '1';
//               final String contactValue = isEmail
//                   ? emailController.text
//                   : phoneController.text;

//               return BlocProvider(
//                 create: (context) => GetIt.I<LoginBloc>(),
//                 child: OtpVerificationUi(
//                   contactValue: contactValue,
//                   countryCode: countryMap[selectedCountry] ?? '',
//                   isEmail: isEmail,
//                   otpResponse: otpResponse,
//                   selectedCompany: selectedCompany,
//                   onSubmit: (otp) {},
//                   previousStep: _previousStep,
//                   onResend: () {
//                     // Handle resend OTP logic if needed
//                   },
//                   onEmailOtp: () {
//                     // Handle email OTP logic if needed
//                   },
//                   onCallOtp: () {
//                     // Handle call OTP logic if needed
//                   },
//                 ),
//               );
//             }
//           },
//         );
//       default:
//         return const Text('Unknown step');
//     }
//   }
// }
