import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/appointments/data/models/request/reject_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button_theme.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class RejectRequestBottomSheet extends StatefulWidget {
  final String appointmentId;
  final String appointmentByUserId;
  final String userName;
  final String appointmentWithUserProfilePic;

  const RejectRequestBottomSheet({
    required this.appointmentId,
    required this.appointmentByUserId,
    required this.userName,
    required this.appointmentWithUserProfilePic,
    super.key,
  });

  @override
  State<RejectRequestBottomSheet> createState() =>
      _RejectRequestBottomSheetState();
}

class _RejectRequestBottomSheetState extends State<RejectRequestBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _reasonFieldKey = GlobalKey<FormFieldState<String>>();

  final reasonController = TextEditingController();
  late final PreferenceManager preferenceManager;

  int? currentFieldErrorIndex;

  @override
  void initState() {
    super.initState();
    preferenceManager = GetIt.I<PreferenceManager>();
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  void submitRejection() {
    if (!_reasonFieldKey.currentState!.validate()) {
      return;
    } else {
      dispatchRejectionEvent();
    }
  }

  Future<void> dispatchRejectionEvent() async {
    final rejectModel = RejectAppointmentRequestModel(
      rejectAppointment: 'rejectAppointment',
      userId: await preferenceManager.getUserId(),
      companyId: await preferenceManager.getCompanyId(),
      languageId: await preferenceManager.getLanguageId(),
      appointmentId: widget.appointmentId,
      appointmentByUserId: widget.appointmentByUserId,
      userName: widget.userName,
      appointmentRejectReason: reasonController.text.trim(),
    );

    if (mounted) {
      context.read<AppointmentBloc>().add(RejectAppointmentEvent(rejectModel));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Padding(
      padding: EdgeInsets.all(
        VariableBag.screenHorizontalPadding * Responsive.getResponsive(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          NewTextField(
            controller: reasonController,
            formFieldKey: _reasonFieldKey,
            prefixIconPath: AppAssets.assetMsgEdit.toString(),
            maxLines: 15,
            minLines: 5,
            hintText: LanguageManager().get('type_here'),
            label: LanguageManager().get('reject_request'),
            isRequired: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a reason for rejection.';
              }
              return null;
            },
          ),
          SizedBox(height: 40 * Responsive.getResponsive(context)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyCoButton(
                  title: LanguageManager().get('close'),
                  height: Responsive.getHeight(context) * .05,
                  boarderRadius: 30 * Responsive.getResponsive(context),
                  width: Responsive.getWidth(context) * .450,
                  backgroundColor: AppTheme.getColor(context).surfaceBright,
                  border: Border.all(color: AppTheme.getColor(context).primary),
                  textStyle: MyCoButtonTheme.getWhiteBackgroundTextStyle(
                    context,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: MyCoButton(
                  title: LanguageManager().get('submit'),
                  onTap: submitRejection,
                  height: Responsive.getHeight(context) * .05,
                  isShadowBottomLeft: true,
                  boarderRadius: 30,
                  width: Responsive.getWidth(context) * .450,
                ),
              ),
            ],
          ),
          SizedBox(
            height:
                VariableBag.textFieldRowGap * Responsive.getResponsive(context),
          ),
        ],
      ),
    ),
  );
}
