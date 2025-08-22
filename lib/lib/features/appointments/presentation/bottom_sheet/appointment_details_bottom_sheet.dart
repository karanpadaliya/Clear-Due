import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/appointments/data/models/request/add_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:myco_flutter/widgets/common_card.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/ios_calendar_time_picker.dart';

class AppointmentDetailsBottomSheet extends StatefulWidget {
  final String appointmentForUserId;
  final String userFullName;
  final String userMobile;
  final String userProfilePic;

  const AppointmentDetailsBottomSheet({
    required this.appointmentForUserId,
    required this.userFullName,
    required this.userMobile,
    required this.userProfilePic,
    super.key,
  });

  @override
  State<AppointmentDetailsBottomSheet> createState() =>
      _AppointmentDetailsBottomSheetState();
}

class _AppointmentDetailsBottomSheetState
    extends State<AppointmentDetailsBottomSheet> {
  final _timeFieldKey = GlobalKey<FormFieldState<String>>();
  final _placeFieldKey = GlobalKey<FormFieldState<String>>();
  final _reasonFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final timeController = TextEditingController();
  final placeController = TextEditingController();
  final reasonController = TextEditingController();

  DateTime? selectedAppointmentTime;
  late PreferenceManager preferenceManager;

  @override
  void initState() {
    super.initState();
    preferenceManager = GetIt.I<PreferenceManager>();
  }

  @override
  void dispose() {
    timeController.dispose();
    placeController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<AppointmentBloc, AppointmentState>(
    listener: (context, state) {
      if (state is AppointmentError) {
        Fluttertoast.showToast(msg: state.message);
      } else if (state is CommonResponseAppointment) {
        Navigator.pop(context, true);
        Fluttertoast.showToast(
          msg: state.commonResponse.message ?? 'Appointment added successfully',
        );
      }
    },
    builder: (context, state) => Stack(
      /// this is for custom loader
      children: [
        SafeArea(
          /// this is for bottomSheet
          child: CommonCard(
            /// this is main content of bottomSheet
            headerColor: AppTheme.getColor(context).primary,
            headerPrefixIconWidth: 50 * Responsive.getResponsive(context),
            title: widget.userFullName,
            subTitle: widget.userMobile,
            headerPrefix: CustomCachedNetworkImage(
              imageUrl: widget.userProfilePic,
              userName: widget.userFullName,
              height: 40 * Responsive.getResponsive(context),
              isCircular: true,
            ),
            showHeaderPrefixIcon: true,
            bottomWidget: Padding(
              padding: EdgeInsets.only(
                bottom: 32 * Responsive.getResponsive(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10 * Responsive.getResponsive(context),
                      top: 16 * Responsive.getResponsive(context),
                    ),
                    child: CustomText(
                      'Appointment Details',
                      fontWeight: FontWeight.w700,
                      color: AppTheme.getColor(context).primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: VariableBag.bottomSheetTopPadding,
                      bottom: VariableBag.bottomSheetBottomPadding,
                      left: VariableBag.bottomSheetLeftPadding,
                      right: VariableBag.bottomSheetRightPadding,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NewTextField(
                            label: LanguageManager().get('times'),
                            hintText: LanguageManager().get('select_time'),
                            prefixIconPath: AppAssets.assetClock2.toString(),
                            controller: timeController,
                            formFieldKey: _timeFieldKey,
                            isRequired: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please select a time';
                              }
                              return null;
                            },
                            onTap: () async {
                              final String? selectedTimeString =
                                  await showPicker(
                                    context,
                                    pickDay: false,
                                    timePicker: true,
                                    use24hFormat: false,
                                  );

                              if (selectedTimeString != null &&
                                  selectedTimeString.isNotEmpty) {
                                try {
                                  final DateFormat format = DateFormat(
                                    'hh:mm a',
                                  );
                                  final DateTime parsedTime = format.parse(
                                    selectedTimeString,
                                  );
                                  final now = DateTime.now();
                                  selectedAppointmentTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    parsedTime.hour,
                                    parsedTime.minute,
                                  );
                                  timeController.text = selectedTimeString;
                                  _timeFieldKey.currentState?.validate();
                                } catch (e) {
                                  log('Error parsing time: $e');
                                  Fluttertoast.showToast(
                                    msg:
                                        'Invalid time format. Please try again.',
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 0.019 * Responsive.getHeight(context),
                          ),
                          NewTextField(
                            label: LanguageManager().get('place'),
                            hintText: LanguageManager().get('type_here'),
                            prefixIconPath: AppAssets.assetLocation.toString(),
                            controller: placeController,
                            formFieldKey: _placeFieldKey,
                            isRequired: true,
                            enabled: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a place';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 0.019 * Responsive.getHeight(context),
                          ),
                          NewTextField(
                            hintText: LanguageManager().get('type_here'),
                            label: 'Reason',
                            enabled: true,
                            maxLines: 5,
                            minLines: 1,
                            isRequired: true,
                            controller: reasonController,
                            formFieldKey: _reasonFieldKey,
                            prefixIconPath: AppAssets.assetStickyNote
                                .toString(),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a reason';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 0.023 * Responsive.getHeight(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: MyCoButton(
                                  title: LanguageManager().get('cancel'),
                                  height: Responsive.getHeight(context) * .05,
                                  boarderRadius:
                                      30 * Responsive.getResponsive(context),
                                  width: Responsive.getWidth(context) * .450,
                                  backgroundColor: AppColors.white,
                                  border: Border.all(
                                    color: AppTheme.getColor(context).primary,
                                  ),
                                  textStyle:
                                      MyCoButtonTheme.getWhiteBackgroundTextStyle(
                                        context,
                                      ),
                                  onTap: () {
                                    Navigator.pop(context, false);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 0.04 * Responsive.getWidth(context),
                              ),
                              Expanded(
                                child: MyCoButton(
                                  title: LanguageManager().get('send_request'),
                                  height: Responsive.getHeight(context) * .05,
                                  isShadowBottomLeft: true,
                                  boarderRadius: 30,
                                  width: Responsive.getWidth(context) * .450,
                                  onTap: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      final request =
                                          AddAppointmentRequestModel(
                                            addAppointment: 'addAppointment',
                                            companyId: await preferenceManager
                                                .getCompanyId(),
                                            languageId: await preferenceManager
                                                .getLanguageId(),
                                            appointmentByUserId:
                                                await preferenceManager
                                                    .getUserId(),
                                            appointmentForUserId:
                                                widget.appointmentForUserId,
                                            appointmentDatetime:
                                                selectedAppointmentTime
                                                    .toString(),
                                            appointmentPlace:
                                                placeController.text,
                                            appointmentAgenda:
                                                reasonController.text,
                                            userName: widget.userFullName,
                                            userDesignation: '',
                                          );
                                      context.read<AppointmentBloc>().add(
                                        AddAppointmentEvent(request),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (state is AppointmentLoading) const CustomLoader(),
      ],
    ),
  );
}
