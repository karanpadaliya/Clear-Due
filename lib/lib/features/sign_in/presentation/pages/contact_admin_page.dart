import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/search_company/presentation/widgets/box_design_registration.dart';
import 'package:myco_flutter/features/sign_in/presentation/bloc/primary_register_bloc.dart';
import 'package:myco_flutter/features/sign_in/presentation/pages/contact_admin_shimmer.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class ContactAdminPage extends StatefulWidget {
  const ContactAdminPage({super.key});

  @override
  State<ContactAdminPage> createState() => _ContactAdminPageState();
}

class _ContactAdminPageState extends State<ContactAdminPage> {
  final preferenceManager = GetIt.I<PreferenceManager>();

  bool _isLoading = true;
  String blockId = '';
  String messageStatus = '';
  String userFullName = '';
  String userFirstName = '';
  String userLastName = '';
  String userBlockName = '';
  String userFloorName = '';
  String designation = '';
  String department = '';
  String mobileNumber = '';
  String emailAddress = '';
  String profilePicture = '';
  String? countryName = '';

  @override
  void initState() {
    super.initState();
    _fetchViewPendingProfile();
  }

  void _fetchViewPendingProfile() {
    context.read<PrimaryRegisterBloc>().add(LoadPendingProfile());
  }

  void _fetchSociety() {
    context.read<PrimaryRegisterBloc>().add(LoadSociety());
  }

  void _fetchCancelProfile() {
    context.read<PrimaryRegisterBloc>().add(LoadCancelProfile());
  }

