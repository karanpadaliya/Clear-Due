import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/company_selector/data/models/request/request_society_model.dart';
import 'package:myco_flutter/features/company_selector/domain/usecases/request_society.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/inquiry/inquiry_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/inquiry/inquiry_event.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/inquiry/inquiry_state.dart';
import 'package:myco_flutter/widgets/custom_countrycodetextfield.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class SalesInquiryForm extends StatefulWidget {
  const SalesInquiryForm({super.key});

  @override
  State<SalesInquiryForm> createState() => _SalesInquiryFormState();
}

class _SalesInquiryFormState extends State<SalesInquiryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _companyController = TextEditingController();
  final _employeesController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => InquiryBloc(GetIt.I<RequestSocietyUseCase>()),
    child: BlocConsumer<InquiryBloc, InquiryState>(
      listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: CustomText(state.message)));
        } else if (state is SuccessState) {
          Navigator.pop(context); // Close the form
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: CustomText(state.message)));
        }
      },
      builder: (context, state) => Stack(
        children: [
          _buildForm(context),
          if (state is LoadingState)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black45,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    ),
  );

  Widget _buildForm(BuildContext context) {
    final bloc = context.read<InquiryBloc>();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'sales_inquiry',
                fontSize: 18 * Responsive.getResponsive(context),
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              _buildTextField(_nameController, 'contact_person_name', true),
              Row(
                children: [
                  CustomText(
                    'contact_person_mobile',
                    color: AppTheme.getColor(context).onSurfaceVariant,
                    fontSize: 14 * Responsive.getResponsive(context),
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    '*',
                    color: AppColors.red,
                    fontSize: 14 * Responsive.getResponsive(context),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),
              // TODO: have to make this dynamic based on country right now its static
              PhoneNumberField(
                selectedCountry: 'IND', // Default country
                countries: const [
                  'IND',
                  'USA',
                  'GB',
                  'UAE',
                ], // Extend as needed
                countryDialCodes: const {
                  'IND': '+91',
                  'USA': '+1',
                  'GB': '+44',
                  'AUS': '+61',
                  'UAE': '+971',
                },
                phoneController: _mobileController,
                onCountryChanged: (countryCode, dialCode) {
                  debugPrint('Country changed: $countryCode ($dialCode)');
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Contact Person Mobile is required';
                  }
                  if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                    return 'Enter a valid mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),

              _buildTextField(_companyController, 'comapany_name', true),
              _buildTextField(
                _employeesController,
                'no_of_employees',
                true,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                _emailController,
                'contact_person_email',
                false,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                _addressController,
                'Address',
                false,
                maxLines: 3,
              ),
              SizedBox(height: 0.005 * Responsive.getHeight(context)),

              MyCoButton(
                onTap: () {
                  final RequestSociety requestSociety = RequestSociety(
                    personName: _nameController.text.trim(),
                    personEmail: _emailController.text.trim(),
                    personMobile: _mobileController.text.trim(),
                    countryCode:
                        '+91', //TODO: You can change this to the selected country code
                    address: _addressController.text.trim(),
                    appVersionCode: '1.0.0', //TODO: Replace with actual version
                    companyName: _companyController.text.trim(),
                    noOfEmployees: _employeesController.text.trim(),
                  );
                  if (_formKey.currentState!.validate()) {
                    bloc.add(FormSubmitted(requestSociety));
                  }
                },
                // Use the same function
                title: 'Submit',
                width: Responsive.getWidth(context),
                height: 0.065 * Responsive.getHeight(context),
                boarderRadius: 30,
                textStyle: TextStyle(
                  fontSize: 18 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color: AppTheme.getColor(context).onPrimary,
                ),
                backgroundColor: AppTheme.getColor(context).primary,
                isShadowBottomLeft: true,
              ),
              SizedBox(height: 0.02 * Responsive.getHeight(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool isRequired, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    Function(String)? onChanged,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12, top: 10),
    child: NewTextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChange: onChanged,
      validator: isRequired
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '${LanguageManager().get(label)} is required';
              }
              return null;
            }
          : null,
      label: label,
      isRequired: isRequired,
      hintText: 'type here',
    ),
  );
}
