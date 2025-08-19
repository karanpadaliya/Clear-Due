import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/app_routes.dart';
import '../../../data/services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login(String phone, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _apiService.login(phone, password);
      if (response['success'] == true) {
        final userBox = Hive.box('userBox');
        userBox.put('isLoggedIn', true);
        userBox.put('uid', response['uid']);
        Get.offAllNamed(AppRoutes.home);
      } else {
        errorMessage.value = response['message'];
      }
    } catch (e) {
      errorMessage.value = 'Failed to connect to server. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signup(String name, String phone, String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _apiService.signup(name, phone, email, password);
      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          'Registration successful! Please login to continue.',
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutes.login);
      } else {
        errorMessage.value = response['message'];
      }
    } catch (e) {
      errorMessage.value = 'Failed to connect to server. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
