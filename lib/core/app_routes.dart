import 'package:clear_due/modules/auth/views/signup_view.dart';
import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/splash/views/splash_view.dart';

class AppRoutes {
  static const String initial = '/';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashView()),
    GetPage(name: login, page: () => const LoginView(), binding: AuthBinding()),
    GetPage(name: signup, page: () => SignupView(), binding: AuthBinding()),
  ];
}
