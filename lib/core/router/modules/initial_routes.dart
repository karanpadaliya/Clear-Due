import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/circular/domain/usecase/circular_usecase.dart';
import 'package:myco_flutter/features/circular/presentation/bloc/circular_bloc.dart';
import 'package:myco_flutter/features/circular/presentation/pages/circular_page.dart';
import 'package:myco_flutter/features/common_api/domain/usecase/common_api_usercase.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/bloc/company/company_bloc.dart';
import 'package:myco_flutter/features/company_selector/presentation/pages/select_company_page.dart';
import 'package:myco_flutter/features/idea_box/presentation/bloc/list_idea_bloc.dart';
import 'package:myco_flutter/features/idea_box/presentation/pages/idea_request.dart';
import 'package:myco_flutter/features/idea_box/presentation/pages/list_of_ideas.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_bloc.dart';
import 'package:myco_flutter/features/language_selector/presentation/bloc/language_event.dart';
import 'package:myco_flutter/features/language_selector/presentation/pages/language_selector_page.dart';
import 'package:myco_flutter/features/search_company/presentation/pages/get_started.dart';
import 'package:myco_flutter/features/search_company/presentation/pages/search_company.dart';
import 'package:myco_flutter/features/sign_in/domain/usecases/primary_register_usecase.dart';
import 'package:myco_flutter/features/sign_in/presentation/bloc/primary_register_bloc.dart';
import 'package:myco_flutter/features/sign_in/presentation/custom_bloc/my_form_bloc.dart';
import 'package:myco_flutter/features/sign_in/presentation/pages/contact_admin_page.dart';
import 'package:myco_flutter/features/sign_in/presentation/pages/otp_dialog.dart';
import 'package:myco_flutter/features/sign_in/presentation/pages/sign_up_form_page.dart';
import 'package:myco_flutter/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:myco_flutter/features/splash/presentation/pages/splash_page.dart';

List<RouteBase> initialRoutes = [
  GoRoute(
    path: RoutePaths.splash,
    name: 'splash',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.I<SplashBloc>()..add(LoadSplash()),
        ),
        BlocProvider(
          create: (_) =>
          GetIt.I<LanguageBloc>()..add(InitializeLanguage()),
          lazy: false,
        ),
      ],
      child: const SplashPage(),
    ),
  ),

  GoRoute(
    path: RoutePaths.language,
    name: 'language',
    builder: (context, state) => const LanguageSelectorPage(),
  ),
  GoRoute(
    path: RoutePaths.login,
    name: RoutePaths.login,
    builder: (context, state) => const OtpVerifyDialog(),
  ),
  GoRoute(
    path: RoutePaths.selectCompany,
    name: 'selectCompany',
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<CompanyBloc>(),
      child: const SelectCompanyPage(),
    ),
  ),
  ShellRoute(
    builder: (context, state, child) => MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ListIdeaBloc())],
      child: child,
    ),
    routes: [
      GoRoute(
        path: RoutePaths.ideabox,
        name: 'idea-box',
        builder: (context, state) => BlocProvider(
          create: (context) => ListIdeaBloc(),
          child: ListOfIdeas(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ideaRequest,
        name: '/idea-request',
        builder: (context, state) => const IdeaRequest(),
      ),
    ],
  ),
  GoRoute(
    path: RoutePaths.signUpForm,
    name: 'select-other-company',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommonApiBloc(commonApiUserCase: GetIt.I<CommonApiUserCase>()),
        ),
        BlocProvider(
          create: (context) => PrimaryRegisterBloc(registerUseCase: GetIt.I<PrimaryRegisterUseCase>(),
          ),
        ),
        // --- ADD MyFormBloc HERE ---
        BlocProvider(
          create: (context) => MyFormBloc(), // Ensure MyFormBloc is provided
        ),
      ],
      child: const SignupFormPage()
    ),
  ),

  // GoRoute(
  //   path: RoutePaths.signUpForm,
  //   name: 'contact-admin',
  //   builder: (context, state) => MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (context) => PrimaryRegisterBloc(registerUseCase: GetIt.I<PrimaryRegisterUseCase>()),
  //       ),
  //     ],
  //     child: const ContactAdminPage()
  //   ),
  // ),

  GoRoute(
    path: RoutePaths.circular,
    name: 'NoticeVC',
    builder: (context, state) =>
        BlocProvider(
          create: (_) => CircularBloc(registerUseCase: GetIt.I<CircularUseCase>()),
          child: const CircularPage(),
        ),
  ),


  GoRoute(
    path: RoutePaths.contactAdmin,
    name: 'contact-admin',
    builder: (context, state) => BlocProvider(
        create: (_) => PrimaryRegisterBloc(registerUseCase: GetIt.I<PrimaryRegisterUseCase>()),
        child: const ContactAdminPage(),
      ),
  ),



  GoRoute(
    path: RoutePaths.getStarted,
    name: 'get-started',
    builder: (context, state) => const GetStarted(),
  ),
  GoRoute(
    path: RoutePaths.companySearch,
    name: 'companySearch',
    builder: (context, state) => const SearchCompanyScreen(),
  ),
];