import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/common_api/presentation/bloc/common_api_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/domain/entities/lost_and_found_entity.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/bloc/lost_and_found_bloc.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/pages/lost_and_found_add_screen.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/pages/chat_screen.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/pages/lost_and_found_item_details_screen.dart';
import 'package:myco_flutter/features/lost_and_found/presentation/pages/lost_and_found_list_screen.dart';

List<RouteBase> lostAndFoundRoutes = [
  GoRoute(
    path: RoutePaths.lostAndFoundAddScreen,
    name: RoutePaths.lostAndFoundAddScreen,
    builder: (context, state) {
      final item = state.extra as LostFoundEntity?;

      return MultiBlocProvider(
        providers: [
          BlocProvider<CommonApiBloc>(
            create: (context) => GetIt.I<CommonApiBloc>(),
          ),
          BlocProvider<LostAndFoundBloc>(
            create: (context) => GetIt.I<LostAndFoundBloc>(),
          ),
        ],
        child: LostAndFoundAddScreen(item: item),
      );
    },
  ),

  GoRoute(
    path: RoutePaths.lostAndFoundChatScreen,
    name: RoutePaths.lostAndFoundChatScreen,
    builder: (context, state) {
      final item = state.extra as Map<String, String?>;
      return ChatScreen(item: item);
    },
  ),

  GoRoute(
    path: RoutePaths.lostAndFoundItemDetails,
    name: RoutePaths.lostAndFoundItemDetails,
    builder: (context, state) {
      final item = state.extra as LostFoundEntity;
      return BlocProvider(
        create: (context) => GetIt.I<LostAndFoundBloc>(),
        child: LostAndFoundItemDetailsScreen(item: item),
      );
    },
  ),

  GoRoute(
    path: RoutePaths.lostAndFound,
    name: 'LostAndFoundFragment',
    builder: (context, state) => BlocProvider(
      create: (context) => GetIt.I<LostAndFoundBloc>(),
      child: const LostAndFoundListScreen(),
    ),
  ),
];
