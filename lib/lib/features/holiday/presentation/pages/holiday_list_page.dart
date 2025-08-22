import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/holiday/model/request/apply_optional_holiday.dart';
import 'package:myco_flutter/features/holiday/model/request/delete_optional_holiday.dart';
import 'package:myco_flutter/features/holiday/model/request/holiday_list_request_model.dart';
import 'package:myco_flutter/features/holiday/presentation/bloc/holiday_bloc.dart';
import 'package:myco_flutter/features/holiday/presentation/bloc/holiday_event.dart';
import 'package:myco_flutter/features/holiday/presentation/bloc/holiday_state.dart';
import 'package:myco_flutter/features/holiday/presentation/widgets/holiday_item_card.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_picker_bottom_sheet.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class HolidayListPage extends StatelessWidget {
  final TextEditingController controller;

  HolidayListPage({required this.controller, super.key});

  final preferenceManager = GetIt.I<PreferenceManager>();
  final List<Color> backgroundColors = const [
    Color(0xFF2F648E),
    Color(0xFF2FBBA4),
    Color(0xFF08A4BB),
    Color(0xFFFFC026),
    Color(0xFFFF2121),
  ];

  Future<void> fetchHolidays(BuildContext context, DateTime date) async {
    final year = DateFormat('yyyy').format(date);
    final companyId = await preferenceManager.getCompanyId();
    final userId = await preferenceManager.getUserId();

    final fetchListModel = HolidayListRequestModel(
      companyId: companyId ?? '',
      languageId: '1',
      unitId: '1',
      userId: userId ?? '',
      branchId: '1',
      departmentId: '1',
      levelId: '1',
      year: year,
    );
    context.read<HolidayBloc>().add(FetchHolidayList(fetchListModel));
  }

  Future<void> scrollToUpcomingHoliday(
    int index,
    List<GlobalKey> keys,
    ScrollController controller,
  ) async {
    await Future.delayed(const Duration(milliseconds: 1));

    double offset = 0.0;
    for (int i = 0; i < index; i++) {
      final keyContext = keys[i].currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          offset += box.size.height;
        } else {
          offset += 133.0;
        }
      } else {
        offset += 133.0;
      }
    }

    if (controller.hasClients) {
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateNotifier = ValueNotifier<DateTime>(DateTime.now());
    final scrollController = ScrollController();

    final searchQuery = ValueNotifier<String>('');

    controller.addListener(() {
      searchQuery.value = controller.text.toLowerCase();
    });

    return BlocProvider(
      create: (_) => GetIt.instance<HolidayBloc>(),
      child: ValueListenableBuilder<DateTime>(
        valueListenable: selectedDateNotifier,
        builder: (context, currentDate, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            fetchHolidays(context, currentDate);
          });

          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: const Text('Holiday'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  NewTextField(
                    controller: controller,
                    prefixIconPath: 'assets/lost_and_found/search-normal.png',
                    hintText: 'Search',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          selectedDateNotifier.value = DateTime(
                            currentDate.year - 1,
                            currentDate.month,
                          );
                        },
                        icon: const Icon(Icons.arrow_left),
                      ),
                      InkWell(
                        onTap: () async {
                          final now = DateTime.now();
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (_) => MonthYearPickerBottomSheet(
                              initialMonth: selectedDateNotifier.value.month,
                              initialYear: selectedDateNotifier.value.year,
                              startYear: now.year - 1,
                              endYear: now.year + 1,
                              customMonths: LanguageManager().getList(
                                'month_arry',
                              ),
                              onSubmit: (month, year) {
                                final newDate = DateTime(
                                  year,
                                  month == 0 ? 1 : month,
                                );
                                selectedDateNotifier.value = newDate;
                                fetchHolidays(context, newDate);
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('MMMM, yyyy').format(currentDate),
                              style: TextStyle(
                                fontSize:
                                    18 * Responsive.getResponsiveText(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          selectedDateNotifier.value = DateTime(
                            currentDate.year + 1,
                            currentDate.month,
                          );
                        },
                        icon: const Icon(Icons.arrow_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ValueListenableBuilder<String>(
                      valueListenable: searchQuery,
                      builder: (context, query, _) => BlocBuilder<HolidayBloc, HolidayState>(
                        builder: (context, state) {
                          if (state is HolidayLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is HolidayListLoaded) {
                            final holidays = state.holidays;

                            // Filter holidays using search query
                            final filteredHolidays = holidays.where((holiday) {
                              final name = holiday.holidayName ?? '';
                              return name.toLowerCase().contains(query);
                            }).toList();

                            if (filteredHolidays.isEmpty) {
                              return const Center(
                                child: Text('No holidays found'),
                              );
                            }

                            final currentDate = DateTime.now();
                            final upcomingIndex = filteredHolidays.indexWhere((
                              holiday,
                            ) {
                              final startString = holiday.holidayStartDate;
                              if (startString == null) return false;

                              final start = DateTime.tryParse(startString);
                              if (start == null) return false;

                              return !start.isBefore(
                                DateTime(
                                  currentDate.year,
                                  currentDate.month,
                                  currentDate.day,
                                ),
                              );
                            });

                            final List<GlobalKey> itemKeys = List.generate(
                              filteredHolidays.length,
                              (_) => GlobalKey(),
                            );

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (upcomingIndex != -1) {
                                scrollToUpcomingHoliday(
                                  upcomingIndex,
                                  itemKeys,
                                  scrollController,
                                );
                              }
                            });

                            return ListView.builder(
                              controller: scrollController,
                              itemCount: filteredHolidays.length,
                              itemBuilder: (context, index) {
                                final holiday = filteredHolidays[index];
                                return Container(
                                  key: itemKeys[index],
                                  child: HolidayItemCard(
                                    holiday: holiday,
                                    index: index,
                                    backgroundColors: backgroundColors,
                                    context: context,
                                    onApplyTap: () {
                                      final blocContext = context;

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom,
                                          ),
                                          child: CustomAlertDialog(
                                            alertType: AlertType.defaultType,
                                            content:
                                                'Are you sure you want to apply for optional leave?',
                                            cancelText: 'Cancel',
                                            confirmText: 'OK',
                                            onConfirm: () async {
                                              Navigator.of(context).pop();
                                              final model = ApplyOptionalHoliday(
                                                companyId:
                                                    await preferenceManager
                                                        .getCompanyId() ??
                                                    '',
                                                userId:
                                                    await preferenceManager
                                                        .getUserId() ??
                                                    '',
                                                holidayId:
                                                    holiday.holidayId ?? '',
                                                optionalHolidayAssignId:
                                                    holiday
                                                        .optionalHolidayAssignId ??
                                                    '',
                                              );
                                              blocContext
                                                  .read<HolidayBloc>()
                                                  .add(
                                                    ApplyHolidayEvent(model),
                                                  );
                                            },
                                            onCancel: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ),
                                      );
                                    },
                                    onDeleteTap: () {
                                      final blocContext = context;

                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(
                                              context,
                                            ).viewInsets.bottom,
                                          ),
                                          child: CustomAlertDialog(
                                            alertType: AlertType.defaultType,
                                            content:
                                                'Are you sure you want to delete optional leave?',
                                            cancelText: 'Cancel',
                                            confirmText: 'OK',
                                            onConfirm: () async {
                                              Navigator.of(context).pop();
                                              final model = DeleteOptionalHoliday(
                                                companyId:
                                                    await preferenceManager
                                                        .getCompanyId() ??
                                                    '',
                                                userId:
                                                    await preferenceManager
                                                        .getUserId() ??
                                                    '',
                                                optionalHolidayAssignId:
                                                    holiday
                                                        .optionalHolidayAssignDeleteId ??
                                                    '',
                                              );
                                              blocContext
                                                  .read<HolidayBloc>()
                                                  .add(
                                                    DeleteHolidayEvent(model),
                                                  );
                                            },
                                            onCancel: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          } else if (state is HolidayError) {
                            Fluttertoast.showToast(msg: state.message);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
