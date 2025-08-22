import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class ChatListCard extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String? timeAgo;
  final String profileImagePath;
  final VoidCallback onTap;
  final bool? isSufixIcon;

  const ChatListCard({
    super.key,
    required this.name,
    required this.lastMessage,
    this.timeAgo,
    required this.profileImagePath,
    required this.onTap,
    this.isSufixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final themeColor = AppTheme.getColor(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8 * Responsive.getResponsive(context),
          horizontal: 12 * Responsive.getResponsive(context),
        ),
        decoration: BoxDecoration(
          color:AppBarTheme.of(context).backgroundColor,
          border: Border.all(color: themeColor.outline),
          borderRadius: BorderRadius.circular(12 * Responsive.getResponsive(context)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CircleAvatar(
                backgroundColor: themeColor.secondary,
                radius: 32 * Responsive.getResponsive(context),
                backgroundImage: profileImagePath.isEmpty
                    ? const NetworkImage('https://avatar.iran.liara.run/public/1')
                    : NetworkImage(profileImagePath),
              ),
          
              SizedBox(width: 0.03 * Responsive.getWidth(context)),
          
              // Name + Message + Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      name,
                      fontWeight: FontWeight.w600,
                      fontSize: 16 * Responsive.getResponsiveText(context),
                      color: themeColor.primary,
                    ),
                    SizedBox(height: 0.002 * Responsive.getHeight(context)),
                    CustomText(
                      lastMessage,
                      fontSize: 14 * Responsive.getResponsiveText(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: themeColor.onSurface,
                    ),
                    if (isSufixIcon != true) ...[
                      SizedBox(height: 0.002 * Responsive.getHeight(context)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomText(
                          timeAgo ?? '',
                          fontSize: 12 * Responsive.getResponsiveText(context),
                        ),
                      )
                    ],
                  ],
                ),
              ),
          
              if (isSufixIcon == true)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: SvgPicture.asset("assets/chat/close-circle.svg"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
