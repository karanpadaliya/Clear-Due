import 'package:flutter/material.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/widgets/custom_alert_dialog.dart';

class DeleteNomineeBottomSheet extends StatelessWidget {
  const DeleteNomineeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => CustomAlertDialog(
    alertType: AlertType.custom,
    icon: AppAssets.TrashToDustbin,
    content: LanguageManager().get('delete_nominee_details'),
    confirmText: LanguageManager().get('delete'),
    cancelText: LanguageManager().get('cancel'),
  );
}
