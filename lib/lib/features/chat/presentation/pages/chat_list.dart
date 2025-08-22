import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/chat_list_bloc/chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/group_chat_bloc/group_chat_bloc.dart';

import 'package:myco_flutter/features/chat/presentation/widgets/chat_list_card.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/shimmers/chatList_card_skeleton.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final List<Widget> screens = [const EmployeesChat(), const GroupChat()];
  @override
  void initState() {
    super.initState();
    // Fetch data if it's not already in the state
    context.read<ChatListBloc>().add(GetMemberChatListEvent());
    context.read<GroupChatBloc>().add(GetGroupChatListEvent());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 0.11 * Responsive.getHeight(context)),
          child: FloatingActionButton(
            onPressed: () {
              context.pushNamed('start-new-chat');
            },
            backgroundColor: AppTheme.getColor(context).primary,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              'assets/chat/message.svg',
              width: 0.08 * Responsive.getWidth(context),
            ),
          ),
        ),
        appBar: CustomAppbar(
          title: 'chat',
          titleSpacing: 10,
          actions: [
            MyCoButton(
              onTap: () {
                context.pushNamed('new-group');
              },
              title: LanguageManager().get('new_group'),
              textStyle: TextStyle(
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 14 * Responsive.getResponsiveText(context),
              ),
              image: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset('assets/chat/plus.svg'),
              ),
              imagePosition: AxisDirection.right,
              width: 0.35 * Responsive.getWidth(context),
              height: 0.028 * Responsive.getHeight(context),
              boarderRadius: 20 * Responsive.getResponsive(context),
              isShadowBottomLeft: true,
            ),
            SizedBox(width: 0.02 * Responsive.getWidth(context)),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 0.06 * Responsive.getWidth(context),
          ),
          child: Column(
            children: [
              BlocBuilder<TabbarBloc, TabbarState>(
                builder: (context, state) {
                  final selectedIndex =
                      state is TabChangeState ? state.selectedIndex : 0;
                  return MyCustomTabBar(
                    tabs: [
                      LanguageManager().get('resident'),
                      LanguageManager().get('group_colon'),
                    ],
                    selectedBgColors: [
                      AppTheme.getColor(context).secondary,
                      AppTheme.getColor(context).primary,
                    ],
                    unselectedBorderAndTextColor:
                        AppTheme.getColor(context).onPrimary,
                    tabBarBorderColor: AppTheme.getColor(context).onSurface,
                    tabBarBackgroundColor: AppTheme.getColor(context).surface,
                    isShadowBottomLeft: true,
                    selectedIndex: selectedIndex,
                    onTabChange: (index) {
                      context
                          .read<TabbarBloc>()
                          .add(TabChangeEvent(index: index));
                    },
                  );
                },
              ),
              SizedBox(height: 0.03 * Responsive.getHeight(context)),
              Expanded(
                child: BlocBuilder<TabbarBloc, TabbarState>(
                  builder: (context, state) {
                    final selectedIndex =
                        state is TabChangeState ? state.selectedIndex : 0;
                    return screens[selectedIndex];
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

class EmployeesChat extends StatelessWidget {
  const EmployeesChat({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CustomSearchField(
            hintText: 'search_member',
            onChanged: (value) {
              context.read<ChatListBloc>().add(SearchMemberEvent(value));
            },
          ),
          SizedBox(height: 0.025 * Responsive.getHeight(context)),
          Expanded(
            child: BlocBuilder<ChatListBloc, ChatListState>(
              // Rebuild only when chat list data or loading status changes
              buildWhen: (previous, current) =>
                  previous.filteredMemberChatList !=
                      current.filteredMemberChatList ||
                  previous.isLoadingMemberChatList !=
                      current.isLoadingMemberChatList,
              builder: (context, state) {
                log(state.toString(), name: 'Bloc State');

                if (state.isLoadingMemberChatList &&
                    state.memberChatList == null) {
                  return ListView.separated(
                    itemCount: 5,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) => const ChatListCardSkeleton(),
                  );
                }

                if (state.error != null && state.memberChatList == null) {
                  return const Center(child: Text("Error loading chat list"));
                }

                final memberList = state.filteredMemberChatList ?? [];

                if (memberList.isEmpty) {
                  return const Center(child: Text("No Data Found"));
                }

                return ListView.separated(
                  itemCount: memberList.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: 30 * Responsive.getResponsive(context)),
                  itemBuilder: (_, index) {
                    final member = memberList[index];
                    final to_user_id = member.userId ?? '';
                    log(to_user_id.toString(), name: 'user_id');
                    return ChatListCard(
                      name: member.userFullName ?? '',
                      lastMessage: member.msgData ?? '',
                      timeAgo: member.msgDate?.toString() ?? '',
                      profileImagePath: member.userProfilePic ?? '',
                      onTap: () {
                        context.pushNamed('user-chat',extra: to_user_id);
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
        ],
      );
}

// Keep GroupChat the same as it uses a different BLoC
class GroupChat extends StatelessWidget {
  const GroupChat({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocBuilder<GroupChatBloc, GroupChatState>(
            builder: (context, state) => CustomSearchField(
              hintText: 'search_member',
              onChanged: (value) => {
                context.read<GroupChatBloc>().add(SearchEventGroup(value)),
                log(state.toString(), name: 'state'),
              },
            ),
          ),
          SizedBox(height: 0.025 * Responsive.getHeight(context)),
          BlocBuilder<GroupChatBloc, GroupChatState>(
            builder: (context, state) {
              if (state is GetGroupChatListLoadingState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (_, index) => const ChatListCardSkeleton(),
                  ),
                );
              }

              if (state is GetGroupChatListErrorState) {
                return Center(child: Text(state.message));
              }

              if (state is GetGroupChatListSuccessState ||
                  state is GroupSearchQueryState) {
                final groupChatList = state is GetGroupChatListSuccessState
                    ? state.groupChatList
                    : null;

                final list = state is GroupSearchQueryState
                    ? state.filteredListGroup
                    : groupChatList?.member ?? [];

                if (list.isEmpty) {
                  return const Center(child: Text('No Data Found'));
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final member = list[index];
                      return ChatListCard(
                        isSufixIcon: true,
                        name: member?.topicName ?? '',
                        lastMessage: member?.msgData ?? '',
                        timeAgo: member?.createdDate ?? '',
                        profileImagePath: member?.userProfilePic ??
                            'https://avatar.iran.liara.run/public/1',
                        onTap: () {
                          context.pushNamed('user_id',extra: member?.chatId);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                        height: 30 * Responsive.getResponsive(context)),
                  ),
                );
              }
              return const Center(child: Text('No Data Found'));
            },
          ),
          SizedBox(height: 0.02 * Responsive.getHeight(context)),
        ],
      );
}
