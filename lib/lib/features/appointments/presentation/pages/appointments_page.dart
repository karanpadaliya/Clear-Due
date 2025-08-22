import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_appointment_request_model.dart';
import 'package:myco_flutter/features/appointments/data/models/request/get_my_appointments_request_model.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:myco_flutter/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/appointment_requests.dart';
import 'package:myco_flutter/features/appointments/presentation/widgets/my_appointments.dart';
import 'package:myco_flutter/features/custom_bloc/tab-bar/bloc/tabbar_bloc.dart';
import 'package:myco_flutter/features/employees/presentation/pages/employees_screen.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_tabbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/floating_action_btn.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<Widget> screens = [const AppointmentRequests(), const MyAppointments()];
  List<String> appointments = [
    LanguageManager().get('requests'),
    LanguageManager().get('my_appointments'),
  ];
  late PreferenceManager preferenceManager;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    preferenceManager = GetIt.I<PreferenceManager>();
    fetchDataForTab(0);
    fetchDataForTab(1);
  }

  Future<void> fetchDataForTab(int tabIndex) async {
    final userId = await preferenceManager.getUserId();
    final companyId = await preferenceManager.getCompanyId();
    final languageId = await preferenceManager.getLanguageId();

    if (tabIndex == 0) {
      // Requests Tab
      context.read<AppointmentBloc>().add(
        GetAppointmentEvent(
          GetAppointmentRequestModel(
            getAppointments: 'getAppointments',
            userId: userId,
            companyId: companyId,
            languageId: languageId,
          ),
        ),
      );
    } else {
      // My Appointments Tab (tabIndex == 1)
      context.read<AppointmentBloc>().add(
        GetMyAppointmentEvent(
          GetMyAppointmentsRequestModel(
            getMyAppointments: 'getMyAppointments',
            userId: userId,
            companyId: companyId,
            languageId: languageId,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<TabbarBloc, TabbarState>(
    builder: (context, state) {
      final selectedIndex = state is TabChangeState ? state.selectedIndex : 0;

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppbar(title: 'appointments', isKey: true),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                VariableBag.screenHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          child: Column(
            children: [
              MyCustomTabBar(
                tabs: appointments,
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
              CustomSearchField(
                controller: searchController,
                hintText: LanguageManager().get('search'),
                onChanged: (value) {
                  context.read<AppointmentBloc>().add(OnSearchEvent(value));
                },
              ),
              SizedBox(
                height:
                    VariableBag.searchFiledAfterSpace *
                    Responsive.getResponsive(context),
              ),
              Expanded(child: screens[selectedIndex]),
            ],
          ),
        ),
        floatingActionButton: ExpandableFab(
          innericonsize: 30 * Responsive.getResponsive(context),
          imageSize: 50 * Responsive.getResponsive(context),
          onTap: () async {
            final bool? appointmentAdded = await Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (newContext) => BlocProvider.value(
                  value: BlocProvider.of<AppointmentBloc>(context),
                  child: EmployeesScreen(defaultEmployeeScreen: false),
                ),
              ),
            );
            if (appointmentAdded == true) {
              context.read<TabbarBloc>().add(const TabChangeEvent(index: 1));
              fetchDataForTab(1);
            }
          },
          openIcon: Icons.add,
          closeIcon: Icons.close,
          actions: const [],
        ),
      );
    },
  );
}
