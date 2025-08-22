import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/assets_label_text_field.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class SwapAssetsPage extends StatefulWidget {
  final String? assetsIdTwo;
  final String? handoverUserIdTwo;
  final String? assetsCategoryIdTwo;
  final String? floorIdTwo;
  final String? inventoryIdTwo;
  const SwapAssetsPage({
    super.key,
    this.assetsIdTwo,
    this.handoverUserIdTwo,
    this.assetsCategoryIdTwo,
    this.floorIdTwo,
    this.inventoryIdTwo,
  });

  @override
  State<SwapAssetsPage> createState() => _SwapAssetsPageState();
}

class _SwapAssetsPageState extends State<SwapAssetsPage> {
  final TextEditingController custodian1 = TextEditingController();
  final TextEditingController custodian2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 1. Create a GlobalKey for each FormField
  final _custodian1FieldKey = GlobalKey<FormFieldState<String>>();
  final _custodian2FieldKey = GlobalKey<FormFieldState<String>>();

  // Email regex
  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    final data = {
      'assetsIdTwo': widget.assetsIdTwo.toString(),
      'handoverUserIdTwo': widget.handoverUserIdTwo.toString(),
      'assetsCategoryIdTwo': widget.assetsCategoryIdTwo.toString(),
      'floorIdTwo': widget.floorIdTwo.toString(),
      'inventoryIdTwo': widget.inventoryIdTwo.toString(),
    };
    log(name: '------- Swap Page ---------------', data.toString());
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'swap_asset',
        isKey: true,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AssetsLabelTextFieldWidget(
                formFieldKey: _custodian1FieldKey,
                label: 'custodian',
                hintText: 'select',
                image: AppAssets.assetsUserTick,
                controller: custodian1,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Custodian is required';
                  }
                  if (value.trim().length < 6) {
                    return 'Must be at least 6 characters';
                  }

                  return null;
                },
              ),
              AssetsLabelTextFieldWidget(
                formFieldKey: _custodian2FieldKey,
                label: 'custodian',
                hintText: 'select',
                image: AppAssets.assetsElement,
                controller: custodian2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Custodian is required';
                  }
                  if (!_emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const Spacer(),
              //Submit button
              MyCoButton(
                onTap: () {
                  if (!_custodian1FieldKey.currentState!.validate()) {
                    // Field 1 has error: stop here
                    log("Custodian1 invalid");
                    return;
                  }
                  // 4. Only if Field 1 is valid, validate Field 2
                  else if (!_custodian2FieldKey.currentState!.validate()) {
                    log("Custodian2 invalid");
                    return;
                  }
                  // 5. Both fields passed validation: submit
                  log("Form is valid. Proceed with submission.");
                },
                title: 'Submit',
                isShadowBottomLeft: true,
                boarderRadius: 50,
                fontFamily: 'Gilroy-semiBold',
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height:
                    VariableBag.formContentSpacingVertical *
                    Responsive.getResponsive(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
