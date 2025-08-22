import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/features/admin_view/utils/shared_admin_data_holder.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class AdminViewMaintenancePage extends StatelessWidget {
  final String title;
  final Map<String, dynamic>? extra;

  const AdminViewMaintenancePage({required this.title, super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    // 1. Get the instance of the shared data holder from GetIt
    final sharedData = GetIt.I<SharedAdminDataHolder>();

    // 2. Retrieve the filtered data and the selected sub-menu
    final filteredAdminData = sharedData.adminViewData;
    final subMenuData = sharedData.subMenuData;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          title,
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.construction, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              CustomText(
                title,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const CustomText(
                'Page under construction',
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),

              // 3. Display the retrieved shared data to confirm it's working
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              const CustomText(
                'Data from Shared Holder:',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              if (subMenuData != null)
                CustomText('Sub-menu Clicked: ${subMenuData.accessType}'),
              const SizedBox(height: 8),
              if (filteredAdminData != null) ...[
                CustomText(
                  'Filtered Branches: ${filteredAdminData.branchList?.length ?? 0}',
                ),
                const SizedBox(height: 8),
                CustomText(
                  'Filtered Departments: ${filteredAdminData.departmentList?.length ?? 0}',
                ),
                const SizedBox(height: 8),
                CustomText(
                  'Filtered Employees: ${filteredAdminData.employeeList?.length ?? 0}',
                ),
              ],

              if (extra != null) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    'Route Parameters: ${extra.toString()}',
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
