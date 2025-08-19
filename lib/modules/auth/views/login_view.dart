import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../shared/widgets/animated_background.dart';
import '../../../shared/widgets/cd_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  LoginView({super.key});

  final RxString selectedLang = 'en'.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background for consistency
          const AnimatedBackground(),

          // Main content with padding and scroll
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Language selector (similar to signup)
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

                  // Screen Title (localized)
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

                  // Phone TextField
                  CDTextField(
                    controller: phoneController,
                    labelText: "mobile".tr,
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    maxLength: 10,
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

                  // Login button with loading indicator
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.login(
                                phoneController.text.trim(),
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

                  // Navigate to Signup screen
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signup);
                    },
                    child: Text(
                      "haveAccount".tr,
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
