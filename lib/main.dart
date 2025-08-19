import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/app_routes.dart';
import 'core/localization/app_localization.dart';
import 'modules/splash/bindings/splash_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(UserAdapter());
  // await Hive.openBox('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bill Assist',
      debugShowCheckedModeBanner: false,

      //Language
      translations: AppLocalization(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),

      initialRoute: AppRoutes.initial,
      initialBinding: SplashBinding(),
      getPages: AppRoutes.routes,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
