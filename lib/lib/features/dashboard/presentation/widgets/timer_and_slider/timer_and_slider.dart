import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/features/dashboard/data/models/requests/attendance_requests.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/attendance_type_response_entity.dart';
import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
import 'package:myco_flutter/features/dashboard/presentation/bloc/Attendance/attendance_bloc.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/bottom_sheets/attendance_info_bottom_sheet.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/custom_timer.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/dashboard_warning_widget.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/timer_and_slider/interactive_slider_overlay.dart';
import 'package:myco_flutter/widgets/border_container_wraper.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

Widget dashboardSlider(BuildContext context, List<SliderEntity> slider) =>
    // Responsive.getWidth(context) > 600
    //     ? Row(
    //         children: [
    //           punchInAndTimeCard(context: context),
    //           CustomSlider(
    //             width: Responsive.getWidth(context) / 2,
    //             imagePaths: [AppAssets.mycobanner, AppAssets.mycobanner1],
    //           ),
    //         ],
    //       )
    //     :
    Column(
      children: [
        // punchInAndTimeCard(
        //   context: context,
        //   homeMenuResponse: homeMenuResponse,
        // ),

        // Interactive inline overlay instead of navigation
        if (slider.isNotEmpty)
          InteractiveSliderOverlay(
            sliders: slider,
            height: 150 * Responsive.getDashboardResponsive(context),
          ),
      ],
    );

