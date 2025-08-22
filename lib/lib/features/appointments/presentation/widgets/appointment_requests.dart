import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/appointments/data/models/request/approve_appointment_entity_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_my_appointments_request_model.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:myco_flutter/features/appointments/presentation/bottom_sheet/reject_request_bottom_sheet.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/appointment_person_details.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/appointment_shimmer.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/no_data_preview.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/reason_value_common_row.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AppointmentRequests extends StatefulWidget {
  const AppointmentRequests({super.key});

  @override
  State<AppointmentRequests> createState() => _AppointmentRequestsState();
}

class _AppointmentRequestsState extends State<AppointmentRequests> {
  late PreferenceManager preferenceManager;

  @override
  void initState() {
    super.initState();
    preferenceManager = GetIt.I<PreferenceManager>();
  }

  Future<void> refreshAppointments() async {
    final userId = await preferenceManager.getUserId();
    final companyId = await preferenceManager.getCompanyId();
    final languageId = await preferenceManager.getLanguageId();
    context.read<AppointmentBloc>().add(
      GetAppointmentEvent(
        GetAppointmentRequestModel(
          getAppointments: 'getAppointments',
          userId: userId,
          companyId: companyId,
          languageId: languageId,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<AppointmentBloc, AppointmentState>(
    buildWhen: (previous, current) =>
        current is AppointmentLoading ||
        current is AppointmentLoaded ||
        current is AppointmentError,

    listener: (context, state) async {
      if (state is CommonResponseAppointment && state is! AppointmentLoaded) {
        Fluttertoast.showToast(
          msg: state.commonResponse.message ?? 'Action successful!',
        );

        final userId = await preferenceManager.getUserId();
        final companyId = await preferenceManager.getCompanyId();
        final languageId = await preferenceManager.getLanguageId();

        context.read<AppointmentBloc>().add(
          GetMyAppointmentEvent(
            GetMyAppointmentsRequestModel(
              getMyAppointments: 'getMyAppointments',
              userId: userId,
              companyId: companyId,
              languageId: languageId,
            ),
          ),
        );

        context.read<AppointmentBloc>().add(
          GetAppointmentEvent(
            GetAppointmentRequestModel(
              getAppointments: 'getAppointments',
              userId: userId,
              companyId: companyId,
              languageId: languageId,
            ),
          ),
        );

        context.read<TabbarBloc>().add(const TabChangeEvent(index: 1));
      } else if (state is AppointmentError) {
        Fluttertoast.showToast(msg: state.message);
      }
    },
    builder: (context, state) {
      if (state is AppointmentLoading) {
        return const AppointmentShimmer();
      } else if (state is AppointmentLoaded) {
        final appointmentList = state.filteredAppointmentRequests;

        if (appointmentList.isEmpty) {
          return const NoDataPreview(
            /**
             * This widget displays an icon and a message.
             * * @param {String} message - The text to display below the icon. This is always required.
             * * @param {String} icon - The asset path for the icon you want to show.
             * This is required, but it will only be used if `iconKey` is NOT null.
             *
             * @param {String?} iconKey - An optional key. If you provide any value for `iconKey`, the `icon`
             * parameter will be used. If you leave `iconKey` null, a default
             * `noDataImage` will be shown instead, and the `icon` parameter will be ignored.
             */
            icon: AppAssets.noDataImage,
            message: 'data_not_available',
          );
        }

        return RefreshIndicator(
          onRefresh: refreshAppointments,
          child: appointmentList.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: const Center(
                        child: NoDataPreview(
                          icon: AppAssets.noDataImage,
                          message: 'data_not_available',
                        ),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: appointmentList.length,
                  itemBuilder: (_, index) {
                    final appointmentRequest = appointmentList[index];

                    final String formattedTimeDate =
                        appointmentRequest.appointmentDatetime ?? 'N/A';

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 23 * Responsive.getResponsive(context),
                      ),
                      child: CommonCard(
                        borderRadius:
                            VariableBag.commonCardBorderRadius *
                            Responsive.getResponsive(context),
                        title: formattedTimeDate,
                        headerPrefixIcon: AppAssets.calendarIcon,
                        showHeaderPrefixIcon: true,
                        headerColor: AppTheme.getColor(context).primary,
                        bottomWidget: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                VariableBag.commonCardHorizontalPadding *
                                Responsive.getResponsive(context),
                            vertical:
                                VariableBag.commonCardHorizontalPadding *
                                Responsive.getResponsive(context),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                'appointment_request_by',
                                fontSize:
                                    13 * Responsive.getResponsiveText(context),
                                color: AppTheme.getColor(context).primary,
                                fontWeight: FontWeight.w600,
                              ),
                              AppointmentPersonDetails(
                                imagePath:
                                    appointmentRequest.userProfilePic ??
                                    AppAssets.myCoLogo,
                                empName:
                                    appointmentRequest.userFullName ?? 'NA',
                                designation:
                                    appointmentRequest.userDesignation ?? 'NA',
                                fieldWithCity:
                                    '${appointmentRequest.branchName ?? ''} - ${appointmentRequest.departmentName ?? ''}',
                              ),
                              Divider(
                                color: AppTheme.getColor(context).secondary,
                              ),
                              ReasonValueCommonRow(
                                heading: 'reason_for_appointment',
                                value:
                                    appointmentRequest.appointmentAgenda ??
                                    'NA',
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              ReasonValueCommonRow(
                                heading: 'location',
                                value:
                                    appointmentRequest.appointmentPlace ?? 'NA',
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              ReasonValueCommonRow(
                                heading: 'phone_no',
                                value: appointmentRequest.userMobile ?? 'NA',
                              ),
                              SizedBox(
                                height: 0.02 * Responsive.getHeight(context),
                              ),
                              Divider(
                                color: AppTheme.getColor(context).secondary,
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing:
                                    VariableBag.buttonRowSpacing *
                                    Responsive.getResponsive(context),
                                children: [
                                  MyCoButton(
                                    onTap: () async {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppTheme.getColor(
                                          context,
                                        ).surfaceBright,
                                        builder: (dialogContext) => CustomAlertDialog(
                                          // This builder creates 'dialogContext'
                                          alertType: AlertType.delete,
                                          title: LanguageManager().get(
                                            'reject_appointment',
                                          ),
                                          onCancel: () {
                                            Navigator.pop(dialogContext);
                                          },
                                          cancelText: LanguageManager().get(
                                            'no',
                                          ),
                                          onConfirm: () {
                                            Navigator.pop(dialogContext);
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (_) => BlocProvider.value(
                                                value: context
                                                    .read<AppointmentBloc>(),
                                                child: SingleChildScrollView(
                                                  padding: EdgeInsets.only(
                                                    bottom: MediaQuery.of(
                                                      context,
                                                    ).viewInsets.bottom,
                                                  ),
                                                  child: RejectRequestBottomSheet(
                                                    userName:
                                                        appointmentRequest
                                                            .userFullName ??
                                                        '',
                                                    appointmentId:
                                                        appointmentRequest
                                                            .appointmentId ??
                                                        '',
                                                    appointmentWithUserProfilePic:
                                                        appointmentRequest
                                                            .userProfilePic ??
                                                        '',
                                                    appointmentByUserId:
                                                        appointmentRequest
                                                            .appointmentByUserId ??
                                                        '',
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          confirmText: LanguageManager().get(
                                            'yes',
                                          ),
                                        ),
                                      );
                                    },
                                    title: LanguageManager().get('reject'),
                                    fontWeight: FontWeight.w600,
                                    textStyle: TextStyle(
                                      color: AppTheme.getColor(context).error,
                                    ),
                                    height:
                                        0.045 * Responsive.getHeight(context),
                                    width: 0.37 * Responsive.getWidth(context),
                                    boarderRadius:
                                        VariableBag.buttonBorderRadius *
                                        Responsive.getResponsive(context),
                                    borderColor: AppTheme.getColor(
                                      context,
                                    ).error,
                                    backgroundColor: AppColors.removeBackground,
                                  ),
                                  MyCoButton(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppTheme.getColor(
                                          context,
                                        ).surfaceBright,
                                        builder: (dialogContext) => CustomAlertDialog(
                                          alertType: AlertType.alert,
                                          title: LanguageManager().get(
                                            'approve_appointment',
                                          ),
                                          onCancel: () async {
                                            Navigator.pop(dialogContext);
                                          },
                                          cancelText: LanguageManager().get(
                                            'no',
                                          ),
                                          onConfirm: () async {
                                            Navigator.pop(dialogContext);
                                            context.read<AppointmentBloc>().add(
                                              ApprovedAppointmentEvent(
                                                ApproveAppointmentRequestModel(
                                                  approveAppointment:
                                                      'approveAppointment',
                                                  userId:
                                                      await preferenceManager
                                                          .getUserId(),
                                                  companyId:
                                                      await preferenceManager
                                                          .getCompanyId(),
                                                  languageId:
                                                      await preferenceManager
                                                          .getLanguageId(),
                                                  userName: appointmentRequest
                                                      .userFullName,
                                                  appointmentId:
                                                      appointmentRequest
                                                          .appointmentId,
                                                  appointmentByUserId:
                                                      appointmentRequest
                                                          .appointmentByUserId,
                                                ),
                                              ),
                                            );
                                          },
                                          confirmText: LanguageManager().get(
                                            'yes',
                                          ),
                                        ),
                                      );
                                    },
                                    title: LanguageManager().get('approve'),
                                    fontWeight: FontWeight.w600,
                                    textStyle: TextStyle(
                                      color: AppTheme.getColor(context).surface,
                                    ),
                                    height:
                                        0.045 * Responsive.getHeight(context),
                                    width: 0.37 * Responsive.getWidth(context),
                                    isShadowBottomLeft: true,
                                    boarderRadius:
                                        VariableBag.buttonBorderRadius *
                                        Responsive.getResponsive(context),
                                    borderColor: AppTheme.getColor(
                                      context,
                                    ).secondary,
                                    backgroundColor: AppTheme.getColor(
                                      context,
                                    ).secondary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      } else if (state is AppointmentError) {
        return Center(child: CustomText(state.message));
      }

      return const Center(child: CustomText('Tap to load appointments'));
    },
  );
}
