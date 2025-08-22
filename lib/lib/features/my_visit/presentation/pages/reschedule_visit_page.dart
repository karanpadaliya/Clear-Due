import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/assigned_to.dart';
import 'package:myco_flutter/features/my_visit/presentation/pages/visit_with.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/field_virtual_visit_toggle.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/my_visit_custom_radio_button.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_checkbox.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class RescheduleVisitPage extends StatefulWidget {
  const RescheduleVisitPage({super.key});

  @override
  State<RescheduleVisitPage> createState() => _RescheduleVisitPageState();
}

class _RescheduleVisitPageState extends State<RescheduleVisitPage> {
  final List<String> visitTypes = [
    'Self Visit',
    'Add visit for other employee',
    'Visit With',
  ];

  final List<String> customers = ['Customer A', 'Customer B', 'Customer C'];
  final List<String> timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '2:00 PM - 3:00 PM',
  ];
  final List<String> visitPurposes = ['Sales', 'Support', 'Demo'];
  final List<String> rescheduleReasons = [
    'Client not available',
    'Weather issue',
    'Personal emergency',
  ];

  void _openVisitWithBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.getColor(context).surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => VisitWith(),
    );
  }

  void _openAssignedToBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.getColor(context).surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => AssignedTo(),
    );
  }

  String selectedVisitType = 'Self Visit';
  String? selectedCustomer;
  String? selectedTimeSlot;
  String? selectedVisitPurpose;
  String? selectedRescheduleReason;

  final TextEditingController amountController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    String selectedFieldVisit = 'Field Visit';

    return Scaffold(
      appBar: const CustomAppbar(title: 'reschedule_visit', isKey: true),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: BlocBuilder<VisitBloc, VisitState>(
          builder: (context, state) => Column(
            spacing:
                VariableBag.textFieldRowGap * Responsive.getResponsive(context),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visit Type Radio Group
              CustomVisitTypeRadioButton(
                options: visitTypes,
                borderRadius: 12,
                activeColor: AppTheme.getColor(context).primary,
                borderColor: AppTheme.getColor(context).primary,
                // textStyle: TextStyle(
                //   color: AppTheme.getColor(context).onSurface,
                // ),
                selectedValue: state is VisitLoaded
                    ? state.selectedVisitType
                    : 'Self Visit',
                onChanged: (value, index) {
                  // context.read<VisitBloc>().add(
                  //   UpdateVisitTypeEvent(
                  //     selectedVisitType: value,
                  //     index: index,
                  //   ),
                  // );
                  if (index == visitTypes.length - 1) {
                    _openVisitWithBottomSheet(context);
                  } else if (index == visitTypes.length - 2) {
                    _openAssignedToBottomSheet(context);
                  }
                },
              ),

              //Select Customer *
              NewTextField(
                label: 'customer_to_visit',
                prefixIconPath: AppAssets.personalcard,
                suffixIconPath: AppAssets.arrow_down,
                hintText: 'Select',
                onTap: () {
                  context.pop(context);
                  context.pushNamed('customerPage');
                },
              ),
              // Visit Date
              NewTextField(
                label: 'visit_date',
                prefixIconPath: AppAssets.note_favorite,
                hintText: 'select_date',
                controller: amountController,
                keyboardType: TextInputType.datetime,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Please enter a date' : null,
                onTap: () async {
                  // Example: show date picker
                },
              ),

              //Select Slot
              NewTextField(
                label: 'visit_slots',
                prefixIconPath: AppAssets.clock,
                suffixIconPath: AppAssets.arrow_down,
                hintText: selectedTimeSlot ?? 'select_time_slot',
                controller: TextEditingController(text: selectedTimeSlot ?? ''),
                onTap: () {
                  // handle tap function
                },
              ),

              // Field / Virtual Visit
              FieldVirtualVisitToggle(
                selectedValue: selectedFieldVisit,
                onChanged: (v) => setState(() => selectedFieldVisit = v),
              ),
              //Select Purpose
              NewTextField(
                label: 'visit_type',
                prefixIconPath: AppAssets.gps,
                suffixIconPath: AppAssets.arrow_down,
                hintText: selectedTimeSlot ?? 'Select Purpose',
                onTap: () {
                  // handle tap function
                },
              ),

              // Visit Purpose dropdown
              NewTextField(
                label: 'visit_purpose',
                prefixIconPath: AppAssets.gps,
                suffixIconPath: AppAssets.arrow_down,
                hintText: selectedRescheduleReason ?? 'select_reason',
                controller: TextEditingController(
                  text: selectedRescheduleReason ?? '',
                ),
                onTap: () {
                  // handle on tap function
                },
              ),

              const NewTextField(
                label: 'purpose_of_visiting',
                prefixIconPath: AppAssets.sticky_note,
                hintText: 'write_here',
                maxLines: 10,
              ),

              const CustomMediaPickerContainer(
                title: 'Attachment',
                imageTitle: 'Select Attachment',
                multipleImage: 1,
                imagePath: AppAssets.assetBookmark_2,
                isDocumentShow: true,
              ),

              // Agreement + Submit
              Padding(
                padding: EdgeInsets.only(
                  top: 0.08 * Responsive.getHeight(context),
                ),
                child: Row(
                  children: [
                    CustomCheckbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        // handle checkbox change
                      },
                      borderColor: AppTheme.getColor(context).primary,
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      height: 24 * Responsive.getResponsive(context),
                      width: 24 * Responsive.getResponsive(context),
                      unCheckedBackground: Colors.transparent,
                    ),
                    SizedBox(width: 10 * Responsive.getResponsive(context)),
                    Expanded(
                      child: CustomText(
                        'auto_start_visit',
                        fontSize: 14 * Responsive.getResponsiveText(context),
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              //Submit
              MyCoButton(
                title: 'Submit',
                onTap: () {
                  // handle submit button
                },
                backgroundColor: AppColors.primary,
                textStyle: TextStyle(
                  fontSize: 16 * Responsive.getResponsiveText(context),
                  color: AppTheme.getColor(context).onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                width: 1.2 * Responsive.getWidth(context),
                isShadowBottomLeft: true,
                boarderRadius:
                    VariableBag.buttonBorderRadius *
                    Responsive.getResponsive(context),
              ),
              SizedBox(height: 0.01 * Responsive.getHeight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
