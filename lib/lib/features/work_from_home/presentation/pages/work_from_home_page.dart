import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/my_wfh_history.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/wfh_add_new.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';

class WorkFromHomePage extends StatefulWidget {
  const WorkFromHomePage({super.key});

  @override
  State<WorkFromHomePage> createState() => _WorkFromHomePageState();
}

class _WorkFromHomePageState extends State<WorkFromHomePage> {
  final List<Widget> screens = [const WfhAddNew(), const MyWfhListPage()];
  final List<String> wfhTabs = [
    LanguageManager().get('add_new'),
    LanguageManager().get('history'),
  ];

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TabbarBloc, TabbarState>(
    builder: (context, state) {
      final selectedIndex = state is TabChangeState ? state.selectedIndex : 0;

      if (_pageController.hasClients &&
          _pageController.page?.round() != selectedIndex) {
        _pageController.animateToPage(
          selectedIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }

      return Scaffold(
        appBar: const CustomAppbar(title: 'work_from_home', isKey: true),
        body: Column(
          children: [
            MyCustomTabBar(
              tabs: wfhTabs,
              selectedBgColors: [
                AppTheme.getColor(context).primary,
                AppTheme.getColor(context).secondary,
              ],
              unselectedBorderAndTextColor: AppTheme.getColor(
                context,
              ).secondary,
              tabBarBorderColor: AppTheme.getColor(context).primary,
              isShadowBottomLeft: true,
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                context.read<TabbarBloc>().add(TabChangeEvent(index: index));
              },
            ),
            SizedBox(
              height:
                  VariableBag.tabBarAfterSpace *
                  Responsive.getResponsive(context),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<TabbarBloc>().add(TabChangeEvent(index: index));
                },
                children: screens,
              ),
            ),
          ],
        ),
      );
    },
  );
}
