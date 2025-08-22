import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/data/models/employee_model.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class SelectedEmployeesList extends StatelessWidget {
  final List<EmployeeSelectModel> selectedEmployees;
  final Function(EmployeeSelectModel) onRemove;

  const SelectedEmployeesList({
    Key? key,
    required this.selectedEmployees,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedEmployees.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 0.09 * Responsive.getHeight(context),
   
      margin: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedEmployees.length,
              itemBuilder: (context, index) {
                final employee = selectedEmployees[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => onRemove(employee),
                    child: Stack(
                      children: [
                        Column(
                          // mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 35 * Responsive.getResponsive(context),
                              backgroundImage: NetworkImage(
                                employee.imageUrl == ''
                                    ? 'https://avatar.iran.liara.run/public/1'
                                    : employee.imageUrl,
                              ),
                              backgroundColor: AppTheme.getColor(
                                context,
                              ).onPrimary,
                            ),
                            // const SizedBox(height: 4),
                            CustomText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              employee.name,
                              color: AppTheme.getColor(context).onSurface,
                              fontSize: 12 * Responsive.getResponsive(context),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.getColor(context).onPrimary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getColor(context).outline,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: AppTheme.getColor(context).outline,
                                  blurRadius: 4,
                                  spreadRadius: -2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(2),
                            child: Icon(
                              Icons.close,
                              size: 16 * Responsive.getResponsive(context),
                              color: AppTheme.getColor(context).primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
