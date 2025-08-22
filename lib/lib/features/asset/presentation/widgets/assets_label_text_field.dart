import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class AssetsLabelTextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final String image;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool? isRequired;
  final FocusNode? focusNode;
  final GlobalKey<FormFieldState<dynamic>>? formFieldKey;
  final Widget? suffix;
  const AssetsLabelTextFieldWidget({
    required this.label,
    required this.image,
    required this.hintText,
    super.key,
    this.controller,
    this.validator,
    this.onTap,
    this.isRequired,
    this.focusNode,
    this.formFieldKey, this.suffix,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      NewTextField(
        // focusNode: focusNode,
        formFieldKey: formFieldKey,
        label: label,
        controller: controller,
        hintText: hintText,
        maxLines: 1,
        prefixIconPath: image,
        validator: validator,
        isRequired: isRequired ?? false,
        onTap: onTap,
        suffix: suffix,
      ),
      SizedBox(
        height:
            VariableBag.formContentSpacingVertical *
            Responsive.getResponsive(context),
      ),
    ],
  );
}
