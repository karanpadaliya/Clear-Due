

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

class MessageCard extends StatelessWidget {
  final String title;
  final String message;
  final String timestamp;
  final String messageType;
  final String? userImageUrl;
  final Color backgroundColor;
  final Color textColor;
  final Color highlightColor;
  final bool isSentByUser;

  const MessageCard({
    super.key,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.messageType,
    this.userImageUrl,
    this.backgroundColor = const Color(0xFF2D5F87),
    this.textColor = AppColors.white,
    this.highlightColor = AppColors.white,
    this.isSentByUser = false,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
     final contentColor = isSentByUser
        ? AppTheme.getColor(context).onSurface
        : AppTheme.getColor(context).onPrimary;
    final radius = 20 * Responsive.getResponsive(context);
    final userColor = AppTheme.getColor(
      context,
    ).onPrimary; // Optional green for sent
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    log(isDarkMode.toString(), name: 'isDarkMode');
    return Container(
      margin: isSentByUser
          ? EdgeInsets.only(right: 0.1 * Responsive.getHeight(context))
          : EdgeInsets.only(left: 0.1 * Responsive.getHeight(context)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0.011 * Responsive.getHeight(context),  
          horizontal: 0.013 * Responsive.getWidth(context),
        ),
        child: Container(
          width: .3 * Responsive.getWidth(context),
          decoration: BoxDecoration(
            color: isSentByUser ?   (isDarkMode? AppColors.containerHighDark : AppTheme.getColor(context).onPrimary) : AppTheme.getColor(context).primary ,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 12 * Responsive.getResponsive(context),
            horizontal: 10 * Responsive.getResponsive(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // CustomText(
              //   title,
              //   fontWeight: FontWeight.w600,
              //   fontSize: Responsive.scaleText(14),
              //   color: isSentByUser
              //       ? AppTheme.getColor(context).onSurface
              //       : AppTheme.getColor(context).onPrimary,
              // ),
              _buildMessageContent(context, contentColor),
              SizedBox(height: 0.01 * Responsive.getHeight(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      message,
                      fontSize: Responsive.scaleText(12),
                      color: AppColors.spanishYellow,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 0.02 * Responsive.getWidth(context)),
                  CustomText(
                    timestamp,
                    fontSize: Responsive.scaleText(10),
                    color: isSentByUser
                        ? AppTheme.getColor(context).onSurface
                        : AppTheme.getColor(context).onPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
    Widget _buildMessageContent(BuildContext context, Color contentColor) {
    switch (messageType) {
      case 'text':
        return CustomText(
          message,
          fontSize: Responsive.scaleText(12),
          color: contentColor,
          overflow: TextOverflow.ellipsis,
        );

      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://blocks.astratic.com/img/general-img-landscape.png' ,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(Icons.broken_image, color: contentColor),
          ),
        );

      case 'document':
        return Row(
          children: [
            Icon(Icons.insert_drive_file, color: contentColor),
            SizedBox(width: 0.01 * Responsive.getWidth(context)),
            Expanded(
              child: CustomText(
                "Document" ?? 'Document',
                fontSize: Responsive.scaleText(12),
                color: contentColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.download, color: contentColor),
              onPressed: ()  {
                // TODO: Implement file download
                
              },
            )
          ],
        );

      case 'location':
        return Column(
          children: [
            ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://blocks.astratic.com/img/general-img-landscape.png' ,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(Icons.broken_image, color: contentColor),
          ),
        ),
            SizedBox(height: 0.003 * Responsive.getHeight(context)),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                message,
                fontSize: Responsive.scaleText(12),
                color: contentColor,
              ),
            ),
          ],
        );

      case 'contact':
        return Row(
          children: [
            CircleAvatar(
              backgroundColor:  AppTheme.getColor(context).onPrimary,
              child: Icon(Icons.person, color: AppTheme.getColor(context).primary)),
            SizedBox(width: 8),
            Expanded(
              child: CustomText(
                message,
                fontSize: Responsive.scaleText(12),
                color: contentColor,
              ),
            ),
          ],
        );

      case 'audio':
        return Row(
          children: [
            Icon(Icons.audiotrack, color: contentColor),
            SizedBox(width: 8),
            Expanded(
              child: CustomText(
                'Voice message',
                fontSize: Responsive.scaleText(12),
                color: contentColor,
              ),
            ),
            IconButton(
              icon: Icon(Icons.play_arrow, color: contentColor),
              onPressed: () {
                // TODO: Implement audio player
              },
            )
          ],
        );

      default:
        return CustomText(
          'Unsupported message type',
          fontSize: Responsive.scaleText(12),
          color: contentColor,
        );
    }
  }

}

