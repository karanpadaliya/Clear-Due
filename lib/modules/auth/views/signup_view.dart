import 'package:clear_due/shared/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_routes.dart';
import '../../../shared/widgets/cd_text_field.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  SignupView({super.key});

  final RxString selectedLang = 'en'.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌈 Animated Background
          const AnimatedBackground(),

          /// Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// 🌐 Language Dropdown
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
                                child: Text("English"),
                              ),
                              DropdownMenuItem(
                                value: 'hi',
                                child: Text("हिंदी"),
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

                  /// 🔥 Icon Animation
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

                  /// Input Fields
                  CDTextField(
                    controller: nameController,
                    labelText: "fullName".tr,
                    icon: Icons.person,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 18),

                  CDTextField(
                    controller: phoneController,
                    labelText: "mobile".tr,
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 18),

                  CDTextField(
                    controller: emailController,
                    labelText: "email".tr,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 18),

                  CDTextField(
                    controller: passwordController,
                    labelText: "password".tr,
                    icon: Icons.lock,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 28),

                  /// 🚀 Sign Up Button
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : ElevatedButton.icon(
                            onPressed: () {
                              controller.signup(
                                nameController.text.trim(),
                                phoneController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
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

                  /// ❌ Error Message
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

                  /// 🔑 Already Have Account
                  TextButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.login),
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

//
// /// 🎨 Background with floating bubbles
// class AnimatedBackground extends StatefulWidget {
//   const AnimatedBackground({super.key});
//
//   @override
//   State<AnimatedBackground> createState() => _AnimatedBackgroundState();
// }
//
// class _AnimatedBackgroundState extends State<AnimatedBackground>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//     AnimationController(vsync: this, duration: const Duration(seconds: 20))
//       ..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, _) {
//         return CustomPaint(
//           painter: BubblePainter(_controller.value),
//           child: const SizedBox.expand(),
//         );
//       },
//     );
//   }
// }
//
// /// 🫧 Bubble Painter
// class BubblePainter extends CustomPainter {
//   final double progress;
//   BubblePainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = AppColors.primary.withOpacity(0.12);
//
//     for (int i = 0; i < 6; i++) {
//       final radius = 35.0 + (i * 12);
//       final dx = (size.width / 2) +
//           math.sin(progress * 2 * math.pi + i) * (size.width / 3);
//       final dy = (size.height / 2) +
//           math.cos(progress * 2 * math.pi + i) * (size.height / 3);
//       canvas.drawCircle(Offset(dx, dy), radius, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
// }
