import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/app_routes.dart';
import 'core/localization/app_localization.dart';
import 'modules/splash/bindings/splash_binding.dart';
import 'core/app_colors.dart'; // ✅ Import your AppColors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Set system UI overlay style using AppColors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.white, // status bar background
    statusBarIconBrightness: Brightness.dark, // status bar icons
    statusBarBrightness: Brightness.light, // iOS
    systemNavigationBarColor: AppColors.white, // bottom nav background
    systemNavigationBarIconBrightness: Brightness.dark, // nav icons
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bill Assist',
      debugShowCheckedModeBanner: false,

      // Language
      translations: AppLocalization(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),

      initialRoute: AppRoutes.initial,
      initialBinding: SplashBinding(),
      getPages: AppRoutes.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white, // default background
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accent),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          iconTheme: const IconThemeData(color: AppColors.black),
          titleTextStyle: const TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark, // status bar icons dark
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.accent,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(),
        ),
      ),
    );
  }
}
