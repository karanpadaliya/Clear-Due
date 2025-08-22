import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_state.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/takeover_asset/takeover_asset_state.dart';
import 'package:myco_flutter/features/asset/presentation/text_controllers/takeover_assets_controllers.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/assets_label_text_field.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/payslip/presentation/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_loader_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_radio_button.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

class TakeoverAssets extends StatefulWidget {
  final String? assetId;
  const TakeoverAssets({super.key, this.assetId});

  @override
  State<TakeoverAssets> createState() => _TakeoverAssetsState();
}

class _TakeoverAssetsState extends State<TakeoverAssets> {
  final _formKey = GlobalKey<FormState>();

  final _takeoverDateFieldKey = GlobalKey<FormFieldState<String>>();
  final _takeoverRemarkFieldKey = GlobalKey<FormFieldState<String>>();
  final _handoverDateFieldKey = GlobalKey<FormFieldState<String>>();
  final _branchFieldKey = GlobalKey<FormFieldState<String>>();
  final _departmentFieldKey = GlobalKey<FormFieldState<String>>();
  final _custodianFieldKey = GlobalKey<FormFieldState<String>>();
  final _conditionFieldKey = GlobalKey<FormFieldState<String>>();
  final _handoverRemarkFieldKey = GlobalKey<FormFieldState<String>>();

  final TakeoverAssetsControllers takeoverController =
      TakeoverAssetsControllers();

  List<Map<String, String>> branchDataList = [];
  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final bloc = context.read<CommonApiBloc>();
    final custodianBloc = context.read<CustodianUserBloc>();
    final handoverBloc = context.read<TakeoverAssetBloc>();

