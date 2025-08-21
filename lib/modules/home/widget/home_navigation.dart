import 'package:clear_due/shared/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import '../controller/home_controller.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(
      () => SizedBox(
        height: 80,
        child: Stack(
          children: [
            AnimatedBackground(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BottomNavigationBar(
                  currentIndex: controller.selectedIndex.value,
                  onTap: (index) => controller.changeTab(index),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white70,
                  elevation: 0,
                  selectedItemColor: AppColors.primary,
                  unselectedItemColor: AppColors.grey,
                  showUnselectedLabels: true,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  unselectedLabelStyle: const TextStyle(fontSize: 12),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.request_page_rounded),
                      label: "Request",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.history_rounded),
                      label: "History",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
