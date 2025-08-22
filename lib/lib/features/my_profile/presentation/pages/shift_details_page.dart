 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/shift_details_request_model.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/week_off_item.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_bloc.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_event.dart';
import 'package:myco_flutter/features/my_profile/presentation/bloc/my_profile_state.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/break_details_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/shift_details_card.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/shift_details_top_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:shimmer/shimmer.dart';

class ShiftDetailsPage extends StatefulWidget {
  const ShiftDetailsPage({super.key});

  @override
  State<ShiftDetailsPage> createState() => _ShiftDetailsPageState();
}

class _ShiftDetailsPageState extends State<ShiftDetailsPage> {
  @override
  void initState() {
    super.initState();
    getShiftDetails();
  }

  List<WeekOffItem> toWeekOffItemList(List<Map<String, String>> items) =>
      items.map(WeekOffItem.fromMap).toList();

  Future<void> getShiftDetails() async {
    final preferenceManager = GetIt.I<PreferenceManager>();
    final companyId = await preferenceManager.getCompanyId();
    final userId = await preferenceManager.getUserId();
    final languageId = await preferenceManager.getLanguageId();
    final request = ShiftDetailsRequestModel(
      tag: 'getMyShift',
      companyId: companyId,
      languageId: languageId,
      userId: '1654',
      shiftTimeId: '',
      alterShift: '0',
    );

    if (mounted) {
      context.read<MyProfileBloc>().add(FetchShiftDetailsEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      isKey: true,
      title: 'shift_details',
      titleSpacing: 0,
      actionsPadding: EdgeInsets.only(
        right: 30.0 * Responsive.getResponsive(context),
      ),
      actions: [
        MyCoButton(
          width: 0.185 * Responsive.getWidth(context),
          height: 0.031 * Responsive.getHeight(context),
          onTap: () {},
          boarderRadius: 30 * Responsive.getResponsive(context),
          isShadowBottomLeft: true,
          title: LanguageManager().get('change'),
        ),
      ],
    ),
    body: Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            VariableBag.screenHorizontalPadding *
            Responsive.getResponsive(context),
        vertical:
            VariableBag.formContentSpacingVertical *
            Responsive.getResponsive(context),
      ),
      child: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          if (state is InitialMyProfileState ||
              state is FetchProfileDataLoadingState) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (_, __) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 80,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.getColor(context).onPrimary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            );
          } else if (state is ShiftDetailsLoadedState) {
            final weekOff = [
              {
                'title': LanguageManager().get('has_auto_weekoff_shift'),
                'value': state.entity.hasAutoWeekOff.toString(),
              },
              {
                'title': LanguageManager().get('weekoff_allowed_shift'),
                'value': state.entity.autoWeekOffCount.toString(),
              },
              {
                'title': LanguageManager().get('week_off'),
                'value': state.entity.dayNamesView.toString(),
              },
              {
                'title': LanguageManager().get('alternate_week_off'),
                'value': state.entity.hasAltenateWeekOff.toString(),
              },
              {
                'title': LanguageManager().get('alternate_weeks'),
                'value': state.entity.alternateWeekOff.toString(),
              },
            ];

            final leave = [
              {
                'title': LanguageManager().get('paidLeaveOnExtDay_shift'),
                'value': state.entity.paidLeaveOnExtraDay.toString(),
              },
              {
                'title': LanguageManager().get('extraleave_expire_shift'),
                'value': state.entity.extraDayLeaveExpireDays.toString(),
              },
              {
                'title': LanguageManager().get('appli_extraleave_shift'),
                'value': state.entity.applicableExtraDayLeavesInMonth
                    .toString(),
              },
              {
                'title': LanguageManager().get('pastdate_leave_allow_shift'),
                'value': state.entity.allowCompOffLeaveOnPastDate.toString(),
              },
            ];

            final calculateLeave = [
              {
                'title': LanguageManager().get(
                  'calculate_leave_balance_on_present_days',
                ),
                'value': state.entity.calculateLeaveBalance.toString(),
              },
              {
                'title': LanguageManager().get(
                  'calculate_leave_balance_after_present_days',
                ),
                'value': state.entity.calculateLeaveBalanceAfterDays.toString(),
              },
            ];

            final punchInReason = [
              {
                'title': LanguageManager().get('multi_punchin_allowed'),
                'value': state.entity.isMultiplePunchIn.toString(),
              },
              {
                'title': LanguageManager().get('late_in_reason_shift'),
                'value': state.entity.lateInReason.toString(),
              },
              {
                'title': LanguageManager().get('early_out_reason_req'),
                'value': state.entity.earlyOutReason.toString(),
              },
              {
                'title': LanguageManager().get('punchin_out_range_shift'),
                'value': state.entity.takeOutOfRangeReason.toString(),
              },
            ];

            final shortLeavePolicy = [
              {
                'title': LanguageManager().get('short_leaves'),
                'value': state.entity.allowShortLeave.toString(),
              },
              {
                'title': LanguageManager().get('monthlyshortleave'),
                'value': state.entity.monthlyShortLeave.toString(),
              },
              {
                'title': LanguageManager().get('shortleaveminutes'),
                'value': state.entity.shortLeaveMinutes.toString(),
              },

              {
                'title': LanguageManager().get('short_leave_apply_type'),
                'value': state.entity.shortLeaveApplyType.toString(),
              },
              {
                'title': LanguageManager().get('buffershortleaveminute'),
                'value': state.entity.shortLeaveBufferMinutes.toString(),
              },
              {
                'title': LanguageManager().get('short_leave_days'),
                'value': state.entity.shortLeaveDays.toString(),
              },
              {
                'title': LanguageManager().get('sandwich_leaves'),
                'value': state.entity.sandwichLeaveApply.toString(),
              },
            ];

            final breakManagement = [
              {
                'title': LanguageManager().get('takebreak_sett_shift'),
                'value': state.entity.takeBreaksSetting.toString(),
              },
              {
                'title': LanguageManager().get(
                  'take_break_with_approval_in_face_app',
                ),
                'value': state.entity.takeBreakWithApprovalFaceApp.toString(),
              },
              {
                'title': LanguageManager().get(
                  'take_break_with_approval_in_employee_app',
                ),
                'value': state.entity.takeBreakWithApprovalEmployeeApp
                    .toString(),
              },
            ];

            final attandanceManagement = [
              {
                'title': LanguageManager().get('hours_type_in_shift_clock'),
                'value': state.entity.hoursTypeInShiftClock.toString(),
              },
              {
                'title': LanguageManager().get(
                  'attendance_calculation_on_productive_hours',
                ),
                'value': state.entity.attendanceCalculationOnProductiveHours
                    .toString(),
              },
              {
                'title': LanguageManager().get(
                  'remove_break_time_if_not_taken',
                ),
                'value': state.entity.removeBreakTimeIfNotTaken.toString(),
              },
              {
                'title': LanguageManager().get(
                  'deduct_full_break_time_if_less_taken',
                ),
                'value': state.entity.deductFullBreakTimeIfLessTaken.toString(),
              },
            ];

            final penalities = [
              {
                'title': LanguageManager().get('penalty_on_absent'),
                'value': state.entity.penaltyOnAbsent.toString(),
              },
              {
                'title': LanguageManager().get('penalty_type'),
                'value': state.entity.penaltyTypeOnAbsent.toString(),
              },
              {
                'title': LanguageManager().get('penalty_value'),
                'value': state.entity.penaltyAmountAbsent.toString(),
              },
            ];

            final approvalRequirement = [
              {
                'title': LanguageManager().get('need_approval_for_extra_day'),
                'value': state.entity.needOtRequestForWorkingDays.toString(),
              }, //not getting  from api
              {
                'title': LanguageManager().get('need_approval_for_extra_hours'),
                'value': state.entity.needOtRequest
                    .toString(), //not getting extra hours from api
              },
            ];

            final shiftHours = [
              {
                'title': LanguageManager().get(
                  'add_compoff_leave_on_extra_hours_after_shift_hours_completed_working_days',
                ),
                'value': state.entity.allowCompOffLeaveOnPastDate
                    .toString(), //in api not getting
              },
              {
                'title': LanguageManager().get(
                  'after_shift_hour_minimum_hours_for_half_day',
                ),
                'value': state.entity.minumumHalfHours.toString(),
              },
              {
                'title': LanguageManager().get(
                  'after_shift_hour_minimum_hours_for_full_day',
                ),
                'value': state.entity.minumumFullHours.toString(),
              },
            ];

            final weelOffPenalty = [
              {
                'title': LanguageManager().get(
                  'apply_leave_on_holiday_week_off',
                ),
                'value': state.entity.applyHolidayLeave.toString(),
              },
              {
                'title': LanguageManager().get('apply_leave_on_weekoff'),
                'value': state.entity.applyWeekoffLeave.toString(),
              },
              {
                'title': LanguageManager().get(
                  'holiday_penalty_apply_if_holiday_leave_not_applied',
                ),
                'value': state.entity.holidayPenaltyApply.toString(),
              },
              {
                'title': LanguageManager().get(
                  'weekoff_penalty_apply_If_weekoff_leave_not_applied',
                ),
                'value': state.entity.holidayWeekoffPenaltyApply.toString(),
              },
            ];

            final lateAndEarlyManagement = [
              {
                'title': LanguageManager().get(
                  'late_in_early_out_allowed_per_month',
                ),
                'value': state.entity.maximumInOut.toString(),
              },
              {
                'title': LanguageManager().get('early_out_allowed_per_month'),
                'value': state.entity.maximumEarlyOut.toString(),
              },
              {
                'title': LanguageManager().get(
                  'late_in_early_out_apply_on_extra_day',
                ),
                'value': state.entity.lateInEarlyOutApplyOnExtraDay.toString(),
              },
              {
                'title': LanguageManager().get(
                  'apply_half_day_before_fix_time_out',
                ),
                'value': state.entity.applyHalfDayBeforeFixTimeOut.toString(),
              },
              {
                'title': LanguageManager().get(
                  'apply_half_day_if_late_in_limit_exceeded_the_process_reset_and_repeat_accordingly',
                ),
                'value': state.entity.applyHalfDayLateInExceeded.toString(),
              },
              {
                'title': LanguageManager().get(
                  'remove_late_in_early_out_on_full_working',
                ),
                'value': state.entity.removeLateInEarlyOutOnFullWorking
                    .toString(),
              },
              {
                'title': LanguageManager().get(
                  'late_in_limit_exceeded_leave_type',
                ),
                'value': state.entity.lateInExceededLeaveType.toString(),
              },
            ];

            final weekOffList = toWeekOffItemList(weekOff);
            final leaveList = toWeekOffItemList(leave);
            final calculateLeaveList = toWeekOffItemList(calculateLeave);
            final punchInReasonList = toWeekOffItemList(punchInReason);
            final shortLeavePolicyList = toWeekOffItemList(shortLeavePolicy);
            final breakManagementList = toWeekOffItemList(breakManagement);
            final attandanceManagementList = toWeekOffItemList(
              attandanceManagement,
            );
            final penalitiesList = toWeekOffItemList(penalities);
            final approvalRequirementList = toWeekOffItemList(
              approvalRequirement,
            );
            final shiftHoursList = toWeekOffItemList(shiftHours);
            final weekOffPenaltyList = toWeekOffItemList(weelOffPenalty);
            final lateAndEarlyManagementList = toWeekOffItemList(
              lateAndEarlyManagement,
            );

            return SingleChildScrollView(
              child: Column(
                spacing:
                    VariableBag.formContentSpacingVertical *
                    Responsive.getResponsive(context),
                children: [
                  ShiftDetailsTopCard(
                    shiftName: state.entity.shiftName.toString(),
                    shiftCode: state.entity.shiftCode.toString(),
                  ),

                  ShiftDetailsCard(weekOffData: weekOffList),
                  ShiftDetailsCard(weekOffData: leaveList),
                  ShiftDetailsCard(weekOffData: calculateLeaveList),
                  ShiftDetailsCard(weekOffData: punchInReasonList),
                  ShiftDetailsCard(weekOffData: shortLeavePolicyList),
                  ShiftDetailsCard(weekOffData: breakManagementList),
                  ShiftDetailsCard(weekOffData: attandanceManagementList),
                  ShiftDetailsCard(weekOffData: penalitiesList),
                  ShiftDetailsCard(weekOffData: approvalRequirementList),
                  ShiftDetailsCard(weekOffData: shiftHoursList),
                  ShiftDetailsCard(weekOffData: weekOffPenaltyList),
                  ShiftDetailsCard(
                    isSubTitle: true,
                    weekOffData: lateAndEarlyManagementList,
                  ),
                  breakDetails(state),
                ],
              ),
            );
          } else if (state is FetchProfileDataErrorState) {
            return Center(
              child: CustomText(
                state.errorMessage,
                color: AppTheme.getColor(context).error,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    ),
  );

  ListView breakDetails(ShiftDetailsLoadedState state) => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: state.entity.days?.length ?? 0,
    itemBuilder: (context, index) {
      final days = state.entity.days;
      if (days == null) return const SizedBox.shrink();
      return BreakDetailsCard(
        showPenaltyRules: false,
        bulletItems: [
          {
            'text':
                '${LanguageManager().get('lunch_break')} (${days[index].lunchBreakStartTimeView} - ${days[index].lunchBreakEndTimeView} )',
            'text2': days[index].totalLunchTime.toString(),
          },

          {
            'text': LanguageManager().get('take_lunch_break_before_minutes'),
            'text2': days[index].takeLunchBreakBeforeMinute.toString(),
          },
          {
            'text':
                '${LanguageManager().get('tea_break')} (${days[index].teaBreakStartTimeView} - ${days[index].teaBreakEndTimeView} )',
            'text2': days[index].totalTeaTime.toString(),
          },
          {
            'text': LanguageManager().get('take_tea_break_before_minutes'),
            'text2': days[index].takeTeaBreakBeforeMinute.toString(),
          },

          {
            'text':
                '${LanguageManager().get('late_in_relaxation')} (${days[index].lateInTimeStart})',
            'text2': days[index].lateTimeStartView.toString(),
          },
          {
            'text':
                '${LanguageManager().get('early_out_relaxation')} (${days[index].earlyOutTimeStart})',
            'text2': days[index].earlyOutTimeView.toString(),
          },

          {
            'text': LanguageManager().get('mark_as_half_day_punch_in_after'),
            'text2': days[index].halfDayTimeStartView.toString(),
          },
          {
            'text': LanguageManager().get('mark_as_half_day_punch_out_before'),
            'text2': days[index].halfdayBeforeTimeView.toString(),
          },
          {
            'text': LanguageManager().get('minimum_working_hours_for_half_day'),
            'text2': days[index].maximumHalfdayHoursViewTotal.toString(),
            //not getting
          },

          {
            'text': LanguageManager().get('minimum_working_hours_for_full_day'),
            'text2': days[index].minimumHoursForFullDayViewTotal.toString(),
          },

          {
            'text': LanguageManager().get('max_tea_break'),
            'text2': days[index].maxTeaBreak.toString(),
          },
          {
            'text': LanguageManager().get('max_lunch_break'),
            'text2': days[index].maxLunchBreak.toString(),
          },
        ],
        starTime: days[index].shiftStartTimeView.toString(),
        endTime: days[index].shiftEndTimeView.toString(),
        totalHours: days[index].perDayHourView.toString(),
        daysName: days[index].shiftDayName.toString(),
      );
    },
  );
}
