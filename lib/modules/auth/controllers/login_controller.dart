import 'package:clear_due/core/app_routes.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simple validation logic
      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = "Please enter both email and password.";
        return;
      }

      // If login is successful
      // You can add your own logic here
      if (email == "1" && password == "1") {
        Get.snackbar("Success", "Login successful!",
            snackPosition: SnackPosition.BOTTOM);
        Get.offAndToNamed(AppRoutes.home);
      } else {
        errorMessage.value = "Invalid email or password.";
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred.";
    } finally {
      isLoading.value = false;
    }
  }
}