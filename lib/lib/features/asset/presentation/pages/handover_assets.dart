import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_bloc.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_event.dart';
import 'package:myco_flutter/features/asset/presentation/bloc/asset_custodian/asset_custodian_state.dart';
import 'package:myco_flutter/features/asset/presentation/text_controllers/handover_assets_controllers.dart';
import 'package:myco_flutter/features/asset/presentation/utils/asset_enum.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/assets_label_text_field.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_loader_dialog.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/ios_calendar_time_picker.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/custom_media_picker_container.dart';

// ignore: must_be_immutable
class HandoverAssetsPage extends StatelessWidget {
  final String? assetId;
  HandoverAssetsPage({super.key, this.assetId});

  final _formKey = GlobalKey<FormState>();

  final HandoverAssetsControllers handoverController =
      HandoverAssetsControllers();

  final _handoverFieldKey = GlobalKey<FormFieldState<String>>();
  final _branchFieldKey = GlobalKey<FormFieldState<String>>();
  final _departmentFieldKey = GlobalKey<FormFieldState<String>>();
  final _custodianFieldKey = GlobalKey<FormFieldState<String>>();
  final _conditionFieldKey = GlobalKey<FormFieldState<String>>();
  final _remarkFieldKey = GlobalKey<FormFieldState<String>>();

  List<Map<String, String>> branchDataList = [];

  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final bloc = context.read<CommonApiBloc>();
    final custodianBloc = context.read<CustodianUserBloc>();
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'handover_assets',
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AssetsLabelTextFieldWidget(
                    formFieldKey: _handoverFieldKey,
                    label: 'handover_date',
                    hintText: 'select',
                    isRequired: true,
                    image: AppAssets.imageNoteFavorite,
                    controller: handoverController.handoverDateController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Handover date is required';
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
                        handoverController.handoverDateController.text = date
                            .toString();
                      }
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
                        label: 'Branch',
                        isRequired: true,
                        hintText: 'Select',
                        image: AppAssets.assetsData,
                        controller: handoverController.branchController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Branch is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          if (branchDataList.isEmpty) return;

                          final matchedBranch = branchDataList.firstWhere(
                            (element) =>
                                element['name'] ==
                                handoverController.branchController.text,
                            orElse: () => {},
                          );

                          final selected = await showCustomSimpleBottomSheet(
                            context: context,
                            dataList: branchDataList,
                            heading: 'Branches',
                            selectedId: matchedBranch['id'],
                          );

