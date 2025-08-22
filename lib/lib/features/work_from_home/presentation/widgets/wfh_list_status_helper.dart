import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';

class WfhListStatusHelper extends StatelessWidget {
  const WfhListStatusHelper({super.key});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SvgPicture.asset(AppAssets.checkCircle, color: AppColors.greenDark),
          const SizedBox(width: 3.0),
          Text(
            LanguageManager().get('approved'),
            style: TextStyle(color: AppColors.greenDark),
          ),
        ],
      ),
      Row(
        children: [
          SvgPicture.asset(
            AppAssets.infoCircle,
            color: AppColors.spanishYellow,
          ),
          const SizedBox(width: 2.0),
          Text(
            LanguageManager().get('pending'),
            style: TextStyle(color: AppColors.spanishYellow),
          ),
        ],
      ),
      Row(
        children: [
          SvgPicture.asset(AppAssets.checkCircle, color: AppColors.red),
          const SizedBox(width: 2.0),
          Text(
            LanguageManager().get('rejected'),
            style: TextStyle(color: AppColors.red),
          ),
        ],
      ),
    ],
  );
}
