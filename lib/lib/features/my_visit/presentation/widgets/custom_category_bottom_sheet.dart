import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class CustomBottomSheet extends StatefulWidget {
  final List<Map<String, String>> items;
  final String? selectedId;
  final Function(Map<String, String>?) onDone;

  const CustomBottomSheet({
    super.key,
    required this.items,
    required this.onDone,
    this.selectedId,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  late List<Map<String, String>> _filteredItems;
  Map<String, String>? _selectedItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _selectedItem = widget.items.firstWhere(
      (item) => item['id'] == widget.selectedId,
      orElse: () => {},
    );
  }

  void _onSearch(String query) {
    setState(() {
      _filteredItems = widget.items
          .where(
            (item) => (item['name'] ?? '').toLowerCase().contains(
              query.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getColor(context);
    final responsive = Responsive.getResponsive(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          constraints: BoxConstraints(
            maxHeight: 0.6 * Responsive.getHeight(context),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
              bottom: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Search bar
              CustomSearchField(
                controller: _controller,
                onChanged: _onSearch,
                hintText: 'search',
                height: 44,
              ),

              const SizedBox(height: 20),

              // List section that scrolls if needed
              Expanded(
                child: _filteredItems.isEmpty
                    ? Center(
                        child: CustomText(
                          'No matching results',
                          fontSize: 16 * responsive,
                          fontWeight: FontWeight.w600,
                          color: color.onSurface,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (_, index) {
                          final item = _filteredItems[index];
                          final isSelected = item['id'] == _selectedItem?['id'];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedItem = item;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? color.primary
                                            : color.primary,
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Center(
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color.primary,
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                  const SizedBox(width: 15),
                                  CustomText(
                                    item['name'] ?? '',
                                    fontSize: 18 * responsive,
                                    fontWeight: FontWeight.w600,
                                    color: color.onSurface,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: MyCoButton(
                      title: 'CLOSE',
                      boarderRadius: 30,
                      backgroundColor: AppColors.transparent,
                      textStyle: TextStyle(color: color.primary),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: MyCoButton(
                      title: 'DONE',
                      backgroundColor: color.primary,
                      boarderRadius: 30,
                      isShadowBottomLeft: true,
                      onTap: () {
                        Navigator.pop(context);
                        widget.onDone(_selectedItem);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomBottomSheet(
  BuildContext context, {
  required List<Map<String, String>> items,
  String? selectedId,
  required Function(Map<String, String>?) onDone,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        CustomBottomSheet(items: items, selectedId: selectedId, onDone: onDone),
  );
}
