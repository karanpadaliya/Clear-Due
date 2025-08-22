import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_bloc.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_state.dart';
import 'package:myco_flutter/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:myco_flutter/widgets/custom_cached_network_image.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // late final AnimationController _controller;
  final PreferenceManager _preference = GetIt.I<PreferenceManager>();
  final bool _canNavigate = false;
  String version = '';
  String buildNumber = '';
  bool _isSplashLogicComplete = false;
  bool _isLanguageReady = false;

  // void _checkAndNavigate() {
  //   // Only navigate when BOTH tasks are complete
  //   if (_isSplashLogicComplete && _isLanguageReady) {
  //     // Your navigation logic here, e.g.,
  //     _navigateNext();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _init();
    // final sl = GetIt.instance;
    // refreshApiServiceCompany(sl);
  }

  Future<void> _init() async {
    // _controller = AnimationController(vsync: this);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
    // _controller.addStatusListener((status) {
    // if (status == AnimationStatus.completed && _canNavigate) {
    //   _navigateNext();
    // }
    // });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _navigateNext();
    });

    _preference.clearSecureStorageOnFreshInstall();
  }

  Future<void> _navigateNext() async {
    final isLoggedIn = await _preference.getLoginSession();
    final registerUserId = await _preference.getKeyValueString(
      VariableBag.registrationRequestPendingUserId,
    );
    final bool requestApprove =
        await _preference.getKeyValueBoolean(
          VariableBag.REGISTRATION_REQUEST_IS_APPROVE,
        ) ??
        false; // Use `?? false` to handle cases where the value might not exist yet

    if (registerUserId.isNotEmpty) {
      if (!requestApprove) {
        if (!mounted) return;
        context.go(RoutePaths.contactAdmin);
      } else {
        if (!mounted) return;
        context.go(isLoggedIn ?? false ? RoutePaths.home : '/get-started');
      }
    } else {
      if (!mounted) return;
      context.go(isLoggedIn ?? false ? RoutePaths.home : '/get-started');
    }
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
    listeners: [
      // Listener for your original SplashBloc
      BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            // Or whatever your success state is
            setState(() {
              _isSplashLogicComplete = true;
            });
            // _checkAndNavigate();
          } else if (state is SplashError) {
            // Handle error, maybe show a message
          }
        },
      ),
      // Listener for the LanguageBloc
      BlocListener<LanguageBloc, LanguageState>(
        listener: (context, state) {
          if (state is LanguageValueDownloaded) {
            setState(() {
              _isLanguageReady = true;
            });
            // _checkAndNavigate();
          } else if (state is LanguageError) {
            // Handle error, maybe show a message and a retry button
            // For now, we can mark it as "ready" to unblock the UI
            // but you should implement proper error handling.
            setState(() {
              _isLanguageReady = true;
            });
            // _checkAndNavigate();
          }
        },
      ),
    ],
    child: Scaffold(
      backgroundColor: AppTheme.getColor(context).surfaceBright,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppTheme.getColor(context).surfaceBright,
              AppColors.secondary,
            ],
          ),
          // color: AppTheme.getColor(context).onPrimary,
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/splash/myco_splash.gif',
                width: 0.5 * Responsive.getWidth(context),
              ),
              // child: Lottie.asset(
              //   'assets/splash/myco_splash.json',
              //   controller: _controller,
              //   onLoaded: (composition) {
              //     _controller
              //       ..duration = composition.duration
              //       ..forward();
              //   },
              //   height: 0.3 * Responsive.getHeight(context),
              //   // width: 0.5 * Responsive.getWidth(context),
              // ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                bottom: 0.02 * Responsive.getHeight(context),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    'Powered by',
                    color: AppColors.black,
                    fontSize: 12 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w700,
                  ),
                  CustomCachedNetworkImage(
                    imageUrl: AppAssets.chplLogo,
                    width: 0.18 * Responsive.getWidth(context),
                    height: 0.036 * Responsive.getHeight(context),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: Responsive.getHeight(context) * 0.008),
                  CustomText(
                    /*'v$version ($buildNumber)',*/
                    'v$version',
                    color: AppColors.black,
                    fontSize: 12 * Responsive.getResponsiveText(context),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
