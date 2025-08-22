import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/media_picker/bloc/media_picker_bloc/media_picker_bloc.dart';
import 'package:myco_flutter/widgets/media_picker/bloc/media_picker_bloc/media_picker_event.dart';
import 'package:myco_flutter/widgets/media_picker/bloc/media_picker_bloc/media_picker_state.dart';
import 'package:myco_flutter/widgets/media_picker/screens/gallery_picker_screen.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/design_border_container.dart';
import 'package:myco_flutter/widgets/media_picker/widgets/media_picker.dart';
import 'package:path/path.dart' as path;

class CustomImagePickerContainer extends StatelessWidget {
  final double? imageMargin,
      containerHeight,
      titleFontSize,
      imageTitleSize,
      imageHeight,
      imageWidth;
  final String? title;
  final String imageTitle;
  final String imagePath;
  final String? networkImageUrl;
  final Color? titleColor, backgroundColor, imageTitleColor;
  final bool isCameraShow,
      isGalleryShow,
      isDocumentShow,
      isCropImage,
      titleIsKey,
      imageTitleIsKey;
  final bool? isRequired;
  final EdgeInsets? padding;
  final Function(List<File> files)? onSelectedMedia;

  const CustomImagePickerContainer({
    this.title,
    required this.imageTitle,
    required this.imagePath,
    this.imageHeight,
    this.imageWidth,
    this.onSelectedMedia,
    Key? key,
    this.networkImageUrl,
    this.imageMargin,
    this.containerHeight,
    this.backgroundColor,
    this.isCameraShow = false,
    this.isGalleryShow = false,
    this.isDocumentShow = false,
    this.isCropImage = false,
    this.titleIsKey = false,
    this.imageTitleIsKey = false,
    this.titleFontSize,
    this.titleColor,
    this.imageTitleColor,
    this.imageTitleSize,
    this.isRequired = false,
    void Function()? onImageRemoved,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => CustomMediaPickerBloc(),
    child: BlocListener<CustomMediaPickerBloc, CustomMediaPickerState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (onSelectedMedia != null) {
          if (state.document != null) {
            onSelectedMedia!([state.document!]);
          } else {
            onSelectedMedia!(state.images);
          }
        }
      },
      child: _ImagePickerContent(
        title: title,
        imageTitle: imageTitle,
        imagePath: imagePath,
        networkImageUrl: networkImageUrl,
        imageMargin: imageMargin,
        containerHeight: containerHeight,
        titleFontSize: titleFontSize,
        imageTitleSize: imageTitleSize,
        imageHeight: imageHeight,
        titleColor: titleColor,
        backgroundColor: backgroundColor,
        imageTitleColor: imageTitleColor,
        isCameraShow: isCameraShow,
        isGalleryShow: isGalleryShow,
        isDocumentShow: isDocumentShow,
        isCropImage: isCropImage,
        titleIsKey: titleIsKey,
        imageTitleIsKey: imageTitleIsKey,
        isRequired: isRequired,
        onSelectedMedia: onSelectedMedia,
        padding: padding,
      ),
    ),
  );
}

class _ImagePickerContent extends StatefulWidget {
  final double? imageMargin,
      containerHeight,
      titleFontSize,
      imageTitleSize,
      imageHeight;
  final String? title;
  final String imageTitle;
  final String imagePath;
  final String? networkImageUrl;
  final Color? titleColor, backgroundColor, imageTitleColor;
  final bool isCameraShow,
      isGalleryShow,
      isDocumentShow,
      isCropImage,
      titleIsKey,
      imageTitleIsKey;
  final bool? isRequired;
  final EdgeInsets? padding;

  const _ImagePickerContent({
    required this.imageTitle,
    required this.imagePath,
    this.imageMargin,
    this.containerHeight,
    this.titleFontSize,
    this.imageTitleSize,
    this.imageHeight,
    this.title,
    this.titleColor,
    this.backgroundColor,
    this.imageTitleColor,
    this.isCameraShow = false,
    this.isGalleryShow = false,
    this.isDocumentShow = false,
    this.isCropImage = false,
    this.titleIsKey = false,
    this.imageTitleIsKey = false,
    this.isRequired = false,
    this.padding,
    this.networkImageUrl,
    this.onSelectedMedia,
    Key? key,
  }) : super(key: key);

