import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/dashboard/presentation/widgets/custom_label_gifs.dart';
import 'package:myco_flutter/features/my_profile/domain/entites/profile_entity.dart';
import 'package:myco_flutter/widgets/custom_shadow_container.dart';

class ProfilePersonalInfoCard extends StatelessWidget {
  final List personalInfoList;
  final ProfileModelEntity profileModelEntity;
  ProfilePersonalInfoCard({
    super.key,
    required this.personalInfoList,
    required this.profileModelEntity,
  });

  @override
  Widget build(BuildContext context) => Column(
    spacing: 0.015 * Responsive.getHeight(context),
    children: [
      CustomLabelGifs(
        title: LanguageManager().get('personal_info'),
        gifAssetPath: 'assets/gifs/profile_info.gif',
      ),
      GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: personalInfoList.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final ProfileMenuEntity item = personalInfoList[index];
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: 1 * Responsive.getResponsive(context),
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                12 * Responsive.getResponsive(context),
              ),
              border: Border.all(
                color: AppTheme.getColor(context).outlineVariant,
              ),
            ),
            child: InkWell(
              onTap: () {
                print(item.menuClick);
                context.push(
                  '/${item.menuClick.toString()}' ?? '',
                  extra: profileModelEntity,
                );
              },
              child: CustomShadowContainer(
                image: Image.network(item.profileMenuPhoto.toString()),
                title: item.languageKeyName.toString(),
                height: 0.50 * Responsive.getHeight(context),
                imagePadding: 20 * Responsive.getResponsive(context),
                boxPadding: 20 * Responsive.getResponsive(context),
                
              ),
            ),
          );
        },
      ),
    ],
  );
}
