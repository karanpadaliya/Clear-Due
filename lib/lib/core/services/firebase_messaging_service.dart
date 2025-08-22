import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/core/services/hive_cache_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/core/router/route_paths.dart';
import 'package:myco_flutter/core/router/app_router.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@pragma('vm:entry-point')
class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final HiveCacheService _cacheService = GetIt.I<HiveCacheService>();

  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  static const String _fcmBoxName = 'fcm_box';
  static const String _fcmTokenKey = 'fcm_token_key';

  @pragma('vm:entry-point') // Necessary for background execution
  static void onDidReceiveBackgroundNotificationResponseCallback(NotificationResponse notificationResponse) {
    // This function will be called when a user taps a notification that was triggered by flutter_local_notifications
    // while the app was in the background.
    print('🚨 BACKGROUND Notification Tapped -- Payload: ${notificationResponse.payload}');
    
    // Handle notification click in background
    _handleNotificationClick(notificationResponse.payload, isBackground: true);
  }
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Initialize Firebase if not already initialized (ignore duplicate app errors)
    try {
      if (Firebase.apps.isEmpty) {
        // Use default Firebase initialization which reads from platform-specific config files
        // (GoogleService-Info.plist for iOS, google-services.json for Android)
        await Firebase.initializeApp();
      }
    } catch (firebaseError) {
    }

    // Always show local notification for background messages
    try {
      await showLocalNotification(message);
    } catch (notificationError) {
    }
  }


  Future<void> _requestPermissions() async {

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }


  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Default icon

    // Configure iOS initialization settings with proper callback
     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

    final InitializationSettings initializationSettings =
     InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        // Handle notification click in foreground
        _handleNotificationClick(notificationResponse.payload, isBackground: false);
      },
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponseCallback,
    );
    
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel_custom_sound',
      'High Importance Notifications (Custom Sound)',
      description: 'This channel is used for important notifications with a custom sound.',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('mellow'), // MUST match file in android/app/src/main/res/raw/mellow.mp3
      enableLights: true,
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      showBadge: true,
    );

    final androidPlugin = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(channel);
    }
  }


  Future<void> initNotifications() async {

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    // ... (permission request)
    await _requestPermissions();
    await _initializeLocalNotifications(); // Initialize local notifications

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Always show local notification for foreground messages
      showLocalNotification(message);
    });
    // ...
  }


  Future<String?> getAndSaveFcmToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      if (fcmToken != null && fcmToken.isNotEmpty) {
        print('FCM Token: $fcmToken');
        await _cacheService.put<String>(_fcmBoxName, _fcmTokenKey, fcmToken);
        print('FCM Token saved to Hive.');
        return fcmToken;
      } else {
        print("Failed to get FCM token: Token was null or empty.");
        return null;
      }
    } catch (e) {
      print('Failed to get FCM token or save to Hive: $e');
      return null;
    }
  }

  Future<String?> getSavedFcmToken() async {
    try {
      String? token = await _cacheService.get<String>(_fcmBoxName, _fcmTokenKey);
      if (token != null && token.isNotEmpty) {
        return token;
      } else {
        // If token is not found or is empty, generate and save a new one
        return await getAndSaveFcmToken();
      }
    } catch (e) {
      // If any error occurs during retrieval, try to generate a new token as a fallback
      return await getAndSaveFcmToken();
    }
  }


  static Future<void> showLocalNotification(RemoteMessage message) async {
    try {
      final String? title = message.data['title'];
       final String? body = message.data['body'];
       final String? clickAction = message.data['click_action'];
       final String? societyId = message.data['society_id'];
       final String? menuClick = message.data['menuClick'];
       final String? image = message.data['image'];
       final String? smallIcon = message.data['small_icon'];
       
       print('🔥 Firebase Notification - Data: ${message.data.toString()}');
       print('🔥 Firebase Notification - title: ${title ?? "null"}');
       print('🔥 Firebase Notification - message: ${body ?? "null"}');
       print('🔥 Firebase Notification - clickAction: ${clickAction ?? "null"}');
       print('🔥 Firebase Notification - menuClick: ${menuClick ?? "null"}');
       print('🔥 Firebase Notification - society_id: ${societyId ?? "null"}');
       print('🔥 Firebase Notification - image: ${image ?? "null"}');
       print('🔥 Firebase Notification - small_icon: ${smallIcon ?? "null"}');
       
       // Check if server sent sound configuration
       final String? serverSound = message.data['sound'];
       // Determine which sound to use - server sound takes priority
       String androidSoundName = 'mellow'; // default
       String iosSoundName = 'mellow.caf'; // default
       
       // Available sound files in the app
       const List<String> availableAndroidSounds = ['mellow'];
       const List<String> availableIosSounds = ['mellow.caf'];
       
       if (serverSound != null && serverSound.isNotEmpty) {
         String requestedAndroidSound;
         String requestedIosSound;
         
         if (serverSound.endsWith('.caf')) {
           // Server sent iOS format sound
           requestedIosSound = serverSound;
           requestedAndroidSound = serverSound.replaceAll('.caf', ''); // Remove .caf for Android
         } else {
           // Server sent Android format sound
           requestedAndroidSound = serverSound;
           requestedIosSound = '$serverSound.caf'; // Add .caf for iOS
         }
         
         // Check if requested sounds exist, fallback to default if not
         if (availableAndroidSounds.contains(requestedAndroidSound)) {
           androidSoundName = requestedAndroidSound;
         }
         if (availableIosSounds.contains(requestedIosSound)) {
           iosSoundName = requestedIosSound;
         }
       }

      // Initialize flutter_local_notifications
      final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      
      String? payload;
      
      // Construct payload from message data for navigation
      if (message.data.isNotEmpty) {
        // Create a JSON payload with all the necessary navigation data
        final Map<String, dynamic> payloadData = {
          'menuClick': menuClick,
          'click_action': clickAction,
          'society_id': societyId,
          'title': title,
          'body': body,
        };
        
        // Add any additional data fields that might be useful
        message.data.forEach((key, value) {
          if (!payloadData.containsKey(key)) {
            payloadData[key] = value;
          }
        });
        
        payload = json.encode(payloadData);
      }

      // Extract image URLs
      final String? imageUrl = message.data['image'];
      final String? smallIconUrl = message.data['small_icon'];
      
      // Download images if valid URLs are provided
      Uint8List? largeIconBytes;
      Uint8List? smallIconBytes;
      
      if (_isValidUrl(imageUrl)) {
        largeIconBytes = await _downloadImage(imageUrl!);
      }
      
      if (_isValidUrl(smallIconUrl)) {
        smallIconBytes = await _downloadImage(smallIconUrl!);
      }

      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'high_importance_channel_custom_sound', // MUST MATCH THE CHANNEL ID with custom sound
        'High Importance Notifications (Custom Sound)',
        channelDescription: 'This channel is used for important notifications with a custom sound.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        enableVibration: true,
        playSound: true, // Ensure this is true
        sound: RawResourceAndroidNotificationSound(androidSoundName), // Use dynamic sound from server or default
        icon: smallIconBytes != null ? null : '@mipmap/ic_launcher',
        largeIcon: largeIconBytes != null ? ByteArrayAndroidBitmap(largeIconBytes) : null,
        enableLights: true,
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500,
        fullScreenIntent: true, // This can help make notifications more prominent
        styleInformation: largeIconBytes != null 
            ? BigPictureStyleInformation(
                ByteArrayAndroidBitmap(largeIconBytes),
                largeIcon: smallIconBytes != null ? ByteArrayAndroidBitmap(smallIconBytes) : null,
              )
            : null,
      );
      
      // Create iOS notification details with attachments and custom sound
      List<DarwinNotificationAttachment> attachments = [];
      if (largeIconBytes != null && imageUrl != null) {
        // For iOS, we need to save the image to a temporary file
        final String fileName = 'notification_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final String filePath = '${Directory.systemTemp.path}/$fileName';
        final File imageFile = File(filePath);
        await imageFile.writeAsBytes(largeIconBytes);
        
        attachments.add(DarwinNotificationAttachment(
          filePath,
          identifier: 'image',
        ));
      }

      DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true, // Ensure this is true
        sound: iosSoundName, // Use dynamic sound from server or default
        attachments: attachments,
        categoryIdentifier: 'general',
        threadIdentifier: 'notification_thread',
        interruptionLevel: InterruptionLevel.critical, // This bypasses Focus modes and plays at full volume
      );
      
      NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);
      

      await localNotificationsPlugin.show(
        message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      

    } catch (e) {
      print('Stack trace: ${StackTrace.current}');
    }
  }
  
  // Helper method to validate URL
  static bool _isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
  
  // Helper method to download image from URL
  static Future<Uint8List?> _downloadImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );
      
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Error downloading image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception downloading image: $e');
      return null;
    }
  }

  /// Handles notification click events for both background and foreground states
  /// Parses the payload and navigates to appropriate pages based on menuClick parameter
  static void _handleNotificationClick(String? payload, {required bool isBackground}) {
    if (payload == null || payload.isEmpty) {
      print('📱 No payload data found in notification');
      return;
    }

    try {
      // Parse the JSON payload
      final Map<String, dynamic> data = json.decode(payload);
      
      print('📱 Parsed notification data: $data');
      
      // Extract navigation parameters
      final String? menuClick = data['menuClick'];
      final String? societyId = data['society_id'];
      final String? clickAction = data['click_action'];
      
      print('📱 MenuClick: $menuClick, SocietyId: $societyId, ClickAction: $clickAction');
      
      // Navigate based on menuClick parameter
      _navigateBasedOnMenuClick(menuClick, data, isBackground: isBackground);
      
    } catch (e) {
      print('📱 Error parsing notification payload: $e');
      // Fallback: navigate to dashboard
      _navigateToPage(RoutePaths.dashboard, data: {}, isBackground: isBackground);
    }
  }

  /// Navigates to specific pages based on menuClick parameter
  static void _navigateBasedOnMenuClick(String? menuClick, Map<String, dynamic> data, {required bool isBackground}) {
    if (menuClick == null || menuClick.isEmpty) {
      _navigateToPage(RoutePaths.dashboard, data: data, isBackground: isBackground);
      return;
    }

    String targetRoute;
    
    switch (menuClick.toLowerCase()) {
      // Dashboard and Home
      case 'dashboard':
      case 'home':
        targetRoute = RoutePaths.dashboard;
        break;
        
      // Leave Management
      case 'leave':
      case 'leaves':
      case 'leave_management':
        targetRoute = RoutePaths.leave;
        break;
        
      // Chat and Messages
      case 'chat':
      case 'message':
      case 'messages':
        targetRoute = RoutePaths.chatList;
        break;
        
      // Employee Management
      case 'employee':
      case 'employees':
      case 'member':
        targetRoute = RoutePaths.employees;
        break;
        
      // Visit Management
      case 'visit':
      case 'my_visit':
      case 'visits':
        targetRoute = RoutePaths.myVisit;
        break;
        
      // Assets Management
      case 'asset':
      case 'assets':
      case 'asset_management':
        targetRoute = RoutePaths.assetsHome;
        break;
        
      // Payslip
      case 'payslip':
      case 'salary':
        targetRoute = RoutePaths.payslip;
        break;
        
      // Holidays
      case 'holiday':
      case 'holidays':
        targetRoute = RoutePaths.holiday;
        break;
        
      // Circular/Notice
      case 'circular':
      case 'notice':
      case 'announcement':
        targetRoute = RoutePaths.circular;
        break;
        
      // Gallery
      case 'gallery':
      case 'photos':
        targetRoute = RoutePaths.gallery;
        break;
        
      // Time Sheet
      case 'timesheet':
      case 'time_sheet':
      case 'attendance':
        targetRoute = RoutePaths.timeSheet;
        break;
        
      // Work From Home
      case 'wfh':
      case 'work_from_home':
        targetRoute = RoutePaths.AddWfh;
        break;
        
      // Admin View
      case 'admin':
      case 'admin_view':
        targetRoute = RoutePaths.adminView;
        break;
        
      // Profile
      case 'profile':
      case 'my_profile':
        targetRoute = RoutePaths.myProfile;
        break;
        
      // Appointments
      case 'appointment':
      case 'appointments':
        targetRoute = RoutePaths.appointments;
        break;
        
      // Take Order
      case 'order':
      case 'take_order':
        targetRoute = RoutePaths.takeOrder;
        break;
        
      // Lost and Found
      case 'lost_found':
      case 'lost_and_found':
        targetRoute = RoutePaths.lostAndFound;
        break;
        
      // Work Allocation
      case 'work_allocation':
        targetRoute = RoutePaths.workAllocation;
        break;
        
      // Company Info
      case 'company_info':
      case 'company':
        targetRoute = RoutePaths.companyInfo;
        break;
        
      // Idea Box
      case 'idea_box':
      case 'ideabox':
        targetRoute = RoutePaths.ideabox;
        break;
        
      // Custom Notification
      case 'custom_notification':
        targetRoute = RoutePaths.customNotification;
        break;
        
      // Default case
      default:
        print('📱 Unknown menuClick: $menuClick, navigating to dashboard');
        targetRoute = RoutePaths.dashboard;
        break;
    }
    
    print('📱 Navigating to: $targetRoute based on menuClick: $menuClick with data: $data');
    _navigateToPage(targetRoute, data: data, isBackground: isBackground);
  }

  /// Handles the actual navigation logic
  static void _navigateToPage(String route, {Map<String, dynamic>? data, required bool isBackground}) {
    if (isBackground) {
      // For background notifications, we need to store the navigation intent
      // and handle it when the app comes to foreground
      print('📱 Background navigation intent stored for route: $route with data: $data');
      _storePendingNavigation(route, data: data);
    } else {
      // For foreground notifications, navigate immediately
      print('📱 Foreground navigation to: $route with data: $data');
      _performNavigation(route, data: data);
    }
  }

  /// Stores pending navigation for background notifications
  static void _storePendingNavigation(String route, {Map<String, dynamic>? data}) {
    try {
      final cacheService = GetIt.I<HiveCacheService>();
      final navigationData = {
        'route': route,
        'data': data,
      };
      cacheService.put('pending_navigation', 'navigation_data', navigationData);
      print('📱 Stored pending navigation: $route with data: $data');
    } catch (e) {
      print('📱 Error storing pending navigation: $e');
    }
  }

  /// Performs the actual navigation using GoRouter
  static void _performNavigation(String route, {Map<String, dynamic>? data}) {
    try {
      // Get the current context from GoRouter
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        // Use pushReplacement for better navigation from notifications
        GoRouter.of(context).pushReplacement(route, extra: data);
        print('📱 Successfully navigated to: $route with data: $data');
      } else {
        print('📱 Context not available, retrying navigation in 500ms');
        // Retry navigation after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          _performNavigationWithRetry(route, data: data, retryCount: 0);
        });
      }
    } catch (e) {
      print('📱 Error during navigation: $e');
      // Fallback: try again with retry mechanism
      _performNavigationWithRetry(route, data: data, retryCount: 0);
    }
  }
  
  /// Retry navigation with exponential backoff
  static void _performNavigationWithRetry(String route, {Map<String, dynamic>? data, required int retryCount}) {
    const maxRetries = 3;
    if (retryCount >= maxRetries) {
      print('📱 Max retries reached for navigation to: $route');
      return;
    }
    
    try {
      final context = AppRouter.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        GoRouter.of(context).pushReplacement(route, extra: data);
        print('📱 Successfully navigated to: $route with data: $data (retry $retryCount)');
      } else {
        // Exponential backoff: 500ms, 1s, 2s
        final delay = Duration(milliseconds: 500 * (1 << retryCount));
        print('📱 Context still not available, retrying in ${delay.inMilliseconds}ms (attempt ${retryCount + 1})');
        Future.delayed(delay, () {
          _performNavigationWithRetry(route, data: data, retryCount: retryCount + 1);
        });
      }
    } catch (e) {
      print('📱 Error during navigation retry $retryCount: $e');
      // Try again with next retry
      final delay = Duration(milliseconds: 500 * (1 << retryCount));
      Future.delayed(delay, () {
        _performNavigationWithRetry(route, data: data, retryCount: retryCount + 1);
      });
    }
  }

  /// Checks and handles any pending navigation (call this when app comes to foreground)
  static Future<void> handlePendingNavigation() async {
    try {
      final cacheService = GetIt.I<HiveCacheService>();
      final pendingNavigation = await cacheService.get<Map<String, dynamic>>('pending_navigation', 'navigation_data');
      
      if (pendingNavigation != null) {
        final route = pendingNavigation['route'] as String?;
        final data = pendingNavigation['data'] as Map<String, dynamic>?;
        
        if (route != null && route.isNotEmpty) {
          print('📱 Found pending navigation: $route with data: $data');
          
          // Clear the pending navigation
          await cacheService.delete('pending_navigation', 'navigation_data');
          
          // Perform the navigation
          _performNavigation(route, data: data);
        }
      }
    } catch (e) {
      print('📱 Error handling pending navigation: $e');
    }
  }
}
