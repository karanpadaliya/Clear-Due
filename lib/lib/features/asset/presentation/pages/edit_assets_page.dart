import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/text_controllers/add_assets_controllers.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/assets_label_text_field.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class EditAssetsPage extends StatefulWidget {
  const EditAssetsPage({super.key});

  @override
  State<EditAssetsPage> createState() => _EditAssetsPage();
}

class _EditAssetsPage extends State<EditAssetsPage> {
  final AddAssetsControllers addAssetsControllers = AddAssetsControllers();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    addAssetsControllers.categoryController.dispose();
    addAssetsControllers.itemNameController.dispose();
    addAssetsControllers.brandNameController.dispose();
    addAssetsControllers.locationController.dispose();
    addAssetsControllers.itemCodeController.dispose();
    addAssetsControllers.descriptionController.dispose();
    addAssetsControllers.purchaseDateController.dispose();
    addAssetsControllers.simController.dispose();
    addAssetsControllers.priceController.dispose();
    addAssetsControllers.credentialController.dispose();
    addAssetsControllers.branchController.dispose();
    addAssetsControllers.departmentController.dispose();
    addAssetsControllers.custodianController.dispose();
    addAssetsControllers.handoverDateController.dispose();
    super.dispose();
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF6F7FB),
      appBar: const CustomAppbar(
        title: 'edit_asset',
        isKey: true,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AssetsLabelTextFieldWidget(
                  label: 'assets_category',
                  hintText: 'select',
                  image: AppAssets.assetsElement,
                  controller: addAssetsControllers.categoryController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Assets category is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'item_name',
                  hintText: 'type_name',
                  image: AppAssets.assetsShoppingBag,
                  controller: addAssetsControllers.itemNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Item name is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'brand_name',
                  hintText: 'type_here',
                  image: AppAssets.assetsGroup,
                  controller: addAssetsControllers.brandNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Branch name is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'location',
                  hintText: 'type_here',
                  image: AppAssets.location,
                  controller: addAssetsControllers.locationController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Location is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'item_code',
                  hintText: 'select_section',
                  image: AppAssets.assetsPasswordCheck,
                  controller: addAssetsControllers.itemCodeController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Item code is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'description',
                  hintText: 'type_here',
                  image: AppAssets.assetsStickyNote,
                  controller: addAssetsControllers.descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return ' is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'purchase_date',
                  hintText: 'select',
                  image: AppAssets.imageNoteFavorite,
                  controller: addAssetsControllers.purchaseDateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Purchase date is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'sr_no',
                  hintText: 'type_here',
                  image: AppAssets.assetsSimCard,
                  controller: addAssetsControllers.simController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Sr.No. is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'price',
                  hintText: 'type_here',
                  image: AppAssets.assetsDollar,
                  controller: addAssetsControllers.priceController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Price is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'credential',
                  hintText: 'type_here',
                  image: AppAssets.assetsData,
                  controller: addAssetsControllers.credentialController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Credential is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'branch',
                  hintText: 'select',
                  image: AppAssets.assetsData,
                  controller: addAssetsControllers.branchController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Branch is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'departement',
                  hintText: 'select',
                  image: AppAssets.imageNoteFavorite,
                  controller: addAssetsControllers.departmentController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Department is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'custodian',
                  hintText: 'select',
                  image: AppAssets.assetsUserTick,
                  controller: addAssetsControllers.custodianController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Custodian is required';
                    }
                    return null;
                  },
                ),
                AssetsLabelTextFieldWidget(
                  label: 'handover_date',
                  hintText: 'select',
                  image: AppAssets.imageNoteFavorite,
                  controller: addAssetsControllers.handoverDateController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Handover date is required';
                    }
                    return null;
                  },
                ),

                // -- Assets Image --
                CustomMediaPickerContainer(
                  imagePath: '',
                  imageTitle: 'assets_image',
                  multipleImage: 1,
                  title: 'assets_image',
                  isCameraShow: true,
                  isGalleryShow: true,
                  titleColor: AppTheme.getColor(context).onSurfaceVariant,
                  titleFontSize: 16 * Responsive.getResponsiveText(context),
                  imageTitleSize: 18 * Responsive.getResponsiveText(context),
                  imageTitleColor: AppTheme.getColor(context).onSurfaceVariant,
                  backgroundColor: const Color(0xFFEEF7FD),
                  containerHeight: 0.1 * Responsive.getHeight(context),
                ),
                SizedBox(
                  height:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                ),

                // -- Invoice --
                CustomMediaPickerContainer(
                  imagePath: '',
                  imageTitle: 'assets_image',
                  multipleImage: 1,
                  title: 'invoice',
                  isCameraShow: true,
                  isGalleryShow: true,
                  titleColor: AppTheme.getColor(context).onSurfaceVariant,
                  titleFontSize: 16 * Responsive.getResponsiveText(context),
                  imageTitleSize: 18 * Responsive.getResponsiveText(context),
                  imageTitleColor: AppTheme.getColor(context).onSurfaceVariant,
                  backgroundColor: const Color(0xFFEEF7FD),
                  containerHeight: 0.1 * Responsive.getHeight(context),
                ),
                SizedBox(
                  height:
                      VariableBag.formContentSpacingVertical *
                      Responsive.getResponsive(context),
                ),

                //Submit button
                MyCoButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid
                      log("Form is valid. Proceed with submission.");
                    } else {
                      log("Form is invalid. Show errors.");
                    }
                  },

                  title: 'Submit',
                  isShadowBottomLeft: true,
                  boarderRadius: 50,
                  fontFamily: 'Gilroy-Bold',
                  fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
