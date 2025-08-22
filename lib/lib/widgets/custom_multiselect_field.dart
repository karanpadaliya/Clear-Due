import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomMultiSelectField extends StatefulWidget {
  /// List of items to select from
  final List<Map<String, String>> items;
  
  /// Widget configuration
  final String labelText;
  final String hintText;
  final String addButtonText;
  final String? prefixIcon;
  final String? bottomSheetHeading;
  
  /// Callback function to handle item selection
  final void Function(List<Map<String, String>> selectedIds) onSelectionChanged;


  const CustomMultiSelectField({
    required this.items,
    required this.labelText,
    required this.hintText,
    required this.addButtonText,
    required this.onSelectionChanged, 
    Key? key,
    this.bottomSheetHeading,
    this.prefixIcon,

  }) : super(key: key);

  @override
  State<CustomMultiSelectField> createState() => _CustomMultiSelectFieldState();
}

class _CustomMultiSelectFieldState extends State<CustomMultiSelectField> {
  List<Map<String, String>> selectedItems = [];
  List<String> selectedIndex = [];
  void _openSelectionPicker() async {
  final  selectedIds = await showCustomSimpleBottomSheet(
    context: context,
    heading: widget.bottomSheetHeading ?? widget.addButtonText,
    icon: 'assets/chat/Frame.svg',
    dataList: widget.items,
    isMultipleSelection: true,
    selectedId: selectedItems.map((item) => item['id']).toList(),
  );

  log(selectedIds.toString(), name: "selectedIds in _openSelectionPicker");
  if (selectedIds == null || selectedIds.isEmpty) return;



  setState(() {
    for (final item in selectedIds) {
      final alreadySelected = selectedItems.any(
        (selected) => selected['id'] == item['id'],
      );
      if (!alreadySelected && item['id']?.isNotEmpty == true) {
        selectedItems.add(item);
      }
    }
  });
  widget.onSelectionChanged.call(
  selectedItems,
);
  for (var item in selectedIds) {
    log(item.toString(), name: "selectedItem");
  }
}


  void _removeItem(Map<String, String> item) {
    setState(() {
      selectedItems.removeWhere(
        (selectedItem) => selectedItem['id'] == item['id'],
      );
    });
     widget.onSelectionChanged.call(
    selectedItems,
  );
  }

  Widget _buildChips() {
    if (selectedItems.isEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(
          vertical: 6 * Responsive.getResponsive(context),
        ),
        child: CustomText(
          widget.hintText,
          fontSize: 16 * Responsive.getResponsiveText(context),
          color: AppTheme.getColor(context).outline,
        ),
      );
    }

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: selectedItems.map((item) => 
            Padding(
              padding: EdgeInsets.only(right: 8 * Responsive.getResponsive(context),top: 1 * Responsive.getResponsive(context),bottom: 1 * Responsive.getResponsive(context)),
              child: _buildChip(item),
            )
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildChip(Map<String, String> item) => Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10 * Responsive.getResponsive(context),
        vertical: 3 * Responsive.getResponsive(context),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 4 * Responsive.getResponsive(context),
      ),
      decoration: BoxDecoration(
        color: AppTheme.getColor(context).surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            item['name'] ?? 'Unknown',
            fontSize: 14 * Responsive.getResponsiveText(context),
            color: AppTheme.getColor(context).primary,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(width: 0.01 * Responsive.getWidth(context)),
          InkWell(
            onTap: () => _removeItem(item),
            child: Icon(
              Icons.close,
              size: 16 * Responsive.getResponsiveText(context),
              color: AppTheme.getColor(context).primary,
            ),
          ),
        ],
      ),
    );

  Widget _buildAddButton() => InkWell(
      onTap: _openSelectionPicker,
      child: Row(
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 16 * Responsive.getResponsiveText(context),
          ),
          const SizedBox(width: 8),
          CustomText(
            widget.addButtonText,
            fontSize: 14 * Responsive.getResponsiveText(context),
            fontWeight: FontWeight.w600,
            color: AppTheme.getColor(context).onSurface,
          ),
        ],
      ),
    );

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Spacing
        SizedBox(height: 16 * Responsive.getResponsiveText(context)),
        
        /// Label Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              widget.labelText,
              fontSize: 14 * Responsive.getResponsiveText(context),
              fontWeight: FontWeight.w600,
              color: AppTheme.getColor(context).onSurface,
            ),
            _buildAddButton(),
          ],
        ),
        
        /// Label Spacing
        SizedBox(height: 0.01 * Responsive.getHeight(context)),

        /// Main Container
        InkWell(
          onTap: _openSelectionPicker,
          child: Container(
          
            padding: EdgeInsets.symmetric(
              horizontal: 12 * Responsive.getResponsive(context),
              vertical: 8 * Responsive.getResponsive(context),
            ),
            decoration: BoxDecoration(
              color: AppTheme.getColor(context).background,
              border: Border.all(
                color: AppTheme.getColor(context).outline,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Chips Area
                Expanded(child: _buildChips()),

                /// Dropdown Icon
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0 * Responsive.getResponsive(context), vertical: 10 * Responsive.getResponsive(context)),
                  child: SvgPicture.asset(
                    widget.prefixIcon ??
                    'assets/chat/chevron-down.svg',
                    height: 15 * Responsive.getResponsive(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
}
