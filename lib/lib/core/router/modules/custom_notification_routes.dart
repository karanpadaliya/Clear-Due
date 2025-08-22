import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/custom_notification/presentation/bloc/custom_notification_bloc.dart';
import 'package:myco_flutter/features/custom_notification/presentation/pages/custom_notification_page.dart';

List<GoRoute> customNotificationRoutes = [
  GoRoute(
    path: RoutePaths.customNotification,
    name: 'custom-notification',
    builder: (context, state) => BlocProvider(
      create: (context) => CustomNotificationBloc(),
      child: CustomNotificationPage(
        notificationData: state.extra as Map<String, dynamic>?,
      ),
    ),
  ),
];