Widget punchInAndTimeCard({
  required BuildContext context,
  required AttendanceTypeResponseEntity? attendanceData,
}) {
  // Key Change: Provide a non-zero default value for maxMinutes.
  // When attendanceData is null, perDayHourMinutes will be null.
  // The expression '0' ?? '0' will be evaluated, parsed to 0, and then the
  // second '?? 60' will kick in, setting maxMinutes to 60.
  // This ensures the painter always has a positive value to work with.
  final double maxMinutes =
      (double.tryParse(attendanceData?.perDayHourMinutes ?? '0') ?? 60);

  // currentMinutes can safely be 0 initially.
  final double currentMinutes =
      (double.tryParse(attendanceData?.timeDiffSeconds ?? '0') ?? 0) / 60;

  // The rest of the logic remains the same
  final bool isPunchIn =
      attendanceData?.attendanceId != null &&
      attendanceData!.attendanceId!.isNotEmpty &&
      attendanceData.attendanceId != '0';
  final bool isBreakRunning =
      attendanceData?.attendanceBreakHistoryId != null &&
      attendanceData!.attendanceBreakHistoryId!.isNotEmpty &&
      attendanceData.attendanceBreakHistoryId != '0';

  final bool isPunchInOutEnabled =
      attendanceData?.attendanceTypeField != '5' && !isBreakRunning;
  final bool isBreakButtonEnabled = isPunchIn && !isBreakRunning;

  const int countPendingSync = 0;

  final bool isPunchOutLimited =
      (attendanceData?.punchOutLimit ?? false) &&
      (attendanceData?.isToday ?? false);
  final String punchOutLimitMessage = attendanceData?.message ?? '';

  final bool isAttendanceRejected =
      attendanceData?.isAttendanceRejected ?? false;
  final String attendanceRejectedMessage =
      attendanceData?.attendanceRejectedMessage ?? '';

  final bool isYesterdayPunchOutMissing =
      attendanceData?.yesterdayPunchOutMissing ?? false;
  final String yesterdayPunchOutMissingMsg =
      attendanceData?.yesterdayPunchOutMissingMsg ?? '';

  final bool isAlreadyPunchOut = attendanceData?.alreadyPunchOut ?? false;
  final String alreadyPunchOutMsg = attendanceData?.alreadyPunchOutMsg ?? '';

  final String punchInButtonText = isPunchIn ? 'punch_out' : 'punch_in';
  final String breakButtonText = isBreakRunning
      ? 'end_a_break'
      : 'take_a_break';

  // Logic for CustomTimer Color Ranges based on native code
  final List<ColorRange> colorRanges = [];
  if (attendanceData?.breaks != null && maxMinutes > 0) {
    for (final breakRange in attendanceData!.breaks!) {
      // 1. Parse color from hex string
      final Color color = Color(
        int.parse('0xff${breakRange.breakColor?.substring(1) ?? 'FFFFFF'}'),
      );

      // 2. Parse start and end values as percentages
      final double startPercentage =
          double.tryParse(breakRange.startMinutes ?? '0') ?? 0;
      final double endPercentage =
          double.tryParse(breakRange.endMinutes ?? '0') ?? 0;

      // 3. Calculate the absolute start and end minutes from the percentages
      // This matches the logic from the Java `PercentageToMinute` function, but correctly results in minutes.
      final double startRangeMinutes = (startPercentage * maxMinutes) / 100;
      final double endRangeMinutes = (endPercentage * maxMinutes) / 100;

      // 4. Add the calculated ColorRange to the list
      colorRanges.add(ColorRange(startRangeMinutes, endRangeMinutes, color));
    }
  }

  return Column(
    children: [
      /// Dashboard Warning Messages based on various conditions
      if (countPendingSync > 0)
        DashboardWarningWithMessage(
          message: 'Attendance or breaks pending for sync: $countPendingSync',
          backgroundColor: Util.applyOpacity(
            AppTheme.getColor(context).error,
            0.4,
          ),
          textColor: AppTheme.getColor(context).error,
        ),
      if (isYesterdayPunchOutMissing)
        DashboardWarningWithMessage(
          message: yesterdayPunchOutMissingMsg,
          backgroundColor: Util.applyOpacity(
            AppTheme.getColor(context).onTertiaryContainer,
            0.3,
          ),
          textColor: AppTheme.getColor(context).onTertiaryContainer,
        ),
      if (isAttendanceRejected)
        DashboardWarningWithMessage(
          message: attendanceRejectedMessage,
          backgroundColor: Util.applyOpacity(
            AppTheme.getColor(context).onTertiaryContainer,
            0.3,
          ),
          textColor: AppTheme.getColor(context).onTertiaryContainer,
        ),
      if (isAlreadyPunchOut)
        DashboardWarningWithMessage(
          message: alreadyPunchOutMsg,
          backgroundColor: Util.applyOpacity(
            AppTheme.getColor(context).onTertiaryContainer,
            0.3,
          ),
          textColor: AppTheme.getColor(context).onTertiaryContainer,
        ),
      if (isPunchOutLimited)
        DashboardWarningWithMessage(
          message: punchOutLimitMessage,
          backgroundColor: Util.applyOpacity(
            AppTheme.getColor(context).onTertiaryContainer,
            0.3,
          ),
          textColor: AppTheme.getColor(context).onTertiaryContainer,
        ),
      const SizedBox(height: 12),

      /// Punch In/Out and Break Buttons with Live Clock and Refresh Button
      BorderContainerWraper(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Live Clock and BarCode scanner and Refresh Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LiveClock(isAppBar: false),
                Row(
                  children: [
                    if (attendanceData?.attendanceTypeField != '0' &&
                        attendanceData?.attendanceTypeField != '1')
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SvgPicture.asset(AppAssets.scanQR),
                      ),
                    GestureDetector(
                      onTap: () async {
                        if (context.mounted) {
                          context.read<AttendanceBloc>().add(
                            const FetchAttendanceData(),
                          );
                        }
                      },
                      child: SvgPicture.asset(AppAssets.refresh),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // CustomTimer widget with the corrected maxMinutes
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      builder: (BuildContext innerContext) =>
                          AttendanceInfoBottomSheet(
                            attendanceData: attendanceData,
                            maxMinutes: maxMinutes,
                            currentMinutes: currentMinutes,
                            colorRanges: colorRanges,
                          ),
                    );
                  },
                  child: CustomTimer(
                    timerHeight: 150,
                    timerWidth: 150,
                    maxMinutes: maxMinutes,
                    minutesPerSegment: 60,
                    initialMinutes: currentMinutes,
                    primaryColor: [
                      AppTheme.getColor(context).secondary,
                      // AppTheme.getColor(context).primary,
                    ],
                    backgroundColor: AppTheme.getColor(
                      context,
                    ).onPrimaryContainer,
                    colorRanges: colorRanges,
                  ),
                ),
                SizedBox(
                  width:
                      VariableBag.shadowContainerVerticalPadding *
                      Responsive.getDashboardResponsive(context),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      // Punch In/Out button
                      MyCoButton(
                        title: punchInButtonText,
                        textStyle: TextStyle(
                          fontFamily: Util.getFontFamily(FontWeight.w600),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              16 *
                              Responsive.getDashboardResponsiveText(context),
                          color: AppTheme.getColor(context).onSecondary,
                        ),

                        onTap: isPunchInOutEnabled
                            ? isPunchIn
                                  ? () {
                                      final request = const AttendancePunchOutRequest(
                                        attendanceId: '0',
                                        companyId:
                                            '1', // Replace with actual data
                                        unitId:
                                            '21', // Replace with actual data
                                        floorId: '1',
                                        blockId: '1',
                                        levelId: '1',

                                        userId:
                                            '1993', // Replace with actual data
                                        userName:
                                            'Arshad Shaikh', // Replace with actual data
                                        languageId: '1',
                                        punchOutLatitude: '0.0',
                                        punchOutLongitude: '0.0',
                                      );
                                      context.read<AttendanceBloc>().add(
                                        PunchOutRequested(request: request),
                                      );
                                    }
                                  : () {
                                      final request = const AttendancePunchInRequest(
                                        attendanceId: '0',
                                        companyId:
                                            '1', // Replace with actual data
                                        unitId:
                                            '21', // Replace with actual data
                                        floorId: '1',
                                        blockId: '1',
                                        levelId: '1',

                                        userId:
                                            '1993', // Replace with actual data
                                        userName:
                                            'Arshad Shaikh', // Replace with actual data
                                        languageId: '1',
                                        shiftTimeId: '3',
                                        punchInLatitude: '0.0',
                                        punchInLongitude: '0.0',
                                        dayType: '0',
                                        attendanceReason: '',
                                        // needApproval: 'true',
                                      );
                                      context.read<AttendanceBloc>().add(
                                        PunchInRequested(request: request),
                                      );
                                    }
                            : null,
                        // width: 180 * Responsive.getDashboardResponsive(context),
                        height: 44 * Responsive.getDashboardResponsive(context),
                        boarderRadius: 7,
                        image: SvgPicture.asset(AppAssets.punchIn),
                        spacing: 10,
                        isTimecardbutton: true,
                        imagePosition: AxisDirection.right,
                        backgroundColor: AppTheme.getColor(context).secondary,
                        isShadowTopLeft: true,
                        wantBorder: false,
                      ),

                      // Take a Break button
                      MyCoButton(
                        title: breakButtonText,
                        textStyle: TextStyle(
                          fontFamily: Util.getFontFamily(FontWeight.w600),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              16 *
                              Responsive.getDashboardResponsiveText(context),
                          color: AppTheme.getColor(context).onSecondary,
                        ),
                        imagePosition: AxisDirection.right,
                        // width: 180 * Responsive.getDashboardResponsive(context),
                        height: 44 * Responsive.getDashboardResponsive(context),
                        boarderRadius: 7,
                        onTap: isBreakButtonEnabled ? () {} : null,
                        spacing: 10,
                        backgroundColor: AppTheme.getColor(
                          context,
                        ).onTertiaryContainer,
                        isShadowTopLeft: true,
                        wantBorder: false,
                        isTimecardbutton: true,
                      ),

                      // My Timecard button
                      MyCoButton(
                        title: 'my_timecard',
                        textStyle: TextStyle(
                          fontFamily: Util.getFontFamily(FontWeight.w600),
                          fontWeight: FontWeight.w600,
                          fontSize:
                              16 *
                              Responsive.getDashboardResponsiveText(context),
                          color: AppTheme.getColor(context).onSecondary,
                        ),
                        onTap: () {
                          context.pushNamed(RoutePaths.timeSheet);
                        },
                        image: SvgPicture.asset(AppAssets.timeCardBtn),
                        imagePosition: AxisDirection.right,
                        // width: 180 * Responsive.getDashboardResponsive(context),
                        height: 44 * Responsive.getDashboardResponsive(context),
                        boarderRadius: 7,
                        backgroundColor: AppTheme.getColor(context).primary,
                        isShadowTopLeft: true,
                        wantBorder: false,
                        isTimecardbutton: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class LiveClock extends StatefulWidget {
  final bool isAppBar;
  final double? fontSize;
  final FontWeight? fontWeight;
  // final Color? color;

  const LiveClock({
    required this.isAppBar,
    super.key,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _updateTime(),
    );
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat(
      widget.isAppBar ? 'dd-MM-yyyy hh:mm:ss a' : 'hh:mm a dd-MM-yyyy',
    ).format(now);
    if (mounted) {
      setState(() {
        _timeString = formattedTime;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomText(
    _timeString,
    fontSize: widget.fontSize ?? 13 * Responsive.getResponsiveText(context),
    fontWeight: widget.fontWeight ?? FontWeight.w500,
  );
}
