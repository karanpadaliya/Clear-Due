import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_event.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_state.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bottom_sheet/calender_sheet.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/label_row.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/selected_date_display_row.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class WfhAddNew extends StatefulWidget {
  const WfhAddNew({super.key});

  @override
  State<WfhAddNew> createState() => _WfhAddNewState();
}

class _WfhAddNewState extends State<WfhAddNew> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _dateFieldKey = GlobalKey<FormFieldState<String>>();
  final _reasonFieldKey = GlobalKey<FormFieldState<String>>();
  final _locationFieldKey = GlobalKey<FormFieldState<String>>();

  final dateController = TextEditingController();
  final reasonController = TextEditingController();
  final locationController = TextEditingController();

  DateTime focusedDay = DateTime.now();
  Map<DateTime, String> pickedDates = {};
  GetWfhAddressListEntity? _selectedAddress;

  @override
  void initState() {
    super.initState();
    context.read<AddWfhBloc>().add(FetchWFHList());
  }

  @override
  void dispose() {
    dateController.dispose();
    reasonController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void _updateDateTextField() {
    if (pickedDates.isEmpty) {
      dateController.text = '';
    } else if (pickedDates.length == 1) {
      final date = pickedDates.keys.first;
      dateController.text = '${date.day}/${date.month}/${date.year}';
    } else {
      dateController.text = '${pickedDates.length} dates selected';
    }
    _dateFieldKey.currentState?.validate();
  }

  /// This function implements validation.
  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (!_dateFieldKey.currentState!.validate()) {
      return;
    }
    if (!_reasonFieldKey.currentState!.validate()) {
      return;
    }
    final state = context.read<AddWfhBloc>().state;
    if (state is WFHLoaded) {
      final addressList = state.wfhAddressList;
      if (addressList.isEmpty) {
        if (!_locationFieldKey.currentState!.validate()) {
          return;
        }
      } else {
        if (_selectedAddress == null) {
          Fluttertoast.showToast(msg: 'Please select address');
          return;
        }
      }
    }

    Fluttertoast.showToast(msg: 'Form is valid! Submitting...');
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 16 * Responsive.getResponsive(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NewTextField(
                        formFieldKey: _dateFieldKey,
                        controller: dateController,
                        label: LanguageManager().get('select_date'),
                        isRequired: true,
                        hintText: LanguageManager().get('select_wfh_date'),
                        prefixIconPath: AppAssets.date,
                        validator: (value) {
                          if (pickedDates.isEmpty) {
                            return 'Please select at least one date';
                          }
                          return null;
                        },
                        onTap: () async {
                          final result =
                              await showModalBottomSheet<Map<DateTime, String>>(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
                                  child: CalendarSheet(
                                    initialDates: pickedDates,
                                    focusedDay: focusedDay,
                                  ),
                                ),
                              );

                          if (result != null) {
                            setState(() {
                              pickedDates = result;
                              if (result.isNotEmpty) {
                                focusedDay = result.keys.last;
                              }
                              _updateDateTextField();
                            });
                          }
                        },
                      ),
                      if (pickedDates.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              children: pickedDates.entries
                                  .map(
                                    (entry) => SelectedDateDisplayRow(
                                      date: entry.key,
                                      dayPart: entry.value,
                                      onDelete: () {
                                        setState(() {
                                          pickedDates.remove(entry.key);
                                          _updateDateTextField();
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),

                      SizedBox(height: 0.019 * Responsive.getHeight(context)),

                      NewTextField(
                        formFieldKey: _reasonFieldKey,
                        controller: reasonController,
                        label: 'Reason',
                        isRequired: true,
                        hintText: 'Reason to WFH',
                        prefixIconPath: AppAssets.messageQuestion,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a reason';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 0.019 * Responsive.getHeight(context)),

                      LabelRow(
                        title: 'Location',
                        actionLabel: 'Add more location',
                        isSelectBtn: true,
                        onTap: () async {
                          Fluttertoast.showToast(msg: 'Add Address');
                        },
                      ),
                      SizedBox(height: 8 * Responsive.getHeight(context) / 812),

                      /// --- DYNAMIC LOCATION UI ---
                      BlocBuilder<AddWfhBloc, AddWfhState>(
                        builder: (context, state) => _buildLocationInput(state),
                      ),

                      SizedBox(height: 0.019 * Responsive.getHeight(context)),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2 * Responsive.getResponsive(context),
                        ),
                        child: CustomMediaPickerContainer(
                          title: 'attachment',
                          titleColor: AppTheme.getColor(
                            context,
                          ).onSurfaceVariant,
                          titleFontSize:
                              14 * Responsive.getResponsiveText(context),
                          imageTitle: 'attach_file',
                          multipleImage: 5,
                          imageTitleIsKey: true,
                          titleIsKey: true,
                          imagePath: AppAssets.date,
                          isCameraShow: true,
                          isGalleryShow: true,
                          isDocumentShow: true,
                          isCropImage: true,
                          imageTitleSize:
                              14 * Responsive.getResponsiveText(context),
                          imageTitleColor: AppTheme.getColor(
                            context,
                          ).onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 0.019 * Responsive.getHeight(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 13 * Responsive.getResponsive(context),
            ),
            child: MyCoButton(
              onTap: _submitForm,
              title: LanguageManager().get('submit'),
              isShadowBottomLeft: true,
              boarderRadius: 30 * Responsive.getResponsive(context),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildLocationInput(AddWfhState state) {
    if (state is WFHLoading && state is! WFHLoaded) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is WFHError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    if (state is WFHLoaded) {
      final addressList = state.wfhAddressList;

      if (addressList.isEmpty) {
        return NewTextField(
          formFieldKey: _locationFieldKey,
          controller: locationController,
          isRequired: true,
          hintText: LanguageManager().get('select_wfh_location'),
          prefixIconPath: AppAssets.location,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a location';
            }
            return null;
          },
        );
      }

      return Column(
        children: addressList.map((address) {
          final isCurrentAddressSelected =
              _selectedAddress?.wfhAddressId == address.wfhAddressId;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CommonCard(
              title: address.wfhAddressTitle ?? 'Address',
              headerColor: AppColors.primary,
              suffixIcon: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: 'Delete address tapped');
                },
                child: SvgPicture.asset(AppAssets.trashIcon),
              ),
              bottomWidget: InkWell(
                onTap: () {
                  setState(() {
                    _selectedAddress = address;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        VariableBag.commonCardHorizontalPadding *
                        Responsive.getResponsive(context),
                    vertical:
                        VariableBag.commonCardVerticalPadding *
                        Responsive.getResponsive(context),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20 * Responsive.getResponsive(context),
                        height: 20 * Responsive.getResponsive(context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.getColor(context).primary,
                            width: 2 * Responsive.getResponsive(context),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 10 * Responsive.getResponsive(context),
                            height: 10 * Responsive.getResponsive(context),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCurrentAddressSelected
                                  ? AppTheme.getColor(context).primary
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8 * Responsive.getResponsive(context)),
                      Expanded(
                        child: CustomText(
                          address.wfhAddress ?? 'No address details',
                          fontSize: 14 * Responsive.getResponsiveText(context),
                          color: AppTheme.getColor(context).onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    }
    return const Center(child: CustomText('Loading...'));
  }
}
