import 'package:clear_due/modules/auth/bindings/login_binding.dart';
import 'package:clear_due/modules/auth/bindings/signup_binding.dart';
import 'package:clear_due/modules/auth/views/signup_view.dart';
import 'package:clear_due/modules/home/home_view.dart';
import 'package:get/get.dart';

import '../modules/auth/views/login_view.dart';
import '../modules/splash/views/splash_view.dart';

class AppRoutes {
  static const String initial = '/';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashView()),
    GetPage(name: login, page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: signup, page: () => SignupView(), binding: SignupBinding()),
    GetPage(name: home, page: () => HomeView()),
  ];
}
