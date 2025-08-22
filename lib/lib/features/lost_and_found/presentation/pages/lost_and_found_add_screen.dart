import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_event.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_state.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/widgets/custom_radio_button.dart';
import 'package:myco_flutter/widgets/custom_image_picker_containe.dart';
import 'package:myco_flutter/widgets/custom_loader.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class LostAndFoundAddScreen extends StatefulWidget {
  final LostFoundEntity? item;

  const LostAndFoundAddScreen({super.key, this.item});

  @override
  State<LostAndFoundAddScreen> createState() => _LostAndFoundAddScreenState();
}

class _LostAndFoundAddScreenState extends State<LostAndFoundAddScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  File? selectedImage;
  String selectedOption = 'Lost';
  String lostAndFoundMasterId = '';
  List<String> lostAndFoundImage = [];
  String imageName = '';
  String dataImage = '';
  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      itemNameController.text = widget.item!.lostFoundTitle ?? '';
      itemDescriptionController.text = widget.item!.lostFoundDescription ?? '';
      selectedOption = widget.item!.lostFoundType == 'Lost' ? 'Lost' : 'Found';
      imageName = widget.item!.lostFoundImage ?? '';
      lostAndFoundMasterId = widget.item!.lostFoundMasterId ?? '';
      dataImage = widget.item!.lostFoundImage ?? '';
      isEdit = true;
    } else {
      isEdit = false;
    }
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      // Listener for Upload
      BlocListener<CommonApiBloc, CommonApiState>(
        listenWhen: (prev, curr) => curr is UploadImagePdfApiSuccess,
        listener: (context, state) {
          if (state is UploadImagePdfApiSuccess) {
            imageName = state.imgPdfList.imgNameArr!.first.toString();
          }
        },
      ),

      // Listener for Lost And Found
      BlocListener<LostAndFoundBloc, LostAndFoundState>(
        listener: (context, state) {
          if (state is LostAndFoundLoading) {
            const CustomLoader();
          } else if (state is LostAndFoundItemAddedSuccess) {
            Fluttertoast.showToast(msg: state.response.message ?? '');
            context.pop('refresh');
          } else if (state is LostAndFoundItemEditedSuccess) {
            Fluttertoast.showToast(msg: state.response.message ?? '');
            context.pop('refresh');
          } else if (state is LostAndFoundError) {
            Fluttertoast.showToast(msg: state.message);
          }
        },
      ),
    ],
    child: Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CustomText(
              'lost_and_found_title',
              fontWeight: FontWeight.w700,
              color: AppTheme.getColor(context).onSurface,
              fontSize: 18 * Responsive.getResponsive(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: .020 * Responsive.getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomImagePickerContainer(
                imageTitle: 'select_option',
                networkImageUrl: dataImage,
                isGalleryShow: true,
                title: 'Lost & Found',
                isCameraShow: true,
                backgroundColor: AppColors.transparent,
                containerHeight: 0.1 * Responsive.getHeight(context),
                imagePath: AppAssets.galleryExport,
                onSelectedMedia: (List<File> files) {
                  selectedImage = files.first;
                  final List<String> imgList = [files.first.path];
                  _fetchImageDataApi(imgList);
                },
              ),
            ),
            SizedBox(height: .024 * Responsive.getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: CustomRadioButton(
                title: 'select',
                options: const ['Lost', 'Found'],
                height: .050 * Responsive.getHeight(context),
                initialValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            SizedBox(height: .024 * Responsive.getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: NewTextField(
                hintText: LanguageManager().get('type_here'),
                label: 'item_name',
                isRequired: true,
                controller: itemNameController,
              ),
            ),
            SizedBox(height: .024 * Responsive.getHeight(context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: NewTextField(
                hintText: LanguageManager().get('type_here'),
                label: 'about_item',
                maxLines: 5,
                isRequired: true,
                controller: itemDescriptionController,
              ),
            ),
            SizedBox(height: .080 * Responsive.getHeight(context)),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: MyCoButton(
          onTap: _onSubmit,
          title: 'submit',
          boarderRadius: 50,
          isShadowBottomLeft: true,
          backgroundColor: AppTheme.getColor(context).primary,
          height: .050 * Responsive.getHeight(context),
          width: double.infinity,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 15 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );

  void _fetchImageDataApi(List<String> imgList) {
    context.read<CommonApiBloc>().add(UploadAttachments(true, imgList));
  }

  Future<void> _onSubmit() async {
    final itemTitle = itemNameController.text.trim();
    final itemDescription = itemDescriptionController.text.trim();

    if (isEdit && imageName.trim().isEmpty) {
      Fluttertoast.showToast(msg: LanguageManager().get('please_select_image'));
      return;
    }

    if (!isEdit && selectedImage == null) {
      Fluttertoast.showToast(msg: LanguageManager().get('please_select_image'));
      return;
    }

    if (selectedOption.trim().isEmpty) {
      Fluttertoast.showToast(msg: LanguageManager().get('please_select_type'));
      return;
    }

    if (itemTitle.isEmpty) {
      Fluttertoast.showToast(
        msg: LanguageManager().get('please_enter_item_name'),
      );
      return;
    }

    if (itemDescription.isEmpty) {
      Fluttertoast.showToast(
        msg: LanguageManager().get('please_enter_item_description'),
      );
      return;
    }

    final preferenceManager = GetIt.I<PreferenceManager>();

    final companyId = await preferenceManager.getCompanyId();
    final userId = await preferenceManager.getUserId();
    final userName = await preferenceManager.getUserFullName();
    final userDesignation = await preferenceManager.getDesignation();
    final languageId = await preferenceManager.getLanguageId();
    final branchId = await preferenceManager.getBranchId();

    final nameWithDesignation = '$userName - $userDesignation';

    final lostAndFoundOption = selectedOption == 'Lost' ? '1' : '0';

    if (isEdit) {
      final request = {
        'updateLostFoundNew': 'updateLostFoundNew',
        'society_id': companyId,
        'user_id': userId,
        'language_id': languageId,
        'block_id': branchId,
        'lost_found_title': itemTitle,
        'lost_found_description': itemDescription,
        'lost_found_image': imageName,
        'lost_found_type': lostAndFoundOption,
        'user_name': nameWithDesignation,
        'lost_found_master_id': lostAndFoundMasterId,
      };

      context.read<LostAndFoundBloc>().add(EditLostAndFoundItemsEvent(request));
    } else {
      final request = {
        'addLostFoundNew': 'addLostFoundNew',
        'society_id': companyId,
        'user_id': userId,
        'language_id': languageId,
        'block_id': branchId,
        'lost_found_title': itemTitle,
        'lost_found_description': itemDescription,
        'lost_found_image': imageName,
        'lost_found_type': lostAndFoundOption,
        'user_name': nameWithDesignation,
      };

      context.read<LostAndFoundBloc>().add(AddLostAndFoundItemsEvent(request));
    }
  }
}