    return Scaffold(
      appBar: const CustomAppbar(
        title: 'takeover_assets',
        isKey: true,
        titleSpacing: 0,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CommonApiBloc, CommonApiState>(
            listener: (context, state) {
              if (state is CommonApiLoading) {
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
              if (state is CustodianUserLoading) {
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        VariableBag.screenHorizontalPadding *
                        Responsive.getResponsive(context),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AssetsLabelTextFieldWidget(
                          formFieldKey: _takeoverDateFieldKey,
                          isRequired: true,
                          label: 'takeover_date',
                          hintText: 'select',
                          image: AppAssets.imageNoteFavorite,
                          controller: takeoverController.takeoverDateController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Handover remark is required';
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
                              log(name: 'date', date.toString());
                              takeoverController.takeoverDateController.text =
                                  date.toString();
                            }
                          },
                        ),
                        AssetsLabelTextFieldWidget(
                          formFieldKey: _takeoverRemarkFieldKey,
                          label: 'takeover_remark',
                          isRequired: true,
                          hintText: 'type_here',
                          image: AppAssets.assetMessageEdit,

                          controller:
                              takeoverController.takeoverRemarkController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Handover remark is required';
                            }
                            return null;
                          },
                        ),

                        CustomMediaPickerContainer(
                          title: 'takeover_assets_image',
                          imagePath: '',
                          imageTitle: 'attach_Image',
                          multipleImage: 5,
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
                          containerHeight: 0.1 * Responsive.getHeight(context),
                        ),
                        SizedBox(
                          height:
                              VariableBag.formContentSpacingVertical *
                              Responsive.getResponsive(context),
                        ),

                        Row(
                          children: [
                            CustomText(
                              'handover_asset_to_other_employee',
                              color: AppTheme.getColor(
                                context,
                              ).onSurfaceVariant,
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w700,
                            ),
                            CustomText(
                              '*',
                              color: AppColors.red,
                              fontSize:
                                  14 * Responsive.getResponsiveText(context),
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.005 * Responsive.getHeight(context)),

                        SizedBox(height: 0.004 * Responsive.getHeight(context)),
                        BlocBuilder<TakeoverAssetBloc, TakeoverAssetState>(
                          builder: (context, state) => Row(
                            children: [
                              Expanded(
                                child: CustomTextRadioButton(
                                  gender: 'YES',
                                  selectedGender:
                                      takeoverController.handoverSelected,
                                  onSelect: (value) {
                                    takeoverController.handoverSelected = value;
                                    handoverBloc.add(
                                      HandoverToOtherEmployeeEvent(
                                        toOtherEmployeee: value == 'YES'
                                            ? true
                                            : false,
                                      ),
                                    );
                                  },
                                  height: 0.055 * Responsive.getHeight(context),
                                  width: 0.45 * Responsive.getWidth(context),
                                  textStyle: TextStyle(
                                    fontFamily: 'Gilroy-semiBold',
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.getColor(
                                      context,
                                    ).onSurfaceVariant,
                                  ),
                                  customDecoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.getColor(context).outline,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10 * Responsive.getResponsive(context),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0.05 * Responsive.getWidth(context),
                              ),
                              Expanded(
                                child: CustomTextRadioButton(
                                  gender: 'NO',
                                  selectedGender:
                                      takeoverController.handoverSelected,
                                  onSelect: (value) {
                                    takeoverController.handoverSelected = value;
                                    handoverBloc.add(
                                      HandoverToOtherEmployeeEvent(
                                        toOtherEmployeee: value == 'YES'
                                            ? true
                                            : false,
                                      ),
                                    );
                                  },
                                  height: 0.055 * Responsive.getHeight(context),
                                  width: 0.45 * Responsive.getWidth(context),
                                  textStyle: TextStyle(
                                    fontFamily: 'Gilroy-semiBold',
                                    fontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.getColor(
                                      context,
                                    ).onSurfaceVariant,
                                  ),
                                  customDecoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppTheme.getColor(context).outline,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      10 * Responsive.getResponsive(context),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        BlocBuilder<TakeoverAssetBloc, TakeoverAssetState>(
                          builder: (context, state) {
                            if (state is TakeoverAssetApiSuccess &&
                                state.toOtherEmployee == true) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        0.02 * Responsive.getHeight(context),
                                  ),

                                  AssetsLabelTextFieldWidget(
                                    formFieldKey: _handoverDateFieldKey,
                                    isRequired: true,
                                    label: 'handover_date',
                                    hintText: 'select',
                                    image: AppAssets.imageNoteFavorite,
                                    controller: takeoverController
                                        .handoverDateController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Handover remark is required';
                                      }
                                      return null;
                                    },
                                  ),

                                  BlocBuilder<CommonApiBloc, CommonApiState>(
                                    builder: (context, state) {
                                      // log(name: ' ----- Branch ---------', state.toString());

                                      if (state is BlockApiSuccess) {
                                        branchDataList =
                                            state.blockList.blocks != null
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
                                        label: 'Branch',
                                        isRequired: true,
                                        hintText: 'Select',
                                        image: AppAssets.assetsData,
                                        controller:
                                            takeoverController.branchController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Branch is required';
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          if (branchDataList.isEmpty) return;

                                          final matchedBranch = branchDataList
                                              .firstWhere(
                                                (element) =>
                                                    element['name'] ==
                                                    takeoverController
                                                        .branchController
                                                        .text,
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
                                          bloc.add(
                                            LoadDepartmentAndDesignation(
                                              '1',
                                              selected['id'],
                                            ),
                                          );
                                          takeoverController
                                              .departmentController
                                              .clear();
                                          takeoverController.custodianController
                                              .clear();
                                          takeoverController
                                                  .branchController
                                                  .text =
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
                                      List<Map<String, String>>
                                      departmentDataList = [];
                                      if (state is FloorUnitApiSuccess) {
                                        departmentDataList =
                                            state.response.departments != null
                                            ? state.response.departments!
                                                  .map(
                                                    (e) => {
                                                      'id':
                                                          e.departmentId ?? '',
                                                      'name':
                                                          e.departmentName ??
                                                          '',
                                                      'blockId':
                                                          e.blockId ?? '',
                                                    },
                                                  )
                                                  .toList()
                                            : [];
                                      }

                                      return AssetsLabelTextFieldWidget(
                                        formFieldKey: _departmentFieldKey,
                                        label: 'departement',
                                        isRequired: true,
                                        hintText: 'select',
                                        image: AppAssets.imageNoteFavorite,
                                        controller: takeoverController
                                            .departmentController,
                                        validator: (value) {
                                          if (takeoverController
                                              .departmentController
                                              .text
                                              .isEmpty) {
                                            return 'Select branch';
                                          }
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Department is required';
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          if (takeoverController
                                              .branchController
                                              .text
                                              .isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: 'Select Branch',
                                            );
                                          }
                                          if (departmentDataList.isEmpty)
                                            return;
                                          final matchedDepartment =
                                              departmentDataList.firstWhere(
                                                (element) =>
                                                    element['name'] ==
                                                    takeoverController
                                                        .departmentController
                                                        .text,
                                                orElse: () => {},
                                              );

                                          final selected =
                                              await showCustomSimpleBottomSheet(
                                                context: context,
                                                dataList: departmentDataList,
                                                heading: 'Department',
                                                selectedId:
                                                    matchedDepartment['id'],
                                              );

                                          if (selected == null) return;
                                          // log(
                                          //   name: '---------- selected Branch --------',
                                          //   selected.toString(),
                                          // );
                                          takeoverController
                                                  .selectedDepartmentId =
                                              selected['id'];
                                          takeoverController
                                                  .departmentController
                                                  .text =
                                              selected['name'];

                                          custodianBloc.add(
                                            FetchCustodianUser(
                                              blockId:
                                                  selected['blockId'] ?? '',
                                              floorId: selected['id'] ?? '',
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  BlocBuilder<
                                    CustodianUserBloc,
                                    CustodianUserState
                                  >(
                                    builder: (context, state) {
                                      // log(name: ' ----- Cutodian ---------', state.toString());

                                      // Safely extract the list from state
                                      List<Map<String, String>> userDataList =
                                          [];
                                      if (state is CustodianUserApiSuccess) {
                                        userDataList =
                                            state.userEntity.employees != null
                                            ? state.userEntity.employees!
                                                  .map(
                                                    (e) => {
                                                      'id': e.userId ?? '',
                                                      'name':
                                                          e.userFullName ?? '',
                                                    },
                                                  )
                                                  .toList()
                                            : [];
                                      }

                                      return AssetsLabelTextFieldWidget(
                                        formFieldKey: _custodianFieldKey,
                                        label: 'custodian',
                                        isRequired: true,
                                        hintText: 'select',
                                        image: AppAssets.assetsUserTick,
                                        controller: takeoverController
                                            .custodianController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Custodian is required';
                                          }
                                          return null;
                                        },
                                        onTap: () async {
                                          if (takeoverController
                                              .branchController
                                              .text
                                              .isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: 'Select Branch',
                                            );
                                          } else if (takeoverController
                                              .departmentController
                                              .text
                                              .isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: 'Select Department',
                                            );
                                          }
                                          if (userDataList.isEmpty) return;
                                          final matchedUser = userDataList
                                              .firstWhere(
                                                (element) =>
                                                    element['name'] ==
                                                    takeoverController
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
                                          takeoverController.handoverUserId =
                                              selected['id'];
                                          takeoverController
                                                  .custodianController
                                                  .text =
                                              selected['name'];
                                        },
                                      );
                                    },
                                  ),

                                  AssetsLabelTextFieldWidget(
                                    formFieldKey: _conditionFieldKey,
                                    label: 'condition_type',
                                    isRequired: true,
                                    hintText: 'types',
                                    suffix: Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppTheme.getColor(context).primary,
                                    ),
                                    image: AppAssets.assetsElementEqual,
                                    controller: takeoverController
                                        .conditionTypeController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Condition type is required';
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      final List<Map<String, String>>
                                      conditionList = [
                                        {'id': '0', 'name': 'Old'},
                                        {'id': '1', 'name': 'New'},
                                      ];
                                      final selected =
                                          await showCustomSimpleBottomSheet(
                                            context: context,
                                            dataList: conditionList,
                                            heading: 'User List',
                                            // selectedId: matchedUser['id'],
                                          );

                                      if (selected != null) {
                                        takeoverController
                                                .conditionTypeController
                                                .text =
                                            selected['name'];
                                      }
                                    },
                                  ),

                                  AssetsLabelTextFieldWidget(
                                    formFieldKey: _handoverRemarkFieldKey,
                                    isRequired: true,
                                    label: 'handover_remark',
                                    hintText: 'type_here',
                                    image: AppAssets.assetMessageEdit,

                                    controller: takeoverController
                                        .handoverRemarkController,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Handover remark is required';
                                      }
                                      return null;
                                    },
                                  ),

                                  CustomMediaPickerContainer(
                                    title: 'assets_image',
                                    imagePath: '',
                                    imageTitle: 'attach_Image',
                                    multipleImage: 1,
                                    isCameraShow: true,
                                    isGalleryShow: true,
                                    titleColor: AppTheme.getColor(
                                      context,
                                    ).onSurfaceVariant,
                                    titleFontSize:
                                        14 *
                                        Responsive.getResponsiveText(context),
                                    imageTitleSize:
                                        16 *
                                        Responsive.getResponsiveText(context),
                                    imageTitleColor: AppTheme.getColor(
                                      context,
                                    ).onSurfaceVariant,
                                    backgroundColor: const Color(0xFFEEF7FD),
                                    containerHeight:
                                        0.1 * Responsive.getHeight(context),
                                  ),
                                  SizedBox(
                                    height:
                                        0.01 * Responsive.getHeight(context),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height:
                  VariableBag.formContentSpacingVertical *
                  Responsive.getResponsive(context),
            ),

            //Submit button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    VariableBag.screenHorizontalPadding *
                    Responsive.getResponsive(context),
              ),
              child: BlocBuilder<TakeoverAssetBloc, TakeoverAssetState>(
                builder: (context, state) => MyCoButton(
                  onTap: () {
                    bool isValid = true;

                    if (!_takeoverDateFieldKey.currentState!.validate()) {
                      isValid = false;
                    } else if (!_takeoverRemarkFieldKey.currentState!
                        .validate()) {
                      isValid = false;
                    } else if (takeoverController.handoverSelected.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Select handover asset to other employee',
                      );
                      isValid = false;
                    }
                    if (state is TakeoverAssetApiSuccess) {
                      if (state.toOtherEmployee == true) {
                        if (!_handoverDateFieldKey.currentState!.validate()) {
                          isValid = false;
                        } else if (!_branchFieldKey.currentState!.validate()) {
                          isValid = false;
                        } else if (!_departmentFieldKey.currentState!
                            .validate()) {
                          isValid = false;
                        } else if (!_custodianFieldKey.currentState!
                            .validate()) {
                          isValid = false;
                        } else if (!_conditionFieldKey.currentState!
                            .validate()) {
                          isValid = false;
                        } else if (!_handoverRemarkFieldKey.currentState!
                            .validate()) {
                          isValid = false;
                        }
                      }
                    }

                    if (!isValid) return;

                    // ✅ All validations passed → proceed with submission
                    log(
                      name: '--------- Submit Handover asset from ------------',
                      '''
                    'handoverAsset': 'handoverAsset',
                    'languageId': '',
                    'userId': '',
                    'societyId': '',
                    'userName': '',
                    'assetsId': ${widget.assetId},
                    "takeoverDate":${takeoverController.takeoverDateController.text},
                    "takeoverRemark": ${takeoverController.takeoverRemarkController.text},
                    "inventoryId": "your_inventory_id",
                    "takeoverUserId": '',
                    'otherUserName': ${takeoverController.custodianController.text},
                    "takeoverImage": "your_takeover_image_base64_or_url",
                    'handoverUserId':  ${takeoverController.handoverUserId},
                    "handoverAssets": '',
                    'floorId':  ${takeoverController.selectedDepartmentId},
                    'handoverDate':  ${takeoverController.handoverDateController.text},
                    'conditionType':  ${takeoverController.conditionTypeController.text},
                    "handoverRemark":${takeoverController.custodianController.text},
                    "handoverImage": "your_handover_image_base64_or_url"
                    ''',
                    );
                  },

                  title: 'Submit',
                  isShadowBottomLeft: true,
                  boarderRadius: 50,
                  fontFamily: 'Gilroy-Bold',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height:
                  VariableBag.formContentSpacingVertical *
                  Responsive.getResponsive(context),
            ),
          ],
        ),
      ),
    );
  }
}
