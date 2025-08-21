import 'package:get/get.dart';

class SignupController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Signup function
  Future<void> signUp(
      String name,
      String phone,
      String email,
      String password,
      String referralCode,
      ) async {
    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = "⚠ Please fill all required fields";
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = "";

      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simple validation and success logic
      if (!GetUtils.isEmail(email)) {
        errorMessage.value = "Please enter a valid email address.";
        return;
      }

      // On successful signup
      print("✅ User Created: $email");
      Get.snackbar(
        "Success 🎉",
        "Account created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        errorMessage.value,
      );
    } finally {
      isLoading.value = false;
    }
  }
}