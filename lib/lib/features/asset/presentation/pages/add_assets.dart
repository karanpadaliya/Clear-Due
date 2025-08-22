import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/domain/entities/add_asset_entity.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/add_asset/add_asset_state.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_state.dart';
import 'package:myco_flutter/features/asset/presentation/text_controllers/add_assets_controllers.dart';
import 'package:myco_flutter/features/asset/presentation/utils/asset_enum.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/assets_label_text_field.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_loader_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class AddAssets extends StatefulWidget {
  const AddAssets({super.key});

  @override
  State<AddAssets> createState() => _AddAssets();
}

class _AddAssets extends State<AddAssets> {
  final AddAssetsControllers addAssetsControllers = AddAssetsControllers();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> purchaseDateKey =
      GlobalKey<FormFieldState<String>>();

  final _branchFieldKey = GlobalKey<FormFieldState<String>>();
  final _departmentFieldKey = GlobalKey<FormFieldState<String>>();
  final _custodianFieldKey = GlobalKey<FormFieldState<String>>();

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

  List<Map<String, String>> categoryDataList = [];
  List<Map<String, String>> branchDataList = [];
  bool _isLoaderVisible = false;
  bool _isCategorySelectionState = false;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final branchBloc = context.read<CommonApiBloc>();
    final custodianBloc = context.read<CustodianUserBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AddAssetBloc, AddAssetState>(
          listener: (context, state) {
            if (state is AddAssetLoading) {
              _isLoaderVisible = true;
              _isCategorySelectionState = true; // reset
              CustomLoaderDialog.show(context);
            } else if (_isLoaderVisible &&
                (state is AddAssetLoaded ||
                    state is AddAssetCategorySelected ||
                    state is AddAssetError)) {
              _isLoaderVisible = false;
              _isCategorySelectionState = false;
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          },
        ),
        BlocListener<CommonApiBloc, CommonApiState>(
          listener: (context, state) {
            if (_isCategorySelectionState && state is CommonApiLoading) {
              _isLoaderVisible = true;
              CustomLoaderDialog.show(context);
            } else if (_isLoaderVisible) {
              _isLoaderVisible = false;
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          },
        ),
        BlocListener<CustodianUserBloc, CustodianUserState>(
          listener: (context, state) {
            if (_isCategorySelectionState && state is CustodianUserLoading) {
              _isLoaderVisible = true;
              CustomLoaderDialog.show(context);
            } else if (_isLoaderVisible) {
              _isLoaderVisible = false;
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          },
        ),
      ],
      child: Scaffold(
        // backgroundColor: const Color(0xFFF6F7FB),
        appBar: const CustomAppbar(
          title: 'add_assets',
          titleSpacing: 0,
          isKey: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  VariableBag.screenHorizontalPadding *
                  Responsive.getResponsive(context),
            ),
            child: BlocBuilder<AddAssetBloc, AddAssetState>(
              builder: (context, state) {
                final bloc = context.read<AddAssetBloc>();

                final currentError = state.currentFieldErrorKey;
                final selectedCategory = state is AddAssetCategorySelected
                    ? state.selectedCategory
                    : null;

                // log(name: 'category select', selectedCategory.toString());

                if ((state is AddAssetLoaded) &&
                    state.addAssetEntity.categoryList != null) {
                  categoryDataList = state.addAssetEntity.categoryList != null
                      ? state.addAssetEntity.categoryList!
                            .map(
                              (e) => {
                                'id': e.assetsCategoryId ?? '',
                                'name': e.assetsCategory ?? '',
                              },
                            )
                            .toList()
                      : [];

                  branchDataList = state.addAssetEntity.branchList != null
                      ? state.addAssetEntity.branchList!
                            .map(
                              (e) => {
                                'id': e.blockId ?? '',
                                'name': e.blockName ?? '',
                              },
                            )
                            .toList()
                      : [];

                  // log(name: 'user list', userDataList.toString());
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AssetsLabelTextFieldWidget(
                        label: 'assets_category',
                        hintText: 'select',
                        isRequired: true,
                        image: AppAssets.assetsElement,
                        controller: addAssetsControllers.categoryController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.category &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Assets category is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          // Ensure we have categories to display
                          if (categoryDataList.isEmpty) {
                            Fluttertoast.showToast(
                              msg: 'No categories available',
                            );
                            return;
                          }

                          final matchedCategoryData = categoryDataList
                              .firstWhere(
                                (category) =>
                                    category['name'] ==
                                    addAssetsControllers
                                        .categoryController
                                        .text,
                                orElse: () => {},
                              );

                          // Show bottom sheet and await selection
                          final selected = await showCustomSimpleBottomSheet(
                            context: context,
                            dataList: categoryDataList,
                            heading: 'Category',
                            selectedId: matchedCategoryData['id'],
                          );
                          if (selected == null) return;

                          // Compute matchedCategory from whichever AddAssetState is current
                          CategoryEntity? matchedCategory;
                          if (state is AddAssetLoaded) {
                            matchedCategory = state.addAssetEntity.categoryList
                                ?.firstWhere(
                                  (e) => e.assetsCategoryId == selected['id'],
                                );
                          } else if (state is AddAssetCategorySelected) {
                            matchedCategory = state.addAssetEntity.categoryList
                                ?.firstWhere(
                                  (e) => e.assetsCategoryId == selected['id'],
                                );
                          }

                          if (matchedCategory != null) {
                            bloc.add(SelectAssetCategoryEvent(matchedCategory));
                            addAssetsControllers.categoryController.text =
                                selected['name'];
                          }
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'item_name',
                        hintText: 'type_name',
                        isRequired: true,
                        image: AppAssets.assetsShoppingBag,
                        controller: addAssetsControllers.itemNameController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.itemName &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Item name is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'brand_name',
                        hintText: 'type_here',
                        isRequired:
                            selectedCategory?.brandNameRequired ?? false,
                        image: AppAssets.assetsGroup,
                        controller: addAssetsControllers.brandNameController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.brandName &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Branch name is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'location',
                        hintText: 'type_here',
                        isRequired: selectedCategory?.locationRequired ?? false,
                        image: AppAssets.location,
                        controller: addAssetsControllers.locationController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.location &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'item_code',
                        hintText: 'select_section',
                        isRequired: selectedCategory?.itemCodeRequired ?? false,
                        image: AppAssets.assetsPasswordCheck,
                        controller: addAssetsControllers.itemCodeController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.itemCode &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Item code is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'description',
                        hintText: 'type_here',
                        isRequired:
                            selectedCategory?.descriptionRequired ?? false,
                        image: AppAssets.assetsStickyNote,
                        controller: addAssetsControllers.descriptionController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.description &&
                              (value == null || value.trim().isEmpty)) {
                            return ' is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        formFieldKey: purchaseDateKey,
                        label: 'purchase_date',
                        hintText: 'select',
                        isRequired:
                            selectedCategory?.purchaseDateRequired ?? false,
                        image: AppAssets.imageNoteFavorite,
                        controller: addAssetsControllers.purchaseDateController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.purchaseDate &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Purchase date is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          final date = await showPicker(
                            context,
                            pickDay: true,
                            timePicker: false,
                          );
                          if (date != null) {
                            // log(name: 'date', date.toString());
                            addAssetsControllers.purchaseDateController.text =
                                date.toString();
                          }
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'sr_no',
                        hintText: 'type_here',
                        isRequired: selectedCategory?.snoRequiredBool ?? false,

                        image: AppAssets.assetsSimCard,
                        controller: addAssetsControllers.simController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.sno &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Sr.No. is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'price',
                        hintText: 'type_here',
                        isRequired: selectedCategory?.priceRequired ?? false,
                        image: AppAssets.assetsDollar,
                        controller: addAssetsControllers.priceController,
                        validator: (value) {
                          if (currentError == AddAssetFieldKey.price &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Price is required';
                          }
                          return null;
                        },
                      ),
                      AssetsLabelTextFieldWidget(
                        label: 'credential',
                        hintText: 'type_here',
                        image: AppAssets.assetsData,
                        isRequired:
                            selectedCategory?.assetCredentialRequired ?? false,

                        controller: addAssetsControllers.credentialController,
                        validator: (value) {
                          if (currentError ==
                                  AddAssetFieldKey.assetCredential &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Credential is required';
                          }
                          return null;
                        },
                      ),

                      BlocBuilder<CommonApiBloc, CommonApiState>(
                        builder: (context, state) {
                          // log(name: ' ----- Branch ---------', state.toString());

                          if (state is BlockApiSuccess) {
                            branchDataList = state.blockList.blocks != null
                                ? state.blockList.blocks!
                                      .map(
                                        (e) => {
                                          'id': e.blockId ?? '',
                                          'name': e.blockName ?? '',
                                        },
                                      )
                                      .toList()
                                : [];
                          }

                          return AssetsLabelTextFieldWidget(
                            formFieldKey: _branchFieldKey,
                            label: 'branch',
                            hintText: 'select',
                            isRequired:
                                selectedCategory?.brandNameRequired ?? false,
                            image: AppAssets.assetsData,
                            controller: addAssetsControllers.branchController,
                            validator: (value) {
                              if (currentError == AddAssetFieldKey.branch &&
                                  (value == null || value.trim().isEmpty)) {
                                return 'Branch is required';
                              }
                              return null;
                            },
                            onTap: () async {
                              if (branchDataList.isEmpty) return;

                              final matchedBranch = branchDataList.firstWhere(
                                (element) =>
                                    element['name'] ==
                                    addAssetsControllers.branchController.text,
                                orElse: () => {},
                              );

                              final selected =
                                  await showCustomSimpleBottomSheet(
                                    context: context,
                                    dataList: branchDataList,
                                    heading: 'Branches',
                                    selectedId: matchedBranch['id'],
                                  );

                              if (selected == null) return;
                              branchBloc.add(
                                LoadDepartmentAndDesignation(
                                  '1',
                                  selected['id'],
                                ),
                              );
                              addAssetsControllers.departmentController.clear();
                              addAssetsControllers.custodianController.clear();
                              addAssetsControllers.branchController.text =
                                  selected['name'];
                            },
                          );
                        },
                      ),
                      BlocBuilder<CommonApiBloc, CommonApiState>(
                        builder: (context, state) {
                          // log(
                          //   name: ' ----- Departmant ---------',
                          //   state.toString(),
                          // );

                          // Safely extract the list from state
                          List<Map<String, String>> departmentDataList = [];
                          if (state is FloorUnitApiSuccess) {
                            departmentDataList =
                                state.response.departments != null
                                ? state.response.departments!
                                      .map(
                                        (e) => {
                                          'id': e.departmentId ?? '',
                                          'name': e.departmentName ?? '',
                                          'blockId': e.blockId ?? '',
                                        },
                                      )
                                      .toList()
                                : [];
                          }

                          return AssetsLabelTextFieldWidget(
                            formFieldKey: _departmentFieldKey,
                            label: 'departement',
                            hintText: 'select',
                            isRequired:
                                selectedCategory?.descriptionRequired ?? false,

                            image: AppAssets.imageNoteFavorite,
                            controller:
                                addAssetsControllers.departmentController,
                            validator: (value) {
                              if (addAssetsControllers
                                  .departmentController
                                  .text
                                  .isEmpty) {
                                return 'Select branch';
                              }
                              if (currentError == AddAssetFieldKey.department &&
                                  (value == null || value.trim().isEmpty)) {
                                return 'Department is required';
                              }
                              return null;
                            },
                            onTap: () async {
                              if (addAssetsControllers
                                  .branchController
                                  .text
                                  .isEmpty) {
                                Fluttertoast.showToast(msg: 'Select Branch');
                              }
                              if (departmentDataList.isEmpty) return;
                              final matchedDepartment = departmentDataList
                                  .firstWhere(
                                    (element) =>
                                        element['name'] ==
                                        addAssetsControllers
                                            .departmentController
                                            .text,
                                    orElse: () => {},
                                  );

                              final selected =
                                  await showCustomSimpleBottomSheet(
                                    context: context,
                                    dataList: departmentDataList,
                                    heading: 'Department',
                                    selectedId: matchedDepartment['id'],
                                  );

                              if (selected == null) return;
                              // log(
                              //   name: '---------- selected Branch --------',
                              //   selected.toString(),
                              // );
                              addAssetsControllers.selectedDepartmentId =
                                  selected['id'];
                              addAssetsControllers.departmentController.text =
                                  selected['name'];

                              custodianBloc.add(
                                FetchCustodianUser(
                                  blockId: selected['blockId'] ?? '',
                                  floorId: selected['id'] ?? '',
                                ),
                              );
                            },
                          );
                        },
                      ),
                      BlocBuilder<CustodianUserBloc, CustodianUserState>(
                        builder: (context, state) {
                          // log(name: ' ----- Cutodian ---------', state.toString());

                          // Safely extract the list from state
                          List<Map<String, String>> userDataList = [];
                          if (state is CustodianUserApiSuccess) {
                            userDataList = state.userEntity.employees != null
                                ? state.userEntity.employees!
                                      .map(
                                        (e) => {
                                          'id': e.userId ?? '',
                                          'name': e.userFullName ?? '',
                                        },
                                      )
                                      .toList()
                                : [];
                          }

                          return AssetsLabelTextFieldWidget(
                            formFieldKey: _custodianFieldKey,
                            label: 'custodian',
                            hintText: 'select',
                            isRequired:
                                selectedCategory?.custodianRequired ?? false,
                            image: AppAssets.assetsUserTick,
                            controller:
                                addAssetsControllers.custodianController,
                            validator: (value) {
                              if (currentError == AddAssetFieldKey.custodian &&
                                  (value == null || value.trim().isEmpty)) {
                                return 'Custodian is required';
                              }
                              return null;
                            },
                            onTap: () async {
                              if (addAssetsControllers
                                  .branchController
                                  .text
                                  .isEmpty) {
                                Fluttertoast.showToast(msg: 'Select Branch');
                              } else if (addAssetsControllers
                                  .departmentController
                                  .text
                                  .isEmpty) {
                                Fluttertoast.showToast(
                                  msg: 'Select Department',
                                );
                              }
                              if (userDataList.isEmpty) return;
                              final matchedUser = userDataList.firstWhere(
                                (element) =>
                                    element['name'] ==
                                    addAssetsControllers
                                        .custodianController
                                        .text,
                                orElse: () => {},
                              );

                              final selected =
                                  await showCustomSimpleBottomSheet(
                                    context: context,
                                    dataList: userDataList,
                                    heading: 'Department',
                                    selectedId: matchedUser['id'],
                                  );

                              if (selected == null) return;
                              addAssetsControllers.handoverUserId =
                                  selected['id'];
                              addAssetsControllers.custodianController.text =
                                  selected['name'];
                            },
                          );
                        },
                      ),

                      AssetsLabelTextFieldWidget(
                        label: 'handover_date',
                        hintText: 'select',
                        image: AppAssets.imageNoteFavorite,
                        controller: addAssetsControllers.handoverDateController,
                        onTap: () async {
                          final date = await showPicker(
                            context,
                            pickDay: true,
                            timePicker: false,
                          );
                          if (date != null) {
                            // log(name: 'date', date.toString());
                            addAssetsControllers.handoverDateController.text =
                                date.toString();
                          }
                        },
                      ),

                      // -- Assets Image --
                      BlocBuilder<CommonApiBloc, CommonApiState>(
                        builder: (context, state) {
                          if (state is UploadImagePdfApiSuccess) {
                            log(
                              name: 'common state',
                              state.imgPdfList.baseUrl.toString() +
                                  state.imgPdfList.imgNameArr!.first.toString(),
                            );
                            addAssetsControllers.assetImage = [
                              state.imgPdfList.baseUrl.toString() +
                                  state.imgPdfList.imgNameArr!.first.toString(),
                            ];
                          }
                          return CustomMediaPickerContainer(
                            imagePath: '',
                            imageTitle: 'assets_image',
                            multipleImage: 1,
                            title: 'assets_image',
                            titleIsKey: true,
                            isCameraShow: true,
                            isGalleryShow: true,
                            titleColor: AppTheme.getColor(
                              context,
                            ).onSurfaceVariant,
                            titleFontSize:
                                14 * Responsive.getResponsiveText(context),
                            imageTitleSize:
                                16 * Responsive.getResponsiveText(context),
                            imageTitleColor: AppTheme.getColor(
                              context,
                            ).onSurfaceVariant,
                            backgroundColor: const Color(0xFFEEF7FD),
                            imageTitleIsKey: true,
                            containerHeight:
                                0.1 * Responsive.getHeight(context),
                            onSelectedMedia: (files) {
                              if (files.isNotEmpty) {
                                log(files.first.path.toString());
                                AssetUtils().fetchImageDataApi(context, [
                                  files.first.path.toString(),
                                ]);
                              } else {
                                addAssetsControllers.assetImage.clear();
                              }
                            },
                          );
                        },
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
                        titleIsKey: true,
                        imageTitleIsKey: true,
                        isGalleryShow: true,
                        titleColor: AppTheme.getColor(context).onSurfaceVariant,
                        titleFontSize:
                            14 * Responsive.getResponsiveText(context),
                        imageTitleSize:
                            16 * Responsive.getResponsiveText(context),
                        imageTitleColor: AppTheme.getColor(
                          context,
                        ).onSurfaceVariant,
                        backgroundColor: const Color(0xFFEEF7FD),
                        containerHeight: 0.1 * Responsive.getHeight(context),
                        onSelectedMedia: (files) {
                          if (files.isEmpty) return;
                          final List<String> imgList = [files.first.path];
                          AssetUtils().fetchImageDataApi(context, imgList);
                        },
                      ),
                      SizedBox(
                        height:
                            VariableBag.formContentSpacingVertical *
                            Responsive.getResponsive(context),
                      ),

                      //Submit button
                      MyCoButton(
                        onTap: () => _validateFieldByField(selectedCategory),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _validateFieldByField(CategoryEntity? selectedCategory) {
    final fieldMap = <AddAssetFieldKey, TextEditingController>{
      AddAssetFieldKey.category: addAssetsControllers.categoryController,
      AddAssetFieldKey.itemName: addAssetsControllers.itemNameController,
      if (selectedCategory?.brandNameRequired == true)
        AddAssetFieldKey.brandName: addAssetsControllers.brandNameController,
      if (selectedCategory?.locationRequired == true)
        AddAssetFieldKey.location: addAssetsControllers.locationController,
      if (selectedCategory?.itemCodeRequired == true)
        AddAssetFieldKey.itemCode: addAssetsControllers.itemCodeController,
      if (selectedCategory?.descriptionRequired == true)
        AddAssetFieldKey.description:
            addAssetsControllers.descriptionController,
      if (selectedCategory?.purchaseDateRequired == true)
        AddAssetFieldKey.purchaseDate:
            addAssetsControllers.purchaseDateController,
      if (selectedCategory?.snoRequiredBool == true)
        AddAssetFieldKey.sno: addAssetsControllers.simController,
      if (selectedCategory?.priceRequired == true)
        AddAssetFieldKey.price: addAssetsControllers.priceController,
      if (selectedCategory?.assetCredentialRequired == true)
        AddAssetFieldKey.assetCredential:
            addAssetsControllers.credentialController,
      if (selectedCategory?.brandNameRequired == true)
        AddAssetFieldKey.branch: addAssetsControllers.branchController,
      AddAssetFieldKey.department: addAssetsControllers.departmentController,
      if (selectedCategory?.custodianRequired == true)
        AddAssetFieldKey.custodian: addAssetsControllers.custodianController,
    };

    final bloc = context.read<AddAssetBloc>();

    for (final entry in fieldMap.entries) {
      if (entry.value.text.trim().isEmpty) {
        bloc.add(SetFieldErrorIndexEvent(entry.key));
        // Delay validation to allow BlocBuilder to rebuild with new state
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _formKey.currentState!.validate();
        });
        return;
      }
    }

    bloc.add(const SetFieldErrorIndexEvent(null));
    log('All fields are valid. Proceed to submit.');
    log('''
        //---------------------------------------------//

        category : ${addAssetsControllers.categoryController.text} 
        item name : ${addAssetsControllers.itemNameController.text} 
        brand : ${addAssetsControllers.brandNameController.text} 
        location : ${addAssetsControllers.locationController.text} 
        item code : ${addAssetsControllers.itemCodeController.text} 
        descr : ${addAssetsControllers.descriptionController.text} 
        purchase : ${addAssetsControllers.purchaseDateController.text} 
        sim : ${addAssetsControllers.simController.text} 
        price : ${addAssetsControllers.priceController.text} 
        creadian : ${addAssetsControllers.credentialController.text} 
        branch : ${addAssetsControllers.branchController.text} 
        deparment : ${addAssetsControllers.departmentController.text} 
       custodian  : ${addAssetsControllers.custodianController.text} 
        hand : ${addAssetsControllers.handoverDateController.text} 


        Asset Image :  ${addAssetsControllers.assetImage}
        //---------------------------------------------//

        ''', name: 'BranchLogger');
  }
}
