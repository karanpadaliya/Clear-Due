import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // इन Controllers का इस्तेमाल TextFields में user input लेने के लिए होता है।
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 'Login to your account' हेडिंग
              Text(
                "अपने अकाउंट में लॉगिन करें",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
              ),
              const SizedBox(height: 30),

              // मोबाइल नंबर के लिए TextField
              _buildTextField(
                controller: phoneController,
                labelText: "मोबाइल नंबर",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // पासवर्ड के लिए TextField
              _buildTextField(
                controller: passwordController,
                labelText: "पासवर्ड",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 30),

              // Login बटन, जो loading state को भी दिखाता है
              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator(color: AppColors.primary)
                  : ElevatedButton(
                onPressed: () {
                  // Controller में login फ़ंक्शन को कॉल करें
                  controller.login(
                    phoneController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  "लॉगिन",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              const SizedBox(height: 20),

              // Error message दिखाने के लिए
              Obx(() => Text(
                controller.errorMessage.value,
                style: const TextStyle(color: AppColors.statusFailed),
              )),

              // Sign Up पेज पर जाने के लिए बटन
              TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.signup);
                },
                child: const Text(
                  "अकाउंट नहीं है? साइन अप करें",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // एक reusable widget जो TextField को बनाता है
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
