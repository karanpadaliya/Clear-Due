import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_event.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_state.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/my_wfh_list_card.dart';
import 'package:myco_flutter/features/work_from_home/presentation/widgets/wfh_list_status_helper.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_header.dart';
import 'package:myco_flutter/widgets/custom_safearea.dart';

class MyWfhListPage extends StatelessWidget {
  const MyWfhListPage({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return CustomSafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Column(
                children: [
                  MonthYearHeader(
                    startYear: DateTime.now().year - 2,
                    endYear: DateTime.now().year,
                    iconSize: 0.02 * Responsive.getHeight(context),
                    onChanged: (month, year) {
                      log('Selected Month: $month, Year: $year');
                      context.read<AddWfhBloc>().add(
                        FilterWFHByMonthYear('$month', '$year'),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            const WfhListStatusHelper(),
            const SizedBox(height: 10.0),
            BlocBuilder<AddWfhBloc, AddWfhState>(
              builder: (context, state) {
                if (state is WFHLoading ||
                    state is WFHInitial ||
                    state is WFHShowToast) {
                  if (state is WFHShowToast) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: MyWfhListCardShimmer(),
                      ),
                    ),
                  );
                } else if (state is WFHLoaded) {
                  if (state.fullList.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'No Record Found',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context.read<AddWfhBloc>().add(RefreshWFHList());
                        },
                        child: ListView.builder(
                          itemCount: state.fullList.length,
                          itemBuilder: (context, index) {
                            final wfhItem = state.fullList[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: MyWfhListCard(
                                model: wfhItem,
                                contextForBloc: context,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                } else if (state is WFHError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
