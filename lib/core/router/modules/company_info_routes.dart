import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/company_info/presentation/bloc/company_info_bloc.dart';
import 'package:myco_flutter/features/company_info/presentation/pages/company_info_page.dart';

List<GoRoute> CompanyInfoRoutes = [
  GoRoute(
    path: RoutePaths.companyInfo,
    name: 'BuildingDetailsVC',
    builder: (context, state) => BlocProvider<CompanyInfoBloc>(
      create: (_) => GetIt.I<CompanyInfoBloc>(),
      child: const CompanyInfoPage(),
    ),
  ),
];
