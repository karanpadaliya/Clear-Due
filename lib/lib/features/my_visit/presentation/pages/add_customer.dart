import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_visit/presentation/bloc/bloc_ui/visit_bloc.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/label_with_add_botton.dart';
import 'package:myco_flutter/features/my_visit/presentation/widgets/new_phone_number_field/new_phone_number_field.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_country_code_bottom_sheet/widgets/custom_country_code_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class AddCustomer extends StatelessWidget {
  AddCustomer({super.key});

  /// Controllers for All text fields
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController contactPersonNameController =
      TextEditingController();
  final TextEditingController phoneController1 = TextEditingController();
  final TextEditingController phoneController2 = TextEditingController();
  final TextEditingController anniversaryController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController retailerTypeController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController gstNumberController = TextEditingController();
  final TextEditingController distributorController = TextEditingController();
  final TextEditingController creditLimitController = TextEditingController();
  final TextEditingController creditDaysController = TextEditingController();

  final String selectedCode1 = '+91';
  final String selectedId1 = 'IND';
  final String selectedCode2 = '+91';
  final String selectedId2 = 'IND';

  final List<Map<String, String>> cityList = [
    {'id': 'cat1', 'name': 'Ahmedabad'},
    {'id': 'cat2', 'name': 'Bhavnagar'},
    {'id': 'cat3', 'name': 'Vadodara'},
    {'id': 'cat4', 'name': 'Rajkot'},
    {'id': 'cat5', 'name': 'Surat'},
    {'id': 'cat6', 'name': 'Botad'},
    {'id': 'cat7', 'name': 'Junagadh'},
    {'id': 'cat8', 'name': 'Maheshana'},
    {'id': 'cat9', 'name': 'Morbi'},
    {'id': 'cat10', 'name': 'Navsari'},
    {'id': 'cat11', 'name': 'Panchmahal'},
    {'id': 'cat12', 'name': 'Patan'},
    {'id': 'cat13', 'name': 'Porbandar'},
    {'id': 'cat14', 'name': 'Sabarkantha'},
    {'id': 'cat15', 'name': 'Surat'},
    {'id': 'cat16', 'name': 'Surendranagar'},
    {'id': 'cat17', 'name': 'Vadodara'},
    {'id': 'cat18', 'name': 'Valsad'},
    {'id': 'cat19', 'name': 'Vapi'},
  ];

  final List<Map<String, String>> areaList = [
    {'id': 'cat1', 'name': 'Maninagar'},
    {'id': 'cat2', 'name': 'Bopal'},
    {'id': 'cat3', 'name': 'Iskon'},
    {'id': 'cat4', 'name': 'sharkhej'},
    {'id': 'cat5', 'name': 'Thaltej'},
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'add_customer', isKey: true),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
      ),

      child: Column(
        spacing:
            VariableBag.formContentSpacingVertical *
            Responsive.getResponsive(context),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Customer Company Name
          NewTextField(
            label: 'Customer Company Name',
            hintText: 'type_here',
            prefixIconPath: AppAssets.building,
            controller: companyNameController,
            isRequired: true,
          ),

          /// Customer Category
          NewTextField(
            label: 'customer_category',
            hintText: 'select_category',
            prefixIconPath: AppAssets.element,
            controller: categoryController,
            enabled: false,
          ),

          /// Contact Person Name
          NewTextField(
            label: 'contact_person_name',
            hintText: 'type_here',
            prefixIconPath: AppAssets.profileCircle,
            controller: contactPersonNameController,
            isRequired: true,
          ),

          /// Contact Person Mobile Number field with country code
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'contact_person_mobile',
                fontWeight: FontWeight.w700,
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurfaceVariant,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),

              BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state is VisitLoaded) {
                    return NewPhoneNumberField(
                      selectedCountryCode: state.contactCode,
                      selectedCountryId: state.contactId,
                      phoneController: phoneController1,

                      onTapCountryPicker: () async {
                        final result = await showCountryCodeBottomSheet(
                          context: context,
                          heading: 'Select Country',
                          selectedId: state.contactCode,
                          searchHint: 'Search country',
                          btnTitle: 'close',
                        );
                        if (!context.mounted) return;
                        if (result != null) {
                          context.read<VisitBloc>().add(
                            UpdateContactPerson(
                              code: result.dialCode ?? '+91',
                              id: result.iso3Code ?? 'IND',
                            ),
                          );
                        }
                      },
                    );
                  }
                  return const SizedBox(); // fallback for other states
                },
              ),
            ],
          ),

          /// Alternative Phone Number
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'alternate_phone_number',
                fontWeight: FontWeight.w700,
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurfaceVariant,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state is VisitLoaded) {
                    return NewPhoneNumberField(
                      selectedCountryCode: state.alternativeCode,
                      selectedCountryId: state.alternativeId,
                      phoneController: phoneController2,
                      onTapCountryPicker: () async {
                        final result = await showCountryCodeBottomSheet(
                          context: context,
                          heading: 'Select Country',
                          selectedId: state.alternativeCode,
                          searchHint: 'Search country',
                          btnTitle: 'close',
                        );
                        if (!context.mounted) return;
                        if (result != null) {
                          context.read<VisitBloc>().add(
                            UpdateAlternativePhone(
                              code: result.dialCode ?? '+91',
                              id: result.iso3Code ?? 'IND',
                            ),
                          );
                        }
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),

          /// Date Of Birth
          NewTextField(
            label: 'date_of_birth',
            hintText: 'Enter Birth Date',
            prefixIconPath: AppAssets.date,
            controller: birthDateController,
            enabled: false,
          ),

          /// Anniversary Date
          NewTextField(
            label: 'anniversary_date',
            hintText: 'Enter Anniversary Date',
            prefixIconPath: AppAssets.date,
            controller: anniversaryController,
            enabled: false,
          ),

          /// Email ID
          NewTextField(
            label: 'email_id',
            hintText: 'email_contact_finca',
            prefixIconPath: AppAssets.sms,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          /// Select Location
          NewTextField(
            label: 'select_location',
            hintText: 'select_location',
            prefixIconPath: AppAssets.locationVisit,
            controller: locationController,
            isRequired: true,
          ),

          /// Address
          NewTextField(
            label: 'address',
            hintText: 'type_here',
            prefixIconPath: AppAssets.home,
            controller: addressController,
          ),

          /// Pincode
          NewTextField(
            label: 'pincode',
            hintText: 'type_here',
            prefixIconPath: AppAssets.lock,
            controller: pinCodeController,
            keyboardType: TextInputType.number,
          ),

          /// City dropdown with Add button
          Column(
            children: [
              LabelWithAddButton(
                label: 'city',
                actionText: 'add_city',
                labelFontSize: 14 * Responsive.getResponsiveText(context),
                actionFontSize: 14 * Responsive.getResponsiveText(context),
                onTap: () {},
                iconPath: AppAssets.addButton,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state is VisitLoaded) {
                    cityController.text = state.cityName ?? '';
                    return NewTextField(
                      prefixIconPath: AppAssets.areaMap,
                      suffixIconPath: AppAssets.downArrow,
                      hintText: 'state_not_assigned',
                      controller: cityController,
                      enabled: false,
                      onTap: () async {
                        final result = await showCustomSimpleBottomSheet(
                          context: context,
                          dataList: cityList,
                          heading: 'Select City',
                          isCloseButton: true,
                          selectedId: state.cityName,
                        );
                        if (!context.mounted) return;
                        if (result != null &&
                            result is Map &&
                            result['name'] != null) {
                          final cityName = result['name'].toString();
                          context.read<VisitBloc>().add(
                            CitySelectionEvent(cityName),
                          );
                        }
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),

          /// Area dropdown with Add button
          Column(
            children: [
              LabelWithAddButton(
                label: 'area',
                actionText: 'add_area',
                labelFontSize: 14 * Responsive.getResponsiveText(context),
                actionFontSize: 14 * Responsive.getResponsiveText(context),
                onTap: () {},
                iconPath: AppAssets.addButton,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state is VisitLoaded) {
                    areaController.text = state.areaName ?? '';
                    return NewTextField(
                      prefixIconPath: AppAssets.areaMap,
                      suffixIconPath: AppAssets.downArrow,
                      hintText: 'state_not_assigned',
                      controller: areaController,
                      enabled: false,
                      onTap: () async {
                        final result = await showCustomSimpleBottomSheet(
                          context: context,
                          dataList: areaList,
                          heading: 'Select City',
                          isCloseButton: true,
                          selectedId: state.areaName,
                        );
                        if (!context.mounted) return;
                        if (result != null &&
                            result is Map &&
                            result['name'] != null) {
                          final areaName = result['name'].toString();
                          context.read<VisitBloc>().add(
                            AreaSelectionEvent(areaName),
                          );
                        }
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),

          /// Retailer Type
          NewTextField(
            label: 'retailer_type',
            hintText: 'select',
            prefixIconPath: AppAssets.businessAndTrade,
            controller: retailerTypeController,
          ),

          /// Website
          NewTextField(
            label: 'website_contact_finca',
            hintText: 'type_here',
            prefixIconPath: AppAssets.global,
            controller: websiteController,
          ),

          /// GST Number
          NewTextField(
            label: 'tax_number',
            hintText: 'type_here',
            prefixIconPath: AppAssets.gst,
            controller: gstNumberController,
          ),

          /// Select Distributor
          NewTextField(
            isRequired: true,
            label: 'select_distributor',
            hintText: 'select_distributor',
            prefixIconPath: AppAssets.cardCoin,
            controller: distributorController,
          ),

          /// Credit Limit
          NewTextField(
            label: 'credit_limit',
            hintText: 'type_here',
            prefixIconPath: AppAssets.bitCinCard,
            controller: creditLimitController,
          ),

          /// Credit Days
          NewTextField(
            label: 'credit_days',
            hintText: 'type_here',
            prefixIconPath: AppAssets.emptyWalletTime,
            controller: creditDaysController,
          ),

          /// Shop Photo media picker
          CustomMediaPickerContainer(
            title: 'shop_photo',
            titleColor: AppTheme.getColor(context).onSurfaceVariant,
            titleFontSize: 14 * Responsive.getResponsiveText(context),
            imageTitle: 'select_media',
            containerHeight: 0.125 * Responsive.getHeight(context),
            multipleImage: 5,
            imagePath: AppAssets.galleryExport,
            isCameraShow: true,
            isGalleryShow: true,
            isDocumentShow: true,
            isCropImage: true,
            imageTitleSize: 14 * Responsive.getResponsiveText(context),
            imageTitleColor: AppTheme.getColor(context).onSurfaceVariant,
          ),

          ///  space below media picker
          SizedBox(height: 0.03 * Responsive.getHeight(context)),

          /// Submit button
          MyCoButton(
            onTap: () {
              context.pushNamed('customer-page');
            },
            title: 'submit',
            isShadowBottomLeft: true,
            boarderRadius:
                VariableBag.buttonBorderRadius *
                Responsive.getResponsive(context),
            textStyle: TextStyle(
              fontSize: 20 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w500,
              color: AppTheme.getColor(context).onPrimary,
            ),
          ),

          /// Extra spacing at end
          const SizedBox(),
          const SizedBox(),
        ],
      ),
    ),
  );
}
