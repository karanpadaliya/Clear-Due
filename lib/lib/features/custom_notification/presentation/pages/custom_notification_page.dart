import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/custom_notification/presentation/bloc/custom_notification_bloc.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNotificationPage extends StatelessWidget {
  final Map<String, dynamic>? notificationData;
  
  const CustomNotificationPage({super.key, this.notificationData});

  void _loadNotificationData(BuildContext context) {
    final data = notificationData ?? {};
    
    // Parse click_action JSON string to get notification details
    Map<String, dynamic> parsedData = {};
    if (data['click_action'] != null) {
      try {
        parsedData = json.decode(data['click_action'] as String);
      } catch (e) {
        print('Error parsing click_action JSON: $e');
        // Fallback to direct data access if JSON parsing fails
        parsedData = data;
      }
    } else {
      parsedData = data;
    }
    
    context.read<CustomNotificationBloc>().add(
      LoadCustomNotification(
        imageUrl: parsedData['img_url'] as String?,
        title: parsedData['title'] as String?,
        description: parsedData['description'] as String?,
        notificationTime: parsedData['notification_time'] as String?,
      ),
    );
  }

  void _handleBack(BuildContext context) {
    // Check if we can pop the current route
    if (context.canPop()) {
      context.pop();
    } else {
      // Navigate to dashboard if no previous route
      context.go(RoutePaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize BLoC with notification data
    _loadNotificationData(context);
    final responsive = Responsive.getResponsive(context);
    final height = Responsive.getHeight(context);
    final width = Responsive.getWidth(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleBack(context);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'notification',
          isKey: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: InkWell(
            onTap: () => _handleBack(context),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: BlocBuilder<CustomNotificationBloc, CustomNotificationState>(
          builder: (context, state) {
            if (state is CustomNotificationLoaded) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16 * responsive),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    if (state.imageUrl != null && state.imageUrl!.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 0.25 * height,
                        margin: EdgeInsets.only(bottom: 16 * responsive),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * responsive),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12 * responsive),
                          child: GestureDetector(
                            onTap: () {
                              // Show full screen image dialog
                              _showImageDialog(context, state.imageUrl!);
                            },
                            child: CachedNetworkImage(
                              imageUrl: state.imageUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Title section
                    if (state.title != null && state.title!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: 12 * responsive),
                        child: CustomText(
                          state.title!,
                          fontSize: 20 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w700,
                          color: AppTheme.getColor(context).onSurface,
                        ),
                      ),

                    // Time section
                    if (state.notificationTime != null && state.notificationTime!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(bottom: 16 * responsive),
                        child: CustomText(
                          state.notificationTime!,
                          fontSize: 14 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getColor(context).onSurface.withOpacity(0.7),
                        ),
                      ),

                    // Description section
                    if (state.description != null && state.description!.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16 * responsive),
                        decoration: BoxDecoration(
                          color: AppTheme.getColor(context).surface,
                          borderRadius: BorderRadius.circular(12 * responsive),
                          border: Border.all(
                            color: AppTheme.getColor(context).outline.withOpacity(0.2),
                          ),
                        ),
                        child: CustomText(
                          state.description!,
                          fontSize: 16 * Responsive.getResponsiveText(context),
                          fontWeight: FontWeight.w400,
                          color: AppTheme.getColor(context).onSurface,
                          textAlign: TextAlign.start,
                        ),
                      ),
                  ],
                ),
              );
            }

            // Loading or initial state
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}