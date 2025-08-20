import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../shared/widgets/animated_background.dart';
import '../../../shared/widgets/cd_text_field.dart';
import '../controllers/login_controller.dart'; // ✅ use LoginController instead of AuthController

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final LoginController controller = Get.put(
    LoginController(),
  ); // ✅ use login controller

  final RxString selectedLang = 'en'.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          const AnimatedBackground(),

          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Language selector
                  Obx(
                    () => Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            selectedLang.value == 'en'
                                ? Icons.language
                                : Icons.translate,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: selectedLang.value,
                            underline: Container(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            dropdownColor: Colors.white,
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'hi',
                                child: Text('हिंदी'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                selectedLang.value = value;
                                Get.updateLocale(Locale(value));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Title
                  Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        selectedLang.value == 'en' ? "login".tr : "login".tr,
                        key: ValueKey(selectedLang.value),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email TextField
                  CDTextField(
                    controller: emailController,
                    labelText: "email".tr,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),

                  // Password TextField
                  CDTextField(
                    controller: passwordController,
                    labelText: "password".tr,
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 30),

                  // Login button
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              elevation: 6,
                            ),
                            child: Text(
                              "login".tr,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Error message
                  Obx(
                    () => Text(
                      controller.errorMessage.value,
                      style: const TextStyle(
                        color: AppColors.statusFailed,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Navigate to Signup
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signup);
                    },
                    child: Text(
                      "noAccount".tr,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
