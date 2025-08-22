import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/error/global_error_handler/global_error_cubit.dart';
import 'package:myco_flutter/core/router/app_router.dart';
import 'package:myco_flutter/core/services/firebase_messaging_service.dart';
import 'package:myco_flutter/core/services/hive_cache_service.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/theme/theme_service.dart';
import 'package:myco_flutter/di/injector.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// A global instance of our ThemeService
final themeService = ThemeService();



// Function to initialize Firebase and then get the token
Future<void> _initializeFirebaseAndToken() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    } else {
      print("Firebase app named '${Firebase.apps.first.name}' already exists. Using existing app.");
    }
  } catch (e) {
    print("Firebase init or token error in main: $e");
  }
  try {
    // First, ensure a token is available (getSavedFcmToken will generate if needed)
    String? token = await GetIt.I<FirebaseMessagingService>().getSavedFcmToken();
    print("FCM Token from main after getSavedFcmToken: $token");

    // THEN, initialize notification listeners, permissions, etc.
    // THIS IS WHERE initNotifications() IS CALLED:
    await GetIt.I<FirebaseMessagingService>().initNotifications();

  } catch (e) {
    print("Error initializing FCM service or getting/initializing token in main: $e");
  }

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await dotenv.load();
  await dotenv.load(fileName: '.env');
  ApiUrl.getMainURL();
  await HiveCacheService.init(); // Ensures Hive is ready before DI

  await initDi(); // Initialize Dependency Injection

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent,
    ),
  );

  // Initialize Firebase and then get the token
  await _initializeFirebaseAndToken();

  runApp(
    BlocProvider(
      create: (context) => GetIt.I<GlobalErrorCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRouter>().router;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService,
      builder: (context, themeMode, child) => MaterialApp.router(
        title: 'MyCo Flutter',
        themeMode: themeMode,
        theme: AppTheme.lightTheme(context),
        darkTheme: AppTheme.darkTheme(context),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => BlocListener<GlobalErrorCubit, GlobalErrorState>(
          // This is crucial: It ensures the listener only fires ONCE when an error
          // first becomes active.
          listenWhen: (previous, current) =>
              !previous.isErrorActive && current.isErrorActive,
          listener: (context, state) {
            if (state.message != null) {
              // Hide any existing snackbar to avoid stacking them.
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              // Show the new snackbar.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: CustomText(
                    state.message!,
                    color: AppTheme.getColor(context).onError,
                  ),
                  backgroundColor: AppTheme.getColor(context).error,
                ),
              );

              // After the snackbar duration, reset the cubit's state so it can
              // listen for the next error.
              Future.delayed(const Duration(seconds: 4), () {
                context.read<GlobalErrorCubit>().hideError();
              });
            }
          },
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
