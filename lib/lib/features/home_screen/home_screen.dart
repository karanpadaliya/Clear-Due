import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/bloc/select_emp_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/chat_list_bloc/chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/bloc/group_chat_bloc/group_chat_bloc.dart';
import 'package:myco_flutter/features/chat/presentation/pages/chat_list.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:myco_flutter/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/bottom_sheets/dashboard_bottom_sheet.dart';
import 'package:myco_flutter/features/home_screen/bloc/bottom_navigation_bar_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/pages/my_profile_page.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreenState extends State<HomeScreen> {
  // BLoCs for each screen
  // final HomeBloc homeBloc = HomeBloc();
  // final CommunityBloc communityBloc = CommunityBloc();
  // final ChatBloc chatBloc = ChatBloc();
  // final ProfileBloc profileBloc = ProfileBloc();

  @override
  void dispose() {
    // Dispose of the BLoCs when the widget is removed from the widget tree
    // homeBloc.close();
    // communityBloc.close();
    // chatBloc.close();
    // profileBloc.close();
    super.dispose();
  }

  // List of screens with their respective BLoC providers
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      BlocProvider(
        create: (context) => GetIt.I<DashboardBloc>(),
        lazy: false,
        child: const DashBoardPage(),
      ),
      const Center(child: Text('Screen 2')),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<ChatListBloc>()),
          BlocProvider(create: (context) => GetIt.I<GroupChatBloc>()),
          BlocProvider(create: (context) => GetIt.I<SelectEmpBloc>()),
          BlocProvider(create: (context) => TabbarBloc()),
        ],
        child: const ChatListScreen(),
      ),

      BlocProvider(
        create: (context) =>
            GetIt.I<MyProfileBloc>()..add(GetProfileDataEvent()),
        child: const MyProfilePage(),
      ),
    ];
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
    builder: (context, state) => Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.getColor(context).surface,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        top: true,
        bottom: false,
        child: IndexedStack(index: state.currentIndex, children: screens),
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, 12),
        child: FloatingActionButton(
          onPressed: () {
            // Get the BLoC instance from GetIt to access the current state
            final dashboardBloc = GetIt.I<DashboardBloc>();
            final dashboardState = dashboardBloc.state;

            // Check if the dashboard has loaded the menu data
            // if (dashboardState is AppMenuGridLoaded) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // Crucial for custom height
              backgroundColor: Colors.transparent,
              // To see rounded corners
              builder: (context) => AnimatedBottomSheet(),
            );
            // } else {
            //   // Optionally, handle the case where data is not yet available
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(content: Text('Menu is loading...')),
            //   );
            // }
          },
          backgroundColor: AppTheme.getColor(context).primary,
          shape: const CircleBorder(),
          child: Image.asset(
            state.isMenuSelected
                ? 'assets/images/menu-selected.png'
                : 'assets/images/menu.png',
            height: 0.03 * Responsive.getHeight(context),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Responsive.getWidth(context) > 600
                  ? Container(
                      height: 65,
                      color: AppTheme.getColor(context).surfaceBright,
                    )
                  : SvgPicture.asset(
                      AppTheme.isAppThemeDarkMode(context)
                          ? AppAssets.bottomBarBgDark
                          : AppAssets.bottomBarBg,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(
                    context,
                    index: 0,
                    text: 'Home',
                    isSelected: state.currentIndex == 0,
                    imagePath: 'assets/images/home.png',
                    selectedImagePath: 'assets/images/home-selected.png',
                  ),
                  navItem(
                    context,
                    index: 1,
                    text: 'Community',
                    isSelected: state.currentIndex == 1,
                    imagePath: 'assets/images/blog.png',
                    selectedImagePath: 'assets/images/blog-selected.png',
                  ),
                  // Community
                  const SizedBox(),
                  // For FAB spacing
                  navItem(
                    context,
                    index: 2,
                    text: 'Chat',
                    isSelected: state.currentIndex == 2,
                    imagePath: 'assets/images/chat.png',
                    selectedImagePath: 'assets/images/chat-selected.png',
                  ),
                  navItem(
                    context,
                    index: 3,
                    text: 'Profile',
                    isSelected: state.currentIndex == 3,
                    imagePath: 'assets/images/user.png',
                    selectedImagePath: 'assets/images/user-selected.png',
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).viewPadding.bottom,
            color: AppTheme.getColor(context).surfaceBright,
          ),
        ],
      ),
    ),
  );

  Widget navItem(
    BuildContext context, {
    required int index,
    required String imagePath,
    required String selectedImagePath,
    required String text,
    required bool isSelected,
  }) => GestureDetector(
    onTap: () {
      context.read<BottomNavigationBarBloc>().add(
        ChangeNavigationIndexEvent(index),
      );
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          isSelected ? selectedImagePath : imagePath,
          height: 26,
          width: 26,
          // height: 0.03 * Responsive.getHeight(context),
          // width: 0.08 * Responsive.getWidth(context),
        ),
        SizedBox(height: 0.005 * Responsive.getHeight(context)),
        CustomText(
          text,
          fontWeight: FontWeight.w700,
          fontSize: 14 * Responsive.getDashboardResponsiveText(context),
          color: isSelected
              ? AppTheme.getColor(context).primary
              : AppTheme.getColor(context).onSurfaceVariant,
        ),
      ],
    ),
  );
}
