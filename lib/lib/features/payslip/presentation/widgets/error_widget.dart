import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class PayslipErrorWidget extends StatelessWidget {
  final String error;
  const PayslipErrorWidget({required this.error, super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SizedBox(height: 0.3 * Responsive.getHeight(context)),
      SvgPicture.asset(AppAssets.receipt),
      CustomText(error, fontSize: 14 * Responsive.getResponsiveText(context)),
    ],
  );
}
