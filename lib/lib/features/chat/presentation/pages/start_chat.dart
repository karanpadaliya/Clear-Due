import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/chat_list_bloc/chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/shimmers/skeleton_employee_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_simple_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class StartNewChat extends StatefulWidget {
  const StartNewChat({super.key});

  @override
  State<StartNewChat> createState() => _StartNewChatState();
}

class _StartNewChatState extends State<StartNewChat> {
  final TextEditingController branchController = TextEditingController();
  Map<String, String> selectedDepartments = {};

  @override
  void initState() {
    super.initState();
    // Use the single ChatListBloc to fetch data
    context.read<ChatListBloc>().add(GetMemberListEvent('0'));
    context.read<ChatListBloc>().add(GetAllDepartmentsEvent());
  }

  void _openDepartmentPicker(departments) async {
    final selectedId = await showCustomSimpleBottomSheet(
      context: context,
      heading: 'Select Branch',
      icon: 'assets/chat/Frame.svg',
      dataList: departments,
    );
    log(selectedId.toString(), name: "selectedId");
    if (selectedId != null) {
      setState(() {
        selectedDepartments = selectedId;
        branchController.text = selectedId['name'] ?? '';
      });
      log(selectedId.toString(), name: 'selectedMap');
      context.read<ChatListBloc>().add(
            GetMemberListEvent(selectedId['id'].toString()),
          );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomAppbar(title: 'chat'),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 22.0 * Responsive.getResponsive(context),
          ),
          child: Column(
            children: [
              CustomSearchField(
                hintText: 'search_employee',
                onChanged: (value) {
                  // Use the SearchEvent for the full member list
                  context.read<ChatListBloc>().add(SearchEvent(value));
                },
              ),
              SizedBox(height: 30 * Responsive.getResponsive(context)),
              BlocBuilder<ChatListBloc, ChatListState>(
                // Rebuild only when department data changes
                buildWhen: (previous, current) =>
                    previous.allDepartmentsList != current.allDepartmentsList,
                builder: (context, state) => NewTextField(
                  controller: branchController,
                  maxLines: 1,
                  enabled: true,
                  hintText: selectedDepartments.isEmpty
                      ? LanguageManager().get('select_block')
                      : selectedDepartments['name'] ?? '',
                  suffixIconPath: 'assets/chat/chevron-down.svg',
                  onTap: () {
                    if (state.isLoadingDepartments) {
                      // Optionally show a small indicator
                      return;
                    }
                    if (state.allDepartmentsList != null) {
                      final departmentsList = state
                          .allDepartmentsList!.departments
                          .map(
                            (e) => {
                              'name': e.departmentName.toString(),
                              'id': e.floorId.toString(),
                              'blockId': e.blockId.toString(),
                            },
                          )
                          .toList();
                      _openDepartmentPicker(departmentsList);
                    }
                  },
                ),
              ),
              SizedBox(height: 16 * Responsive.getResponsive(context)),
              Expanded(
                child: BlocBuilder<ChatListBloc, ChatListState>(
                  // Rebuild only when the full member list or its loading state changes
                  buildWhen: (previous, current) =>
                      previous.filteredFullMemberList !=
                          current.filteredFullMemberList ||
                      previous.isLoadingFullMemberList !=
                          current.isLoadingFullMemberList,
                  builder: (context, state) {
                    if (state.isLoadingFullMemberList) {
                      return const Center(
                        child: SkeletonEmployeeGrid(),
                      );
                    }
                    if (state.error != null && state.fullMemberList == null) {
                      return Center(child: Text(state.error!));
                    }

                    final memberList = state.filteredFullMemberList ?? [];

                    if (memberList.isEmpty) {
                      return const Center(child: Text('No Members Found'));
                    }
                    return GridView.builder(
                      padding: EdgeInsets.all(
                          10 * Responsive.getResponsive(context)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            Responsive.getGridConfig(context).itemCount,
                        mainAxisSpacing:
                            Responsive.getGridConfig(context).spacing,
                        crossAxisSpacing:
                            Responsive.getGridConfig(context).spacing,
                        childAspectRatio: 2 / 2.7,
                      ),
                      itemCount: memberList.length,
                      itemBuilder: (context, index) {
                        final member = memberList[index];
                        return StartNewChatProfileCard(
                          name: member.userFirstName ?? '',
                          departments: member.floorName ?? '',
                          imagePath: member.userProfilePic ??
                              'https://avatar.iran.liara.run/public/1',
                          onTap: () => context.pushNamed('user-chat'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

class StartNewChatProfileCard extends StatelessWidget {
  final String name;
  final String departments;
  final VoidCallback? onTap;
  final String? imagePath;
  const StartNewChatProfileCard({
    super.key,
    this.name = '',
    this.departments = '',
    this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap ??
          () {
            context.pushNamed('user-chat');
          },
      child: Container(
        height: 0.28 * Responsive.getHeight(context),
        width: 0.3 * Responsive.getWidth(context),
        decoration: BoxDecoration(
          color: AppTheme.getColor(context).background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppTheme.getColor(context).primary,
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 0.018 * Responsive.getHeight(context)),
              CachedNetworkImage(
                imageUrl: imagePath ?? 'https://avatar.iran.liara.run/public/1',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 32 * Responsive.getResponsive(context),
                  backgroundImage: imageProvider,
                  backgroundColor: AppTheme.getColor(context).onPrimary,
                ),
                placeholder: (context, url) => CircleAvatar(
                  radius: 32 * Responsive.getResponsive(context),
                  child: const CircularProgressIndicator(strokeWidth: 1.5),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 32 * Responsive.getResponsive(context),
                  child:
                      Image.network('https://avatar.iran.liara.run/public/1'),
                ),
              ),
              SizedBox(height: 0.01 * Responsive.getHeight(context)),
              CustomText(
                textAlign: TextAlign.center,
                name,
                fontWeight: FontWeight.w600,
                fontSize: 16 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
              ),
              CustomText(
                textAlign: TextAlign.center,
                departments,
                fontSize: 14 * Responsive.getResponsiveText(context),
                color: AppTheme.getColor(context).onSurface,
              ),
            ],
          ),
        ),
      ),
    );
}