  void _fetchReminderProfile() {
    context.read<PrimaryRegisterBloc>().add(LoadReminderProfile(
        blockId,
        userFirstName,
        userLastName,
        userFullName,
        userFloorName,
        userBlockName));
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final colorScheme = AppTheme.getColor(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(

        title: Padding(
          // Add padding only to the left side
          padding: EdgeInsets.only(left: 10 * Responsive.getResponsive(context)),
          child: Text(
            'Pending Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: BlocConsumer<PrimaryRegisterBloc, PrimaryRegisterState>(
        listener: (context, state) async {
          // --- REFACTORED LISTENER ---

          // Set loading state
          if (state is PrimaryRegisterLoading) {
            setState(() => _isLoading = true);
          } else {
            if (_isLoading) setState(() => _isLoading = false);
          }


          if (state is PendingAccountSuccess ||
              state is ReminderPendingProfileSuccess ||
              state is CancelPendingProfileSuccess ||
              state is SocietySuccess ||
              state is PrimaryRegisterError) {
            setState(() {
              _isLoading = false;
            });

            // Handle Success State
            if (state is PendingAccountSuccess) {
              final response = state.response;
              if (response == null) {
                Fluttertoast.showToast(msg: 'Failed to get a valid response.');
                // ... navigation logic ...
                return;
              }

              // Update UI with new data inside setState
              setState(() async {
                countryName = await preferenceManager.getCompanyName();
                userFullName = response.userFullName ?? 'N/A';
                designation = response.designation ?? 'N/A';
                department = '${response.blockName ?? ' - '} ${response.floorName ?? ''}';
                mobileNumber = '${response.countryCode ?? ''} ${response.userMobile ?? ''}';
                emailAddress = response.userEmail ?? 'N/A';
                profilePicture = response.userProfilePic ?? '';
                userFirstName = response.userFirstName ?? '';
                userLastName = response.userLastName ?? '';
                userBlockName = response.blockName ?? '';
                userFloorName = response.floorName ?? '';
                blockId = response.blockId ?? '';
                messageStatus = response.message ?? '';
              });

              if (response.viewDialog == true) {
                _isLoading = true;
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
                    child: CustomAlertDialog(
                        alertType: AlertType.defaultType,
                        content: response.message ?? 'You have a notification.',
                        confirmText: LanguageManager().get('ok').toUpperCase(),
                        onConfirm: () async {
                          await preferenceManager.setKeyValueString(VariableBag.registrationRequestPendingUserId, "");
                          await preferenceManager.setKeyValueBoolean(VariableBag.REGISTRATION_REQUEST_IS_APPROVE, true);
                          if (mounted) context.go(RoutePaths.splash);
                        }),
                  ),
                );
              }

              if (response.userStatus == '1') {
                await preferenceManager.setKeyValueString(VariableBag.registrationRequestPendingUserId, '');
                await preferenceManager.setKeyValueBoolean(VariableBag.REGISTRATION_REQUEST_IS_APPROVE, true);
                Fluttertoast.showToast(msg: response.message ?? 'Request Approved!');
                _fetchSociety();
              }
            }

            // Handle other side-effects
            if (state is ReminderPendingProfileSuccess) {
              Fluttertoast.showToast(msg: state.response.message ?? 'N/A');
            }

            if (state is CancelPendingProfileSuccess) {
              Fluttertoast.showToast(msg: state.response.message ?? 'N/A');
              preferenceManager.setKeyValueString(VariableBag.registrationRequestPendingUserId, '');
              preferenceManager.setKeyValueBoolean(VariableBag.REGISTRATION_REQUEST_IS_APPROVE, true);
              context.go(RoutePaths.splash);
            }

            if (state is SocietySuccess) {
              if (state.response != null) {

                // for (var response in state.response.society!) {
                //   if (response.companyId == preferenceManager.getCompanyId()) {
                //     Navigator.pushReplacement(
                //       context, MaterialPageRoute(
                //         builder: (_) => LoginUi(
                //
                //           companyId: response.companyId,
                //           countryId: response.countryId,
                //           stateId: response.stateId,
                //           cityId: response.cityId,
                //           companyName: response.companyName,
                //           isSociety: response.isSociety,
                //           isFirebase: response.isFirebase,
                //           companyAddress: response.companyAddress,
                //           loginVia: response.loginVia,
                //           googleLogin: response.googleLogin,
                //           isFrom: 'pendingAccount',
                //
                //         ),
                //       ),
                //     );
                //     break;
                //   }
                // }
              }
            }
          }

          if (state is PrimaryRegisterError) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (_isLoading) {
            return const ContactAdminShimmer();
          }

          if (state is PrimaryRegisterError) {
            return Center(child: Text('An error occurred: ${state.message}'));
          }

          return _buildBody(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colorScheme = AppTheme.getColor(context);
    final textTheme = AppTheme.getTextStyle(context);

    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        children: [
          LinearDesignBox(
            title: userFullName,
            isIncenter: true,
            titleTextStyle: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
            color: const Color(0xFF2FBBA4),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.02 * Responsive.getWidth(context)),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50 * Responsive.getResponsive(context),
                    backgroundImage: (profilePicture.isNotEmpty && profilePicture.startsWith('http'))
                        ? NetworkImage(profilePicture)
                        : const AssetImage('assets/default_profile.png') as ImageProvider,
                  ),
                  SizedBox(height: 0.01 * Responsive.getHeight(context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${LanguageManager().get('designation')}:',
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        designation,
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.002 * Responsive.getHeight(context)),
                  Text(department, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
                  SizedBox(height: 0.002 * Responsive.getHeight(context)),
                  Text(mobileNumber, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
                  SizedBox(height: 0.002 * Responsive.getHeight(context)),
                  Text(emailAddress, style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface)),
                  SizedBox(height: 0.007 * Responsive.getHeight(context)),
                  Text(
                    messageStatus,
                    style: textTheme.bodyLarge?.copyWith(color: colorScheme.error,fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyCoButton(
                        onTap: _fetchCancelProfile,
                        title: LanguageManager().get('cancel').toUpperCase(),
                        height: 0.05 * Responsive.getHeight(context),
                        width: 0.37 * Responsive.getWidth(context),
                        boarderRadius: 30 * Responsive.getResponsive(context),
                        textStyle: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
                        backgroundColor: colorScheme.surfaceBright,
                      ),
                      MyCoButton(
                        onTap: _fetchReminderProfile,
                        title: LanguageManager().get('reminder').toUpperCase(),
                        height: 0.05 * Responsive.getHeight(context),
                        width: 0.37 * Responsive.getWidth(context),
                        boarderRadius: 30 * Responsive.getResponsive(context),
                        textStyle: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
                        backgroundColor: const Color(0xFF2F648E),
                        isShadowBottomLeft: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          SizedBox(height: 0.04 * Responsive.getHeight(context)),
          Image.asset(
            'assets/search_society/contact_admin.png',
            height: 0.35 * Responsive.getHeight(context),
          ),
        ],
      ),
    );
  }
}