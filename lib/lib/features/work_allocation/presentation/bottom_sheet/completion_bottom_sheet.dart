import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field_new.dart';

class CompletionBottomSheet extends StatefulWidget {
  final void Function(String date, String remark) onComplete;

  const CompletionBottomSheet({super.key, required this.onComplete});

  static void show(
    BuildContext context, {
    required void Function(String date, String remark) onComplete,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (_) => CompletionBottomSheet(onComplete: onComplete),
    );
  }

  @override
  State<CompletionBottomSheet> createState() => _CompletionBottomSheetState();
}

class _CompletionBottomSheetState extends State<CompletionBottomSheet> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _handleComplete() {
    final date = dateController.text.trim();
    final remark = remarkController.text.trim();

    if (date.isEmpty || remark.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText(
            'Please enter date and remark',
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pop(context);
    widget.onComplete(date, remark);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: CustomText('Marked as Completed', color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double padding = 16.0 * Responsive.getResponsive(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Work Complete Date
            NewTextField(
              controller: dateController,
              label: 'work_complete_date',
              hintText: 'select_date',
              isRequired: true,
              onTap: _pickDate,
              suffix: Icon(
                Icons.calendar_today,
                size: 20 * Responsive.getResponsive(context),
                color: AppTheme.getColor(context).primary,
              ),
            ),

            SizedBox(height: padding),

            /// Remark
            NewTextField(
              controller: remarkController,
              label: 'remark',
              hintText: 'enter_remark',
              maxLines: 3,
              minLines: 3,
              isRequired: true,
            ),

            SizedBox(height: padding * 1.5),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: MyCoButton(
                    title: 'Close',
                    height: 40,
                    onTap: () => Navigator.pop(context),
                    backgroundColor: Colors.grey.shade300,
                    textStyle: const TextStyle(color: Colors.black),
                    boarderRadius: 25 * Responsive.getResponsive(context),
                  ),
                ),
                SizedBox(width: padding),
                Expanded(
                  child: MyCoButton(
                    title: LanguageManager().get('complete'),
                    height: 40,
                    onTap: _handleComplete,
                    boarderRadius: 25 * Responsive.getResponsive(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: padding),
          ],
        ),
      ),
    );
  }
}
