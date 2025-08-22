import 'package:clear_due/modules/home/widget/home_navigation.dart';
import 'package:clear_due/shared/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import 'controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      // ✅ Transparent AppBar with animated background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: const AnimatedBackground(),
        title: const Text(
          "Clear Due",
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),

      body: Stack(
        children: [
          // ✅ Animated background
          const AnimatedBackground(),

          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // ✅ Welcome Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(
                        () => Text(
                      "Welcome, ${controller.username.value}",
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ✅ Slider / Carousel
                SizedBox(
                  height: 180,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.85),
                    children: List.generate(3, (index) {
                      return _buildSliderCard(
                        "Tip ${index + 1}",
                        "Here is some helpful info or notification for you!",
                        AppColors.primary,
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 32),

                // ✅ Recent Activity Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Recent Activity",
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      color: AppColors.white,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(Icons.receipt_long, color: AppColors.white),
                        ),
                        title: Text(
                          "Transaction #${index + 1}",
                          style: TextStyle(color: AppColors.textDark),
                        ),
                        subtitle: Text(
                          "₹${(index + 1) * 500}",
                          style: TextStyle(color: AppColors.textGrey),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),

      // ✅ Bottom Navigation
      bottomNavigationBar: const HomeNavigation(),
    );
  }

  // ✅ Slider / Carousel Card
  Widget _buildSliderCard(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
