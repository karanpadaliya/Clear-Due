import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/features/work_from_home/domain/entities/add_wfh/add_wfh_entity.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_bloc.dart';
import 'package:myco_flutter/features/work_from_home/presentation/bloc/add_wfh/add_wfh_event.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';
import 'package:shimmer/shimmer.dart';

class AdminReqListCard extends StatelessWidget {
  final GetWfhListItemEntity model;
  final BuildContext contextForBloc;
  const AdminReqListCard({
    required this.model,
    required this.contextForBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CommonCard(
    title: model.wfhStartDateView ?? 'NA',
    showHeaderPrefixIcon: true,
    suffixIcon: SvgPicture.asset(
      switch (model.wfhStatus) {
        '0' => AppAssets.infoCircle,
        '1' => AppAssets.checkCircle,
        '2' => AppAssets.xCircle,
        _ => AppAssets.xCircle, // Default case
      },
      height: 25,
      colorFilter: ColorFilter.mode(
        AppTheme.getColor(context).onPrimary,
        BlendMode.srcIn,
      ),
    ),
    headerColor: switch (model.wfhStatus) {
      '0' => AppTheme.getColor(context).onTertiaryContainer,
      '1' => AppTheme.getColor(context).secondary,
      '2' => AppTheme.getColor(context).error,
      _ => AppTheme.getColor(context).error, // Default case
    },
    headerPrefixIcon: AppAssets.calendarIcon,
    bottomWidget: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Reason: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.lightTheme(context).shadowColor,
              ),
              children: [
                TextSpan(
                  text: model.wfhReason ?? 'NA',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: 'Location: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.lightTheme(context).shadowColor,
              ),
              children: [
                TextSpan(
                  text: model.wfhAddress ?? 'NA',
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Divider(
            color: switch (model.wfhStatus) {
              '0' => AppTheme.getColor(context).onTertiaryContainer,
              '1' => AppTheme.getColor(context).secondary,
              '2' => AppTheme.getColor(context).error,
              '3' => AppTheme.getColor(context).error,
              _ => AppTheme.getColor(context).primary, // Default case
            },
            thickness: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Created On: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightTheme(context).shadowColor,
                  ),
                  children: [
                    TextSpan(
                      text: '\n ${model.wfhCreatedAt ?? 'NA'}',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              if (model.wfhStatus == '0') ...[
                InkWell(
                  onTap: () async {
                    final blocContext = context;
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: CustomAlertDialog(
                          alertType: AlertType.delete,
                          content: LanguageManager().get('sure_to_delete'),
                          cancelText: LanguageManager().get('cancel'),
                          confirmText: LanguageManager().get('delete'),
                          onConfirm: () {
                            contextForBloc.read<AddWfhBloc>().add(
                              DeleteWFHRequest(model.wfhId ?? ''),
                            );
                            Navigator.of(blocContext).pop();
                          },
                          onCancel: () {
                            Navigator.of(blocContext).pop();
                          },
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(AppAssets.delete, height: 22),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          if (model.wfhStatus == '1' || model.wfhStatus == '2') ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: model.wfhStatus == '1'
                        ? 'Approved On: '
                        : 'Rejected On: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightTheme(context).shadowColor,
                    ),
                    children: [
                      TextSpan(
                        text: '\n ${model.wfhApprovedDate ?? 'NA'}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: model.wfhStatus == '1'
                        ? 'Approved By: '
                        : 'Rejected By: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightTheme(context).shadowColor,
                    ),
                    children: [
                      TextSpan(
                        text: '\n ${model.approvedByName ?? 'NA'}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          if (model.wfhDeclinedReason != null &&
              model.wfhDeclinedReason!.isNotEmpty)
            RichText(
              text: TextSpan(
                text: 'Declined Reason: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightTheme(context).shadowColor,
                ),
                children: [
                  TextSpan(
                    text: model.wfhDeclinedReason,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
        ],
      ),
    ),
  );
}
