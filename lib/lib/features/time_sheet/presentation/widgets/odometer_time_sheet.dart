import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_image_picker_containe.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class OdometerTimeSheet extends StatefulWidget {
  final String title;
  final Function(File?, String, String)? onSubmit;

  const OdometerTimeSheet({required this.title, super.key, this.onSubmit});

  @override
  State<OdometerTimeSheet> createState() => _OdometerTimeSheet();
}

class _OdometerTimeSheet extends State<OdometerTimeSheet> {
  File? _selectedImage;
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _meterController = TextEditingController();
  String? _previousTitle;

  @override
  void initState() {
    super.initState();
    _previousTitle = widget.title;
  }

  @override
  void didUpdateWidget(OdometerTimeSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state when the title changes (e.g., from punch-in to punch-out)
    if (widget.title != _previousTitle) {
      setState(() {
        _selectedImage = null;
        _kmController.clear();
        _meterController.clear();
        _previousTitle = widget.title;
      });
    }
  }

  @override
  void dispose() {
    _kmController.dispose();
    _meterController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_selectedImage != null &&
        _kmController.text.isNotEmpty &&
        _meterController.text.isNotEmpty) {
      widget.onSubmit?.call(
        _selectedImage,
        _kmController.text,
        _meterController.text,
      );
      // Clear fields after submission to prevent reuse
      setState(() {
        _selectedImage = null;
        _kmController.clear();
        _meterController.clear();
      });
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please provide an image and odometer reading'),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(widget.title, fontWeight: FontWeight.w500),

      SizedBox(height: 0.015 * Responsive.getHeight(context)),
      Padding(
        padding: EdgeInsets.all(2 * Responsive.getResponsive(context)),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
            vertical: 20 * Responsive.getResponsive(context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Your last odometer reading : 1111',
                color: AppTheme.getColor(context).onSurfaceVariant,
              ),

              SizedBox(height: 0.015 * Responsive.getHeight(context)),
              CustomText(
                '1. Attach Odometer Photo',
                color: AppTheme.getColor(context).onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.015 * Responsive.getHeight(context)),
              CustomImagePickerContainer(
                containerHeight: 150,
                imagePath: _selectedImage != null
                    ? _selectedImage!.path
                    : AppAssets.galleryExport,
                isCameraShow: true,
                onSelectedMedia: (image) {
                  setState(() {
                    _selectedImage = image.first;
                  });
                },
                imageTitle: '',
              ),
              SizedBox(height: 0.015 * Responsive.getHeight(context)),
              CustomText(
                '2. Odometer Reading',
                color: AppTheme.getColor(context).onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.01 * Responsive.getHeight(context)),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'KM',
                          color: AppTheme.getColor(context).onSurfaceVariant,
                        ),
                        SizedBox(height: 0.01 * Responsive.getHeight(context)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9FB),
                            borderRadius: BorderRadius.circular(
                              12 * Responsive.getResponsive(context),
                            ),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: TextField(
                            controller: _kmController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '000000',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 0.025 * Responsive.getWidth(context)),
                  SizedBox(
                    width: 0.40 * Responsive.getWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Meter',
                          color: AppTheme.getColor(context).onSurfaceVariant,
                        ),
                        SizedBox(height: 0.015 * Responsive.getHeight(context)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9FB),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: TextField(
                            controller: _meterController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '00',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.015 * Responsive.getHeight(context)),
              Text(
                'Travel KM: ${_kmController.text.isNotEmpty && _meterController.text.isNotEmpty ? '${_kmController.text}.${_meterController.text}' : '0.0'}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 0.015 * Responsive.getHeight(context)),
              Center(
                child: MyCoButton(
                  onTap: _handleSubmit,
                  title: 'Submit Photo & Reading',
                  boarderRadius: 25 * Responsive.getResponsive(context),
                  width: 0.55 * Responsive.getWidth(context),
                  height: 0.055 * Responsive.getHeight(context),
                  isShadowBottomLeft: true,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