                          if (selected == null) return;
                          bloc.add(
                            LoadDepartmentAndDesignation('1', selected['id']),
                          );
                          handoverController.departmentController.clear();
                          handoverController.custodianController.clear();
                          handoverController.branchController.text =
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
                        departmentDataList = state.response.departments != null
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
                        isRequired: true,
                        hintText: 'select',
                        image: AppAssets.imageNoteFavorite,
                        controller: handoverController.departmentController,
                        validator: (value) {
                          if (handoverController
                              .departmentController
                              .text
                              .isEmpty) {
                            return 'Select branch';
                          }
                          if (value == null || value.trim().isEmpty) {
                            return 'Department is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          if (handoverController
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
                                    handoverController
                                        .departmentController
                                        .text,
                                orElse: () => {},
                              );

                          final selected = await showCustomSimpleBottomSheet(
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
                          handoverController.selectedDepartmentId =
                              selected['id'];
                          handoverController.departmentController.text =
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
                        isRequired: true,
                        hintText: 'select',
                        image: AppAssets.assetsUserTick,
                        controller: handoverController.custodianController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Custodian is required';
                          }
                          return null;
                        },
                        onTap: () async {
                          if (handoverController
                              .branchController
                              .text
                              .isEmpty) {
                            Fluttertoast.showToast(msg: 'Select Branch');
                          } else if (handoverController
                              .departmentController
                              .text
                              .isEmpty) {
                            Fluttertoast.showToast(msg: 'Select Department');
                          }
                          if (userDataList.isEmpty) return;
                          final matchedUser = userDataList.firstWhere(
                            (element) =>
                                element['name'] ==
                                handoverController.custodianController.text,
                            orElse: () => {},
                          );

                          final selected = await showCustomSimpleBottomSheet(
                            context: context,
                            dataList: userDataList,
                            heading: 'Department',
                            selectedId: matchedUser['id'],
                          );

                          if (selected == null) return;
                          handoverController.handoverUserId = selected['id'];
                          handoverController.custodianController.text =
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
                    controller: handoverController.conditionTypeController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Condition type is required';
                      }
                      return null;
                    },
                    onTap: () async {
                      final List<Map<String, String>> conditionList = [
                        {'id': '0', 'name': 'Old'},
                        {'id': '1', 'name': 'New'},
                      ];
                      final selected = await showCustomSimpleBottomSheet(
                        context: context,
                        dataList: conditionList,
                        heading: 'User List',
                        // selectedId: matchedUser['id'],
                      );

                      if (selected != null) {
                        handoverController.conditionTypeController.text =
                            selected['name'];
                      }
                    },
                  ),
                  AssetsLabelTextFieldWidget(
                    formFieldKey: _remarkFieldKey,
                    isRequired: true,
                    label: 'handover_remark',
                    hintText: 'type_here',
                    image: AppAssets.assetMessageEdit,
                    controller: handoverController.remarkController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Handover remark is required';
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<CommonApiBloc, CommonApiState>(
                    builder: (context, state) {
                      if (state is UploadImagePdfApiSuccess) {
                        log(
                          name: 'common state',
                          state.imgPdfList.baseUrl.toString() +
                              state.imgPdfList.imgNameArr.toString(),
                        );
                        final baseUrl = state.imgPdfList.baseUrl ?? '';
                        final imgList = state.imgPdfList.imgNameArr ?? [];

                        // Create comma-separated full URLs
                        final fullImageUrlString = imgList
                            .map((name) => '$baseUrl$name')
                            .join(',');

                        log(
                          name: '________ common state ________ ',
                          fullImageUrlString,
                        );

                        handoverController.image = fullImageUrlString;
                      }
                      return CustomMediaPickerContainer(
                        title: 'assets_image',
                        imagePath: '',
                        imageTitle: 'attach_Image',
                        multipleImage: 4,
                        isCameraShow: true,
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
                          if (files.isNotEmpty) {
                            log(files.toString());
                            AssetUtils().fetchImageDataApi(
                              context,
                              files.map((f) => f.path).toList(),
                            );
                          } else {
                            if (handoverController.image != null) {
                              handoverController.image = null;
                            }
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

                  //Submit button
                  MyCoButton(
                    onTap: () {
                      if (!_handoverFieldKey.currentState!.validate()) {
                      } else if (!_branchFieldKey.currentState!.validate()) {
                      } else if (!_departmentFieldKey.currentState!
                          .validate()) {
                      } else if (!_custodianFieldKey.currentState!.validate()) {
                      } else if (!_conditionFieldKey.currentState!.validate()) {
                      } else if (!_remarkFieldKey.currentState!.validate()) {
                      } else {
                        log(
                          name:
                              '--------- Submit Handover asset from ------------',
                          '''
    'handoverAsset': 'handoverAsset',
    'languageId': '',
    'userId': '',
    'societyId': '',
    'userName': '',
    'otherUserName': ${handoverController.custodianController.text},
    'assetsId': $assetId,
    'handoverUserId':  ${handoverController.handoverUserId},
    'floorId':  ${handoverController.selectedDepartmentId},
    'handoverDate':  ${handoverController.handoverDateController.text},
    'conditionType':  ${handoverController.conditionTypeController.text},
    'handoverRemark':  ${handoverController.remarkController.text},
    'handoverImage': '',
                          ''',
                        );
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
      ),
    );
  }
}
