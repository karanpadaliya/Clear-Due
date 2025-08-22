import 'package:flutter/material.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';

class LeaveActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;

  const LeaveActionButton({
    required this.title,
    required this.onTap,
    super.key,
    this.icon = Icons.work_outline,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.getWidth(context);
    final height = Responsive.getHeight(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/wallet.png', width: width * 0.05),
            // Icon(icon, color: Colors.blue.shade800, size: width * 0.05),
            SizedBox(width: width * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.025,
                color: AppColors.littleDarkBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: width * 0.02),
            Icon(
              Icons.chevron_right,
              color: AppColors.littleDarkBlue,
              size: width * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
