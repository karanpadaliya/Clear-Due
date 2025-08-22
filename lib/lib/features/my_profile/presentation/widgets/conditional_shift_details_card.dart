import 'package:flutter/widgets.dart';
import 'package:myco_flutter/features/my_profile/data/models/request/week_off_item.dart';
import 'package:myco_flutter/features/my_profile/presentation/widgets/shift_details_card.dart';

class ConditionalShiftDetailsCard extends StatelessWidget {
  final List<WeekOffItem> data;
  final bool isSubTitle;

  const ConditionalShiftDetailsCard({
    required this.data,
    this.isSubTitle = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hasValidData = data.any(
      (e) =>
          e.value.trim().isNotEmpty && e.value.trim().toLowerCase() != 'null',
    );
    if (!hasValidData) return const SizedBox.shrink();

    return ShiftDetailsCard(weekOffData: data, isSubTitle: isSubTitle);
  }
}