  final Function(List<File> files)? onSelectedMedia;

  @override
  State<_ImagePickerContent> createState() => _ImagePickerContentState();
}

class _ImagePickerContentState extends State<_ImagePickerContent> {
  bool _showNetworkImage = true;

  @override
  void initState() {
    super.initState();
    _showNetworkImage =
        widget.networkImageUrl != null && widget.networkImageUrl!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CustomMediaPickerBloc, CustomMediaPickerState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Row(
                children: [
                  CustomText(
                    widget.title!,
                    isKey: widget.titleIsKey,
                    fontSize:
                        widget.titleFontSize ??
                        14 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w700,
                    color:
                        widget.titleColor ??
                        AppTheme.getColor(context).onSurfaceVariant,
                  ),
                  if (widget.isRequired == true)
                    CustomText(
                      '*',
                      color: AppColors.red,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w700,
                    ),
                ],
              ),
            SizedBox(height: 0.008 * Responsive.getHeight(context)),
            // Show network image if present and not removed
            if (_showNetworkImage)
              _buildNetworkImage(
                context,
                widget.networkImageUrl!,
                widget.backgroundColor ??
                    AppTheme.getColor(context).surfaceContainerHigh,
                widget.padding ?? EdgeInsets.all(8),
              )
            else if (state.images.isNotEmpty)
              _buildImageGrid(
                context,
                state.images,
                widget.padding ?? EdgeInsets.all(8),
                widget.backgroundColor,
              )
            else if (state.document != null)
              _buildDocumentPreview(context, state.document!)
            else
              _buildInitialPicker(context, state.images),
          ],
        ),
      );

  Widget _buildNetworkImage(
    BuildContext context,
    String url,
    Color? backgroundColor,
    EdgeInsets? padding,
  ) => DesignBorderContainer(
    padding: padding ?? EdgeInsets.all(8),
    borderRadius: 8 * Responsive.getResponsive(context),
    borderColor: AppTheme.getColor(context).primary,
    backgroundColor:
        backgroundColor ?? AppTheme.getColor(context).surfaceContainerHigh,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            8 * Responsive.getResponsive(context),
          ),
          child: CustomCachedNetworkImage(
            imageUrl: url,
            width: double.infinity,
            height:
                widget.containerHeight ??
                (Responsive.isTablet(context)
                    ? 0.3 * Responsive.getHeight(context)
                    : 0.1 * Responsive.getHeight(context)),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () => setState(() => _showNetworkImage = false),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.removeBackground,
                border: Border.all(color: AppTheme.getColor(context).error),
                borderRadius: BorderRadius.circular(4),
              ),
              child: CustomText(
                'Remove',

                fontSize:
                    Theme.of(context).textTheme.bodyMedium?.fontSize ??
                    14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).error,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildImageGrid(
    BuildContext context,
    List<File> images,
    EdgeInsets? padding,
    Color? backgroundColor,
  ) => DesignBorderContainer(
    padding: padding ?? EdgeInsets.all(8),
    borderRadius: 8 * Responsive.getResponsive(context),
    borderColor: AppTheme.getColor(context).primary,
    backgroundColor:
        backgroundColor ?? AppTheme.getColor(context).surfaceContainerHigh,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            8 * Responsive.getResponsive(context),
          ),
          child: Image.file(
            images[0],
            width: double.infinity,
            height:
                widget.containerHeight ??
                (Responsive.isTablet(context)
                    ? 0.3 * Responsive.getHeight(context)
                    : 0.1 * Responsive.getHeight(context)),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () =>
                context.read<CustomMediaPickerBloc>().add(RemoveMediaFile(0)),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.removeBackground,
                border: Border.all(color: AppTheme.getColor(context).error),
                borderRadius: BorderRadius.circular(4),
              ),
              child: CustomText(
                'Remove',

                fontSize:
                    Theme.of(context).textTheme.bodyMedium?.fontSize ??
                    14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).error,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildDocumentPreview(BuildContext context, File document) =>
      DesignBorderContainer(
        backgroundColor: AppTheme.getColor(context).surfaceContainerHigh,
        borderRadius: 10 * Responsive.getResponsive(context),
        borderColor: AppTheme.getColor(context).primary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.insert_drive_file,
              color: AppTheme.getColor(context).primary,
              size: 25 * Responsive.getResponsive(context),
            ),
            SizedBox(width: 0.010 * Responsive.getWidth(context)),
            Expanded(
              child: CustomText(
                path.basename(document.path),
                fontSize: 16 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w500,
                color: AppTheme.getColor(context).onSurface,
              ),
            ),
            GestureDetector(
              onTap: () =>
                  context.read<CustomMediaPickerBloc>().add(RemoveDocument()),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0.002 * Responsive.getHeight(context),
                  horizontal: 0.01 * Responsive.getWidth(context),
                ),
                decoration: BoxDecoration(
                  color: AppColors.removeBackground,
                  border: Border.all(color: AppTheme.getColor(context).error),
                  borderRadius: BorderRadius.circular(
                    4 * Responsive.getResponsive(context),
                  ),
                ),
                child: CustomText(
                  'remove',
                  isKey: true,
                  fontSize: 12 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildInitialPicker(BuildContext context, List<File> images) =>
      GestureDetector(
        onTap: () => openMediaPicker(context, 0),
        child: DesignBorderContainer(
          borderRadius: 12 * Responsive.getResponsive(context),
          borderColor: AppTheme.getColor(context).primary,
          backgroundColor:
              widget.backgroundColor ??
              AppTheme.getColor(context).surfaceContainerHigh,
          padding: EdgeInsets.all(10 * Responsive.getResponsive(context)),
          child: SizedBox(
            width: double.infinity,
            height:
                widget.containerHeight ??
                (Responsive.isTablet(context)
                    ? 0.3 * Responsive.getHeight(context)
                    : 0.1 * Responsive.getHeight(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.imagePath.isNotEmpty
                      ? widget.imagePath
                      : AppAssets.assetGalleryExport,
                  height:
                      widget.imageHeight ??
                      (Responsive.isTablet(context)
                          ? 0.10 * Responsive.getHeight(context)
                          : 0.03 * Responsive.getHeight(context)),
                ),
                SizedBox(height: 0.006 * Responsive.getHeight(context)),
                CustomText(
                  widget.imageTitle,
                  isKey: widget.imageTitleIsKey,
                  fontSize:
                      widget.imageTitleSize ??
                      16 * Responsive.getResponsiveText(context),
                  fontWeight: FontWeight.w600,
                  color:
                      widget.imageTitleColor ??
                      AppTheme.getColor(context).onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      );

  void openMediaPicker(BuildContext context, int currentCount) async {
    final remainingCount = 1 - currentCount;
    if (remainingCount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            'You have already selected the maximum number of images.',
            fontWeight: FontWeight.w600,
            fontSize: 12 * Responsive.getResponsiveText(context),
          ),
        ),
      );
      return;
    }

    List<File>? selectedFiles = [];
    if (widget.isGalleryShow &&
        !widget.isCameraShow &&
        !widget.isDocumentShow) {
      selectedFiles = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GalleryPickerScreen(
            maxSelection: remainingCount,
            onSelectionDone: (assets) async {
              Navigator.pop(context, assets);
            },
          ),
        ),
      );
    } else {
      selectedFiles = await showMediaFilePicker(
        context: context,
        maxCount: remainingCount,
        isCameraShow: widget.isCameraShow,
        isGalleryShow: widget.isGalleryShow,
        isDocumentShow: widget.isDocumentShow,
        isCropImage: widget.isCropImage,
      );
    }

    if (selectedFiles == null || selectedFiles.isEmpty) {
      log('User cancelled or error occurred.');
      return;
    }

    context.read<CustomMediaPickerBloc>().add(AddMediaFiles(selectedFiles));
    final state = context.read<CustomMediaPickerBloc>().state;
    widget.onSelectedMedia?.call(
      state.document != null ? [state.document!] : state.images,
    );
  }
}
