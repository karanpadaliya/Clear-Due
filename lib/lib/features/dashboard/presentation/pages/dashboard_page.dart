import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/firebase_messaging_service.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/my_unit_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/requests/my_unit_request_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/bloc/Attendance/attendance_bloc.dart';
import 'package:myco_flutter/features/dashboard/presentation/bloc/dashboard_bloc.dart'
    hide AttendanceLoading;
import 'package:myco_flutter/features/dashboard/presentation/widgets/big_home_menu.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/brand_signature_footer/brand_signature_footer.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/dashboard_app_bar.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/moments_section/moments_section.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/my_team/my_team_section.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/quick_access/quick_access_section.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/timer_and_slider.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/upcoming_celebration/upcoming_celebration_section.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/your_department/your_department_section.dart';
import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    getAppMenuGridWithCategory();
    getMyUnits();
    // getAttendanceType();
  }

  Future<void> getAppMenuGridWithCategory() async {
    Future.microtask(() async {
      final prefs = GetIt.I<PreferenceManager>();

      final userId = await prefs.getUserId();
      final companyId = await prefs.getCompanyId();
      final languageId = await prefs.getLanguageId();
      if (!mounted) return;
      // context.read<DashboardBloc>().add(
      //   GetIDCardDetails(
      //     userId: userId,
      //     companyId: companyId,
      //     languageId: languageId,
      //   ),
      // );
      context.read<DashboardBloc>().add(
        GetAppMenuGridWithCategory(
          userId: userId,
          companyId: companyId,
          languageId: languageId,
          society_id: '1',
          city_id: '15449',
          state_id: '1558',
          country_id: '101',
          device: 'android',
          language_id: '1',
          unit_id: '21',
        ),
      );
    });
  }

  Future<void> getMyUnits() async {
    final prefs = GetIt.I<PreferenceManager>();
    final userId = await prefs.getUserId();
    final companyId = await prefs.getCompanyId();
    final languageId = await prefs.getLanguageId();
    final userMobile = await prefs.getUserMobileNo();
    final countryCode = await prefs.getCountryCode();
    String? token = await GetIt.I<FirebaseMessagingService>().getSavedFcmToken();


    context.read<DashboardBloc>().add(
      GetMyUnits(
        request: GetMyUnitsRequest(
          getMultiUnits: 'getMultiUnitsFast',
          userMobile: userMobile,
          countryCode: countryCode,
          userId: userId,
          userToken:token??'',
          companyId: companyId,
          languageId: languageId,
        ),
      ),
    );
  }

  Future<void> getAttendanceType() async {
    final prefs = GetIt.I<PreferenceManager>();
    final userId = await prefs.getUserId() ?? '';
    final companyId = await prefs.getCompanyId() ?? '';
    final unitId = await prefs.getUnitId() ?? '';
    final languageId = await prefs.getLanguageId() ?? '';
    final shiftTimeId = '3';

    // These values would normally be fetched from a location service in a real app.
    // We'll use dummy values for this example.
    final lastFetchLocationLatitude = '0.0';
    final lastFetchLocationLongitude = '0.0';
    final lastFetchLocationAccuracy = '0.0';

    if (!mounted) return;
    context.read<DashboardBloc>().add(
      GetAttendanceType(
        companyId: companyId,
        unitId: unitId,
        registeredUserId: userId,
        languageId: languageId,
        lastFetchLocationLatitude: lastFetchLocationLatitude,
        lastFetchLocationLongitude: lastFetchLocationLongitude,
        lastFetchLocationAccuracy: lastFetchLocationAccuracy,
        shiftTimeId: shiftTimeId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          // Loading State
          if (state is DashboardInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error State
          if (state is DashboardError) {
            return Center(child: Text('Failed to load data: ${state.message}'));
          }

          // Loaded State
          if (state is DashboardLoaded) {
            // This callback ensures the SpeechBloc is updated only after the
            // UI is built, preventing context issues.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                final homeData = state.homeMenuData;
                final List<AppMenuEntity> menuItems = [
                  ...(homeData?.appmenuBig ?? []),
                  ...(homeData?.appmenuHome ?? []),
                  ...(homeData?.appmenu ?? []),
                ];
                context.read<SpeechBloc>().add(SetSpeechMenuData(menuItems));
              }
            });

            // The main layout is a CustomScrollView
            return CustomScrollView(
              slivers: [
                // The new SliverAppBar which provides the hide/show on scroll effect
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // Allows the app bar to become visible as soon as the user scrolls down.
                  floating: true,
                  snap: true,
                  // Removes the default leading back button if it appears
                  automaticallyImplyLeading: false,
                  // Using a flexible space to house our custom app bar widget.
                  flexibleSpace: DashboardAppBar(
                    userName: state.myUnitData?.userFullName ?? '',
                    designation: state.myUnitData?.designation ?? '',
                    profilePictureUrl: state.myUnitData?.userProfilePic ?? '',
                  ),
                  toolbarHeight: Responsive.isTablet(context) ? 65 : 58,
                ),
                // Check for responsive layout and build the appropriate sliver list
                if (Responsive.getWidth(context) > 600)
                  ..._tabViewSlivers(
                    context,
                    state.homeMenuData,
                    state.myUnitData,
                    state.attendanceTypeData,
                  )
                else
                  ..._mobileViewSlivers(
                    context,
                    state.homeMenuData,
                    state.myUnitData,
                    state.attendanceTypeData,
                  ),
              ],
            );
          }

          // Fallback for any other state
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    ),
  );

  /// Returns a list of slivers for the mobile layout.
  List<Widget> _mobileViewSlivers(
    BuildContext context,
    HomeMenuResponseEntity? homeData,
    MyUnitResponseEntity? myUnitData,
    AttendanceTypeResponseEntity? attendanceTypeData,
  ) {
    const verticalSpacing = SliverToBoxAdapter(child: SizedBox(height: 16));

    return [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            BlocProvider(
              create: (_) =>
                  GetIt.I<AttendanceBloc>()..add(const FetchAttendanceData()),
              child: BlocConsumer<AttendanceBloc, AttendanceState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AttendanceLoading) {
                    return punchInAndTimeCard(
                      context: context,
                      attendanceData: AttendanceTypeResponseEntity(),
                    );
                  }
                  if (state is AttendanceStateUpdated) {
                    return punchInAndTimeCard(
                      context: context,
                      attendanceData: state.attendanceData,
                    );
                  }
                  return punchInAndTimeCard(
                    context: context,
                    attendanceData: AttendanceTypeResponseEntity(),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (homeData != null && homeData.slider != null) ...[
              dashboardSlider(context, homeData.slider ?? []),
              const SizedBox(height: 16),
            ],
            if (homeData != null && homeData.appmenuBig != null) ...[
              BigHomeMenu(appMenuBig: homeData.appmenuBig ?? []),
              const SizedBox(height: 16),
            ],
            if (myUnitData != null && myUnitData.myTeam != null) ...[
              MyTeamSection(myTeam: myUnitData.myTeam),
              const SizedBox(height: 16),
            ],
            if (homeData != null && homeData.appmenuHome != null) ...[
              QuickAccessSection(appMenuHome: homeData.appmenuHome),
              const SizedBox(height: 16),
            ],
            if (myUnitData != null) ...[
              if (myUnitData.todayBirthDays != null &&
                  myUnitData.todayBirthDays!.isNotEmpty) ...[
                UpcomingCelebrationSection(
                  birthdays: myUnitData.todayBirthDays,
                ),
                const SizedBox(height: 16),
              ],
              if (myUnitData.member != null &&
                  myUnitData.member!.isNotEmpty) ...[
                YourDepartmentSection(members: myUnitData.member),
                const SizedBox(height: 16),
              ],
              if (myUnitData.eventAlbum != null &&
                  myUnitData.eventAlbum!.isNotEmpty) ...[
                MomentsSection(events: myUnitData.eventAlbum),
                const SizedBox(height: 16),
              ],
              const BrandSignatureFooter(),
            ],
          ],
        ),
      ),
    ];
  }

  /// Returns a list of slivers for the tablet layout.
  List<Widget> _tabViewSlivers(
    BuildContext context,
    HomeMenuResponseEntity? homeData,
    MyUnitResponseEntity? myUnitData,
    AttendanceTypeResponseEntity? attendanceTypeData,
  ) => [
    SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 16),
                BlocProvider(
                  create: (_) =>
                      GetIt.I<AttendanceBloc>()
                        ..add(const FetchAttendanceData()),
                  child: BlocConsumer<AttendanceBloc, AttendanceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is AttendanceLoading) {
                        return punchInAndTimeCard(
                          context: context,
                          attendanceData: AttendanceTypeResponseEntity(),
                        );
                      }
                      if (state is AttendanceStateUpdated) {
                        return punchInAndTimeCard(
                          context: context,
                          attendanceData: state.attendanceData,
                        );
                      }
                      return punchInAndTimeCard(
                        context: context,
                        attendanceData: AttendanceTypeResponseEntity(),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (homeData != null) ...[
                  dashboardSlider(context, homeData.slider ?? []),
                  const SizedBox(height: 16),
                  BigHomeMenu(appMenuBig: homeData.appmenuBig ?? []),
                  const SizedBox(height: 16),
                ],
                if (myUnitData != null) ...[
                  MyTeamSection(myTeam: myUnitData.myTeam),
                  const SizedBox(height: 16),
                  YourDepartmentSection(members: myUnitData.member ?? []),
                  const SizedBox(height: 16),
                  MomentsSection(events: myUnitData.eventAlbum ?? []),
                  const SizedBox(height: 70),
                ],
              ],
            ),
          ),
          const SizedBox(width: 16), // Spacing between columns
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 16),
                if (homeData != null)
                  QuickAccessSection(appMenuHome: homeData.appmenuHome),
                const SizedBox(height: 16),
                if (myUnitData != null)
                  UpcomingCelebrationSection(
                    birthdays: myUnitData.todayBirthDays,
                  ),
                const SizedBox(height: 16),
                const BrandSignatureFooter(),
              ],
            ),
          ),
        ],
      ),
    ),
  ];
}
