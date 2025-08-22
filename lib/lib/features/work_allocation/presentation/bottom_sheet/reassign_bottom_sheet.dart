import 'package:flutter/material.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ReassignBottomSheet extends StatefulWidget {
  final void Function(String remark, DateTime selectedDate) onSubmit;

  const ReassignBottomSheet({Key? key, required this.onSubmit})
    : super(key: key);

  @override
  State<ReassignBottomSheet> createState() => _ReassignBottomSheetState();
}

class _ReassignBottomSheetState extends State<ReassignBottomSheet> {
  final TextEditingController _remarkController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Remark TextField
        TextField(
          controller: _remarkController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Remark',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),

        // Date Picker Button
        Row(
          children: [
            Expanded(
              child: CustomText(
                _selectedDate != null
                    ? 'Selected: ${_selectedDate!.toLocal().toString().split(' ')[0]}'
                    : 'No date selected',
              ),
            ),
            TextButton(onPressed: _pickDate, child: const Text('Select Date')),
          ],
        ),
        const SizedBox(height: 24),

        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () => Navigator.pop(context),
              child: const CustomText('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                final remark = _remarkController.text.trim();

                if (_selectedDate != null && remark.isNotEmpty) {
                  Navigator.pop(context);
                  widget.onSubmit(remark, _selectedDate!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: CustomText(
                        'Please select a date and enter a remark.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const CustomText('Submit'),
            ),
          ],
        ),
      ],
    ),
  );
}
