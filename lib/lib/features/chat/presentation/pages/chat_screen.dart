import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/message_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:myco_flutter/widgets/custom_text_field.dart';

class UserChatScreen extends StatelessWidget {
  final bool? isNewChat;
   UserChatScreen({super.key, this.isNewChat = false});
  final List<Map<String, dynamic>> chatMessages = [
  {
    'title': 'Vedant',
    'message': 'Open by Mukund Madhav',
    'timestamp': 'May 30 10:30 AM',
    'isSentByUser': true,
    'messageType': 'image',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': false,
    'messageType': 'image',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': false,
    'messageType': 'contact',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': true,
    'messageType': 'contact',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': false,
    'messageType': 'document',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': true,
    'messageType': 'document',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': false,
    'messageType': 'text',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': true,
    'messageType': 'text',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': false,
    'messageType': 'location',
  },
  {
    'title': 'Vedant',
    'message': 'Hello!',
    'timestamp': 'May 30 10:31 AM',
    'isSentByUser': true,
    'messageType': 'location',
  },
];
  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    body: Container(
      decoration: BoxDecoration(
         gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppTheme.getColor(context).surfaceBright,
              AppColors.secondary,
            ],
          ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              appBarBackgoundColor: Colors.transparent,
              appBarTitleWidget: GestureDetector(
                onTap: () {
                  context.pushNamed('group-info');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.getColor(context).secondary,
                      radius: 20 * Responsive.getResponsive(context),
                      backgroundImage: const AssetImage(
                        'assets/chat/profile.jpg',
                      ),
                    ),
                    SizedBox(width: 0.02 * Responsive.getWidth(context)),
                    CustomText(
                      'Vedant',
                      fontSize: 20 * Responsive.getResponsiveText(context),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.getColor(context).onPrimary,
                    ),
                  ],
                ),
              ),
              actionsPadding:  EdgeInsets.only(right: 0.07 * Responsive.getWidth(context)),
              titleSpacing: 10,
              actions: [
                SvgPicture.asset(
                  'assets/chat/menu.svg',)
              ],
            ),
            SizedBox(height: 0.01 * Responsive.getHeight(context)),
            Expanded(
              child: isNewChat! || false // Replace 'true' with your actual condition for empty chat
                  ? Center(
                      child: CustomText(
                        'start a conversation',
                        fontSize: 15 * Responsive.getResponsiveText(context),
                        fontWeight: FontWeight.w500,
                        color: AppTheme.getColor(context).onSurface,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: VariableBag.screenHorizontalPadding,
                      ),
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) =>  MessageCard(
                          title: chatMessages[index]['title'],
                          message: chatMessages[index]['message'],
                          timestamp: chatMessages[index]['timestamp'],
                          isSentByUser: chatMessages[index]['isSentByUser'],
                          messageType: chatMessages[index]['messageType'],
                        ),
                        itemCount: chatMessages.length,
                        shrinkWrap: true,
                      ),
                    ),
            ),
            SizedBox(height: 0.02 * Responsive.getHeight(context)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.06 * Responsive.getWidth(context),
              ),
              child: MyCoTextfield(
                hintText: 'Type Message',
                hintTextStyle: AppTheme.getTextStyle(
                  context,
                ).labelLarge!.copyWith(color: AppColors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    12 * Responsive.getResponsive(context),
                  ),
                  borderSide: BorderSide(
                    color: AppTheme.getColor(context).outline,
                    width: 1.2,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  top: 0.012 * Responsive.getHeight(context),
                  left: 0.03 * Responsive.getWidth(context),
                  right: 0.03 * Responsive.getWidth(context),
                  bottom: 0.012 * Responsive.getHeight(context),
                ),
                onClick: () {},
                boarderRadius: 12 * Responsive.getResponsive(context),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/chat/attchment.svg',
                      width: 25 * Responsive.getResponsive(context),
                    ),
                    SizedBox(width: 0.05 * Responsive.getWidth(context)),
                    SvgPicture.asset(
                      'assets/chat/send.svg',
                     width: 25 * Responsive.getResponsive(context),
                    ),
                    SizedBox(width: 0.05 * Responsive.getWidth(context)),
                  ],
                ),
                isSuffixIconOn: true,
                onChanged: (value) => {},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}