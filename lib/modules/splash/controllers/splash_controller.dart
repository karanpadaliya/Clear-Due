import 'package:get/get.dart';

import '../../../core/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.login);
    });
  }
}