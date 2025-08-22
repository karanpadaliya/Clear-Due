import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/chat_list_bloc/chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/group_chat_bloc/group_chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/pages/chat_list.dart';
import 'package:myco_flutter/features/chat/presentation/pages/chat_screen.dart';
import 'package:myco_flutter/features/chat/presentation/pages/group_detail.dart';
import 'package:myco_flutter/features/chat/presentation/pages/select_group_employee.dart';
import 'package:myco_flutter/features/chat/presentation/pages/start_chat.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';

List<RouteBase> chatRoutes = [
  ShellRoute(
    builder: (context, state, child) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<ChatListBloc>()),
        BlocProvider(create: (context) => GetIt.I<GroupChatBloc>()),
        BlocProvider(create: (context) => GetIt.I<SelectEmpBloc>()),
        BlocProvider(create: (context) => TabbarBloc()),
      ],
      child: child,
    ),
    routes: [
      GoRoute(
        path: RoutePaths.chatList,
        name: 'chat-list',
        builder: (context, state) => ChatListScreen(),
      ),
      GoRoute(
        path: RoutePaths.userChatScreen,
        name: 'user-chat',
        builder: (context, state) =>  UserChatScreen(),
      ),
      GoRoute(
        path: RoutePaths.startNewChat,
        name: 'start-new-chat',
        builder: (context, state) => StartNewChat(),
      ),
       GoRoute(
        path: RoutePaths.groupInfo,
        name: 'group-info',
        builder: (context, state) => GroupInfo(),
      ),
      GoRoute(path: RoutePaths.newGroup, name: 'new-group', builder: (context, state) =>  NewGroupScreen()),
    ],
  ),
];
