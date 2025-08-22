import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class CompletionRemarkBottomSheet extends StatefulWidget {
  final void Function(String remark) onSubmit;

  const CompletionRemarkBottomSheet({required this.onSubmit, super.key});

  @override
  State<CompletionRemarkBottomSheet> createState() =>
      _CompletionRemarkBottomSheetState();
}

class _CompletionRemarkBottomSheetState
    extends State<CompletionRemarkBottomSheet> {
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left:
          VariableBag.bottomSheetLeftPadding *
          Responsive.getResponsive(context),
      right:
          VariableBag.bottomSheetRightPadding *
          Responsive.getResponsive(context),
      top:
          VariableBag.bottomSheetTopPadding * Responsive.getResponsive(context),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top disabled field (e.g., completion time)
        NewTextField(
          enabled: false,
          prefixIconPath: AppAssets.assetCalendarTick,
          hintText: LanguageManager().get('before_time'),
          label: 'completion_remark',
          suffixIconPath: AppAssets.assetArrowDown,
          isRequired: true,
        ),
        const SizedBox(height: 10),

        // Remark input
        NewTextField(
          controller: _remarkController,
          prefixIconPath: AppAssets.assetMessageEdit,
          maxLines: 3,
          hintText: LanguageManager().get('good'),
          label: 'remark',
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'please_enter_remark';
            }
            return null;
          },
        ),
        SizedBox(
          height:
              VariableBag.textFieldRowGap * Responsive.getResponsive(context),
        ),

        // Buttons: CLOSE and AUTHORIZE
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyCoButton(
              boarderRadius:
                  VariableBag.buttonBorderRadius *
                  Responsive.getResponsive(context),
              width: 0.42 * Responsive.getWidth(context),
              height: 0.06 * Responsive.getHeight(context),
              onTap: () => context.pop(),
              backgroundColor: AppTheme.getColor(context).surfaceBright,
              title: LanguageManager().get('close'),
              textStyle: TextStyle(
                color: AppTheme.getColor(context).primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            MyCoButton(
              boarderRadius:
                  VariableBag.buttonBorderRadius *
                  Responsive.getResponsive(context),
              width: 0.42 * Responsive.getWidth(context),
              height: 0.06 * Responsive.getHeight(context),
              onTap: () {
                final remark = _remarkController.text.trim();
                if (remark.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('please_enter_remark')),
                  );
                  return;
                }

                widget.onSubmit(remark);
                context.pop();
              },
              title: LanguageManager().get('authorize'),
              fontWeight: FontWeight.w600,
              isShadowBottomLeft: true,
            ),
          ],
        ),
        SizedBox(
          height:
              VariableBag.textFieldRowGap * Responsive.getResponsive(context),
        ),
      ],
    ),
  );
}
