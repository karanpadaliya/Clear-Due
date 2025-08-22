import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/holiday/presentation/pages/holiday_list_page.dart';

List<GoRoute> HolidayRoutes = [
  GoRoute(
    path: RoutePaths.holiday,
    name: 'HolidayVC',
    builder: (context, state) {
      final controller = TextEditingController();
      return HolidayListPage(controller: controller);
    },
  ),
];
