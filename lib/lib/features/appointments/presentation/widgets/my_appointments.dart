import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/appointments/data/models/request/add_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/delete_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_my_appointments_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/send_appointment_reminder_request_model.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/appointment_person_details.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/appointment_shimmer.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/no_data_preview.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/reason_value_common_row.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  late PreferenceManager preferenceManager;

  Color getHeaderColor(String status) {
    switch (status) {
      case '1': // Approved
        return AppTheme.getColor(context).secondary;
      case '0': // Pending
        return AppColors.spanishYellow;
      case '2': // Rejected
        return AppTheme.getColor(context).error;
      default:
        return Colors.grey;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case '1':
        return 'Approved';
      case '0':
        return 'Pending';
      case '2':
        return 'Rejected';
      default:
        return 'N/A';
    }
  }

  @override
  void initState() {
    super.initState();
    preferenceManager = GetIt.I<PreferenceManager>();
  }

  Future<void> refreshMyAppointments() async {
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
      if (state is CommonResponseAppointment) {
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
      } else if (state is AppointmentError) {
        Fluttertoast.showToast(msg: state.message);
      }
    },

    builder: (context, state) {
      if (state is AppointmentLoading) {
        return const AppointmentShimmer();
      } else if (state is AppointmentLoaded) {
        final appointmentList = state.filteredMyAppointments;

        if (appointmentList.isEmpty) {
          return const NoDataPreview(
            icon: AppAssets.noDataImage,
            message: 'data_not_available',
          );
        }

        return RefreshIndicator(
          onRefresh: refreshMyAppointments,
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
                    final myAppointment = appointmentList[index];
                    final status = myAppointment.appointmentStatus ?? '';

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 23 * Responsive.getResponsive(context),
                      ),
                      child: CommonCard(
                        title: myAppointment.appointmentDatetime ?? 'NA',
                        headerPrefixIcon: AppAssets.calendarIcon,
                        showHeaderPrefixIcon: true,
                        headerColor: getHeaderColor(status),
                        borderRadius:
                            VariableBag.commonCardBorderRadius *
                            Responsive.getResponsive(context),
                        suffixIcon: (status == '0' || status == '2')
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //Send Reminder
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppTheme.getColor(
                                          context,
                                        ).surfaceBright,
                                        builder: (dialogContext) => CustomAlertDialog(
                                          alertType: AlertType.warning,
                                          title: LanguageManager().get(
                                            'send_reminder_notification',
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
                                              SendAppointmentReminderEvent(
                                                SendAppointmentReminderRequestModel(
                                                  sendAppointmentReminder:
                                                      'sendAppointmentReminder',
                                                  companyId:
                                                      await preferenceManager
                                                          .getCompanyId(),
                                                  languageId:
                                                      await preferenceManager
                                                          .getLanguageId(),
                                                  appointmentId: myAppointment
                                                      .appointmentId,
                                                  userName: myAppointment
                                                      .userFullName,
                                                  userId:
                                                      await preferenceManager
                                                          .getUserId(),
                                                  appointmentAgenda:
                                                      myAppointment
                                                          .appointmentAgenda,
                                                  appointmentForUserId:
                                                      myAppointment
                                                          .appointmentForUserId,
                                                  appointmentPlace:
                                                      myAppointment
                                                          .appointmentPlace,
                                                  appointmentTime: myAppointment
                                                      .appointmentDatetime,
                                                  forUserName: '',
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
                                    child: SvgPicture.asset(
                                      AppAssets.assetBellRinging,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.03 * Responsive.getWidth(context),
                                  ),
                                  //delete appointment
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppTheme.getColor(
                                          context,
                                        ).surfaceBright,
                                        builder: (dialogContext) => CustomAlertDialog(
                                          alertType: AlertType.delete,
                                          title: LanguageManager().get(
                                            'delete_appointment',
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
                                              DeleteAppointmentEvent(
                                                DeleteAppointmentRequestModel(
                                                  deleteAppointment:
                                                      'deleteAppointment',
                                                  companyId:
                                                      await preferenceManager
                                                          .getCompanyId(),
                                                  languageId:
                                                      await preferenceManager
                                                          .getLanguageId(),
                                                  appointmentId: myAppointment
                                                      .appointmentId,
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
                                    child: SvgPicture.asset(
                                      AppAssets.assetTrashIcon,
                                    ),
                                  ),
                                ],
                              )
                            : null,

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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    'Appointment From',
                                    fontSize:
                                        13 *
                                        Responsive.getResponsiveText(context),
                                    color: AppTheme.getColor(context).primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  MyCoButton(
                                    onTap: () {},
                                    title: getStatusLabel(status),
                                    textStyle: TextStyle(
                                      color: getHeaderColor(status),
                                    ),
                                    height:
                                        0.030 * Responsive.getHeight(context),
                                    width: 0.23 * Responsive.getWidth(context),
                                    boarderRadius:
                                        23 * Responsive.getResponsive(context),
                                    borderColor: getHeaderColor(
                                      myAppointment.appointmentStatus ?? '',
                                    ),
                                    borderWidth: 2,
                                    backgroundColor: AppTheme.getColor(
                                      context,
                                    ).surface,
                                  ),
                                ],
                              ),
                              AppointmentPersonDetails(
                                imagePath:
                                    myAppointment.userProfilePic ??
                                    AppAssets.myCoLogo,
                                empName: myAppointment.userFullName ?? '',
                                designation:
                                    myAppointment.userDesignation ?? '',
                                fieldWithCity:
                                    '${myAppointment.branchName ?? ''} - ${myAppointment.departmentName ?? ''}',
                              ),
                              Divider(
                                color: AppTheme.getColor(context).secondary,
                              ),
                              ReasonValueCommonRow(
                                heading: 'reason_for_appointment',
                                value: myAppointment.appointmentAgenda ?? '',
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              ReasonValueCommonRow(
                                heading: 'location',
                                value: myAppointment.appointmentPlace ?? '',
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              ReasonValueCommonRow(
                                heading: 'phone_no',
                                value: myAppointment.userMobile ?? '',
                              ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              ReasonValueCommonRow(
                                heading: 'Create Data & Time',
                                value:
                                    myAppointment.appointmentCreatedDate ?? '',
                              ),
                              if (status == '2')
                                Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          0.01 * Responsive.getHeight(context),
                                    ),
                                    ReasonValueCommonRow(
                                      heading: 'reason_for_rejection',
                                      value:
                                          myAppointment
                                              .appointmentRejectReason ??
                                          '',
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 0.01 * Responsive.getHeight(context),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  context.read<AppointmentBloc>().add(
                                    AddAppointmentEvent(
                                      AddAppointmentRequestModel(
                                        addAppointment: 'addAppointment',
                                        appointmentByUserId:
                                            await preferenceManager.getUserId(),
                                        companyId: await preferenceManager
                                            .getCompanyId(),
                                        languageId: await preferenceManager
                                            .getLanguageId(),
                                        appointmentForUserId:
                                            myAppointment.appointmentForUserId,
                                        appointmentAgenda:
                                            myAppointment.appointmentAgenda,
                                        appointmentDatetime:
                                            myAppointment.appointmentDatetime,
                                        appointmentPlace:
                                            myAppointment.appointmentPlace,
                                        userDesignation:
                                            myAppointment.userDesignation,
                                        userName: myAppointment.userFullName,
                                      ),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CustomText(
                                    're_appointment',
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.getColor(context).primary,
                                    textAlign: TextAlign.end,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppTheme.getColor(
                                      context,
                                    ).primary,
                                  ),
                                ),
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
        return CustomText(state.message);
      }
      return const Center(child: CustomText('Tap to load My Appointment'));
    },
  );
}
