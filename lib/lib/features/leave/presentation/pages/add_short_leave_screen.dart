import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_event.dart';
import 'package:myco_flutter/features/leave/presentation/bloc/leave_state.dart';
import 'package:myco_flutter/features/leave/presentation/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/widgets/custom_loader_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AddShortLeaveScreen extends StatefulWidget {
  const AddShortLeaveScreen({super.key});

  @override
  State<AddShortLeaveScreen> createState() => _AddShortLeaveScreenState();
}

class _AddShortLeaveScreenState extends State<AddShortLeaveScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final FocusNode _reasonFocusNode = FocusNode();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _reasonController.dispose();
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    _reasonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Add Short Leave')),
      body: BlocListener<LeaveBloc, LeaveState>(
        listener: (context, state) {
          if (state is ShortLeaveAdded) {
            context.pop(true);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Short leave added successfully')));
            Navigator.pop(context, true);
          } else if (state is LeaveError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is LeaveLoading) {
            CustomLoaderDialog.show(context);
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() => InkWell(
    focusColor: Colors.transparent,
    onTap: () {
      _reasonFocusNode.unfocus();
      _dateFocusNode.unfocus();
      _timeFocusNode.unfocus();
    },
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20 * Responsive.getResponsive(context),
          right: 20 * Responsive.getResponsive(context),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  NewTextField(
                    controller: _dateController,
                    label: 'select_date',
                    enabled: true,
                    isRequired: true,
                    hintText: 'select_date',
                    validator: (value) {
                      if (_dateController.text.isEmpty) {
                        return 'Please select a date';
                      }
                      // Add more specific date validation if needed
                      return null;
                    },
                    onTap: _showDatePicker,
                    prefixIconPath: AppAssets.note_favorite,
                    suffixIconPath: AppAssets.downArrow,
                  ),
                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                  NewTextField(
                    controller: _timeController,
                    label: 'short_leave_time',
                    enabled: true,
                    isRequired: true,
                    hintText: 'short_leave_time',
                    onTap: _showTimePicker,
                    validator: (value) {
                      if (_timeController.text.isEmpty) {
                        return 'Please select a time';
                      }
                      return null;
                    },
                    prefixIconPath: AppAssets.note_favorite,
                    suffixIconPath: AppAssets.downArrow,
                  ),
                  SizedBox(height: 0.02 * Responsive.getHeight(context)),
                  NewTextField(
                    controller: _reasonController,
                    label: 'short_leave_apply_reason',

                    enabled: true,
                    isRequired: true,
                    hintText: 'short_leave_apply_reason',
                    maxLines: 5,
                    minLines: 5,
                    validator: (value) {
                      if (_reasonController.text.isEmpty) {
                        return 'Please enter a reason';
                      }
                      return null;
                    },
                    prefixIconPath: AppAssets.note_favorite,
                  ),
                ],
              ),

              MyCoButton(
                onTap: () {
                  log('Date: ${_dateController.text}', name: 'AddShortLeaveScreen');
                  log('Time: ${_timeController.text}', name: 'AddShortLeaveScreen');
                  log('Reason: ${_reasonController.text}', name: 'AddShortLeaveScreen');

                  if (_formKey.currentState?.validate() ?? false) {
                    log('Dispatching event', name: 'AddShortLeaveScreen');
                    context.read<LeaveBloc>().add(
                      AddShortLeave(
                        _dateController.text,
                        _timeController.text,
                        _reasonController.text,
                      ),
                    );
                  } else {
                    log('Validation failed', name: 'AddShortLeaveScreen');
                  }
                },

                title: LanguageManager().get('add'),
                height: 0.065 * Responsive.getHeight(context),
                width: 0.65 * Responsive.getWidth(context),
                boarderRadius: 30,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onPrimary,
                ),
                backgroundColor: AppTheme.getColor(context).primary,
                isShadowBottomLeft: true,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _showDatePicker() {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: DialDatePickerWidget(
          initialDate: DateTime.now(),
          onSubmit: (selectedDate) {
            final String date = DateFormat('yyyy-MM-dd').format(selectedDate);
            _dateController.text = date;
            _formKey.currentState?.validate();
            log(date, name: 'Picked Date');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showTimePicker() {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: DialDatePickerWidget(
          timePicker: true,
          initialDate: DateTime.now(),
          onSubmit: (selectedDate) {
            final String time = DateFormat('HH:mm').format(selectedDate);
            _timeController.text = time;
            log(time, name: 'Picked Time');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
