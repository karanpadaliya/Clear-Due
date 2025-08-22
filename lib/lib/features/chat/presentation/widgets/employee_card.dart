import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class EmployeeCardModel {
  final Widget? image;
  final String name, department;


  EmployeeCardModel({
    required this.image,
    required this.name,
    required this.department,

  });
}

class EmployeeCard extends StatelessWidget {
  // final ImageProvider image;
  final Widget? imageWidget; // <-- New optional widget
  final String name, department;
  final String userId;
  final bool isSelected;
  final bool? showDelete;
  final VoidCallback? onDeleteTap;
  final TextStyle? nameTextStyle, departmentTextStyle;
  final EdgeInsetsGeometry? boxPadding;
  final Color? borderColor, selectedColor;
  final double? boxHeight,
      boxWidth,
      borderRadius,
      imageWidth,
      imageHeight,
      spaceBetweenImageText;
  final ValueChanged<EmployeeCardModel>? onSelected;

  const EmployeeCard({
    // required this.image,
    required this.name,
    required this.department,
    required this.userId,
    required this.isSelected,
    super.key,
    this.imageWidget, // <-- Add to constructor
    this.boxHeight,
    this.boxWidth,
    this.imageWidth,
    this.imageHeight,
    this.spaceBetweenImageText,
    this.onSelected,
    this.borderRadius,
    this.borderColor,
    this.nameTextStyle,
    this.departmentTextStyle,
    this.boxPadding,
    this.showDelete,
    this.onDeleteTap,
    this.selectedColor,
  });

  void _handleTap() {
    if (onSelected != null) {
      onSelected!(
        EmployeeCardModel(
          name: name,
          department: department,
          image: imageWidget,
 
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: _handleTap,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: 100,
          padding:
              boxPadding ??
              const EdgeInsets.only(top: 12, left: 16, right: 24, bottom: 2),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEEF7FD) : Colors.white,
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : borderColor ?? AppColors.primary,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected ? Colors.grey.shade300 : Colors.transparent,
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: imageWidth ?? 80,
                    height: imageHeight ?? 80,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          width: imageWidth ?? 100,
                          height: imageHeight ?? 100,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? [
                                      selectedColor ?? AppColors.primary,
                                      (selectedColor ?? AppColors.primary)
                                          .withAlpha(150),
                                      Colors.white,
                                    ]
                                  : [
                                      Colors.grey.shade400,
                                      Colors.grey.shade300,
                                      Colors.white,
                                    ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: ClipOval(child: imageWidget),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isSelected
                                    ? [
                                        AppColors.primary,
                                        AppColors.primary.withAlpha(150),
                                        Colors.white,
                                      ]
                                    : [
                                        Colors.grey.shade400,
                                        Colors.grey.shade400,
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.grey.shade400,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomText(
                name,
                fontSize: 12 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                overflow: TextOverflow.ellipsis,
              ),
              CustomText(
                department,
                fontSize: 12 * Responsive.getResponsiveText(context),
                color: AppColors.textPrimary,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        if (showDelete == true)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onDeleteTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular((borderRadius ?? 20) - 1),
                    bottomLeft: Radius.circular(borderRadius ?? 10),
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.clear_circled,
                  color: AppColors.white,
                  size: 18,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
