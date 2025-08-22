import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/pages/work_from_home_page.dart';

List<RouteBase> WFHRoutes = [
  // ShellRoute(
  //   builder: (BuildContext context, GoRouterState state, Widget child) =>
  //       BlocProvider(create: (context) => GetIt.I<AddWfhBloc>(), child: child),
  //   routes: [
  //     GoRoute(
  //       path: RoutePaths.AddWfh,
  //       name: 'WFHVC',
  //       builder: (context, state) => MultiBlocProvider(
  //         providers: [
  //           BlocProvider<AddWfhBloc>(create: (_) => sl<AddWfhBloc>()),
  //           BlocProvider(
  //             create: (context) => CommonApiBloc(
  //               commonApiUserCase: GetIt.I<CommonApiUserCase>(),
  //             ),
  //           ),
  //         ],
  //         child: const MyWfhListPage(),
  //       ),
  //     ),
  //   ],
  // ),
  GoRoute(
    path: RoutePaths.AddWfh,
    name: 'WFHVC',
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<AddWfhBloc>(create: (_) => GetIt.I<AddWfhBloc>()),
        BlocProvider(create: (context) => TabbarBloc()),
      ],
      child: const WorkFromHomePage(),
    ),
  ),
];
// Widget build(BuildContext context) => BlocProvider(
//   create: (_) => AddWfhBloc()..add(FetchWFHList()),
//   child: Scaffold(
//     appBar: AppBar(title: const Text('WFH History')),
