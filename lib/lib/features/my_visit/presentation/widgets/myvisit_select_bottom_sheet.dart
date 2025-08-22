import 'package:flutter/material.dart';
import 'package:myco_flutter/widgets/custom_myco_button/custom_myco_button.dart';

class MyVisitSelectBottomSheet extends StatelessWidget {
  final String? title; // optional
  final List<String> options;
  final void Function(String) onSelected;

  const MyVisitSelectBottomSheet({
    required this.options, required this.onSelected, super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
            ],

            // Search field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // onChanged: ... add logic later
            ),

            const SizedBox(height: 12),

            // Options as boxes (without spread)
            Column(
              children: List.generate(options.length, (index) {
                final item = options[index];
                final bool isSelected = false; // Placeholder for now

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.lightBlue[100] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.blue[900] : Colors.black,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 12),

            // Cancel button
            Center(
              child: MyCoButton(
                title: 'Cancel',
                backgroundColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                boarderRadius: 50,
                height: 48,
                width: 140,
                isShadowBottomLeft: true,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
