import 'package:clear_due/core/responsive.dart';
import 'package:clear_due/shared/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../shared/widgets/cd_text_field.dart';
import '../controllers/signup_controller.dart'; // ✅ new controller

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final SignupController controller = Get.put(SignupController());

  final RxString selectedLang = 'en'.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Animation
          const AnimatedBackground(),

          /// Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Icon Animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: AppColors.primary.withValues(
                            alpha: 0.15,
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1,
                            color: AppColors.primary,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Title
                  Obx(
                        () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        "title".tr,
                        key: ValueKey("${selectedLang.value}title"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Subtitle
                  Obx(
                        () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Text(
                        "subtitle".tr,
                        key: ValueKey("${selectedLang.value}subtitle"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 18 * Responsive.getResponsive(context),
                    children: [
                      /// Full Name
                      CDTextField(
                        controller: nameController,
                        labelText: "fullName".tr,
                        icon: Icons.person,
                        textInputAction: TextInputAction.next,
                      ),

                      /// Phone
                      CDTextField(
                        controller: phoneController,
                        labelText: "mobile".tr,
                        icon: Icons.phone_android,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        textInputAction: TextInputAction.next,
                      ),

                      /// Email
                      CDTextField(
                        controller: emailController,
                        labelText: "email".tr,
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),

                      /// Password
                      CDTextField(
                        controller: passwordController,
                        labelText: "password".tr,
                        icon: Icons.lock,
                        isPassword: true,
                        textInputAction: TextInputAction.next,
                      ),

                      /// Referral Code
                      CDTextField(
                        controller: referralController,
                        labelText: "referralCode".tr,
                        icon: Icons.code,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  /// Sign Up Button
                  Obx(
                        () => controller.isLoading.value
                        ? const CircularProgressIndicator(
                      color: AppColors.primary,
                    )
                        : ElevatedButton.icon(
                      onPressed: () {
                        controller.signUp(
                          nameController.text.trim(),
                          phoneController.text.trim(),
                          emailController.text.trim(),
                          passwordController.text.trim(),
                          referralController.text.trim(),
                        );
                      },
                      icon: const Icon(
                        Icons.app_registration,
                        color: AppColors.white,
                      ),
                      label: Text(
                        "signUp".tr,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 52,
                          vertical: 16,
                        ),
                        elevation: 8,
                        shadowColor: AppColors.primary.withValues(
                          alpha: 0.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),

                  /// Error Message
                  Obx(
                        () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: controller.errorMessage.value.isNotEmpty
                          ? Text(
                        controller.errorMessage.value,
                        key: ValueKey(controller.errorMessage.value),
                        style: const TextStyle(
                          color: AppColors.statusFailed,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 18),

                  /// Already Have Account
                  TextButton.icon(
                    onPressed: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    icon: const Icon(Icons.login, color: AppColors.primary),
                    label: Text(
                      "haveAccount".tr,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
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
