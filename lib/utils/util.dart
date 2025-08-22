import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  // // Private constructor
  // Util._privateConstructor();

  // // Singleton instance
  // static final Util _instance = Util._privateConstructor();

  // // Getter to access the singleton
  // static Util get instance => _instance;
  /// Method to generate password
  static String getCurrentPassword(
    String societyId,
    String userId,
    String userMobile,
  ) {
    final subMobile = _getLastThreeChars(userMobile);
    return '$userId@$subMobile@$societyId';
  }

  /// Utility to get last 3 characters
  static String _getLastThreeChars(String input) {
    if (input.length < 3) return input;
    return input.substring(input.length - 3);
  }

  /// Method to apply opacity to a color
  /// opacity should be between 0.0 and 1.0
  static Color applyOpacity(Color color, double opacity) =>
      color.withAlpha((opacity * 255).round());

  // Method to convert FontWeight to String
  static String getFontFamily(FontWeight? fontWeight) {
    switch (fontWeight) {
      case FontWeight.w100:
        return 'Gilroy-Thin';
      case FontWeight.w200:
        return 'Gilroy-UltraLight';
      case FontWeight.w300:
        return 'Gilroy-Light';
      case FontWeight.w400:
        return 'Gilroy-Regular';
      case FontWeight.w500:
        return 'Gilroy-Medium';
      case FontWeight.w600:
        return 'Gilroy-SemiBold';
      case FontWeight.w700:
        return 'Gilroy-Bold';
      case FontWeight.w800:
        return 'Gilroy-ExtraBold';
      case FontWeight.w900:
        return 'Gilroy-Heavy';
      default:
        return 'Gilroy-Regular';
    }
  }

  // Future<String?> getDeviceId() async {
  //   if (Platform.isAndroid || Platform.isIOS) {
  //     try {
  //       // Use platform_device_id for best persistent ID
  //       return await MobileDeviceIdentifier().getDeviceId();
  //     } catch (e) {
  //       debugPrint('Error getting device ID: $e');
  //     }
  //   }
  //   return null;
  // }

  static String getMonthName(int month) => switch (month) {
    0 => 'All',
    1 => 'January',
    2 => 'February',
    3 => 'March',
    4 => 'April',
    5 => 'May',
    6 => 'June',
    7 => 'July',
    8 => 'August',
    9 => 'September',
    10 => 'October',
    11 => 'November',
    12 => 'December',
    _ => 'Unknown', // Return a non-null String
  };

  // Returns initials from name (e.g., "Karan Padaliya" → "KP", "Single" → "K")
  static String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  /// Formats a date string from "yyyy-MM-dd" to "EEE, dd MMM yyyy".
  /// Returns an empty string if the input is null or parsing fails.
  static String getFormattedDateLeave(String? strDate) {
    if (strDate != null) {
      try {
        final inputFormat = DateFormat('yyyy-MM-dd', 'en_US');
        final outputFormat = DateFormat('EEE, dd MMM yyyy', 'en_US');
        final date = inputFormat.parse(strDate);
        return outputFormat.format(date);
      } catch (e) {
        debugPrint('Error formatting date: $e');
      }
    }
    return '';
  }

  /// Decodes a base64 string into a [Uint8List].
  Uint8List base64ToBytes(String base64String) => base64.decode(base64String);

  /// Format Date
  ///Note: If your date is not in ISO-8601 format and you don’t pass dateTimeInputFormat, parsing will fail.
  static String formatDate({
    required String? originalDateTime,
    required String dateTimeOutputFormat,
    String? dateTimeInputFormat,
  }) {
    if (originalDateTime == null || originalDateTime.isEmpty) {
      return '';
    }
    // If output format is empty, return original string
    if (dateTimeOutputFormat.isEmpty) {
      return originalDateTime;
    }

    try {
      DateTime dateTime;
      if (dateTimeInputFormat != null && dateTimeInputFormat.isNotEmpty) {
        final inputFormatter = DateFormat(dateTimeInputFormat);
        dateTime = inputFormatter.parse(originalDateTime);
      } else {
        dateTime = DateTime.parse(originalDateTime);
      }
      final outputFormatter = DateFormat(dateTimeOutputFormat);
      return outputFormatter.format(dateTime);
    } catch (e) {
      return originalDateTime;
    }
  }
}
