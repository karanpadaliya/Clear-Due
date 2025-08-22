// 📄 File: edit_leave_request.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class EditLeaveRequestModel extends Equatable {
  final String action;
  final String societyId;
  final String userId;
  final String userName;
  final String leaveId;
  final File? leaveAttachment;
  final String oldAttachmentName;

  const EditLeaveRequestModel({
    required this.societyId,
    required this.userId,
    required this.userName,
    required this.leaveId,
    required this.oldAttachmentName,
    this.leaveAttachment,
    this.action = 'editLeave',
  });

  /// Create FormData for Dio multipart requests
  Future<FormData> toFormData() async {
    final formData = FormData.fromMap(toFields());

    final fileMap = await toFiles();
    for (var entry in fileMap.entries) {
      formData.files.add(MapEntry(entry.key, entry.value));
    }

    return formData;
  }

  /// Converts fields into a Map for the request body
  Map<String, dynamic> toFields() {
    final Map<String, dynamic> map = {
      'editLeave': action,
      'society_id': societyId,
      'user_id': userId,
      'user_name': userName,
      'leave_id': leaveId,
      'old_attachment_name': oldAttachmentName,
    };
    return map;
  }

  /// Handles file fields separately for multipart
  Future<Map<String, MultipartFile>> toFiles() async {
    final files = <String, MultipartFile>{};
    if (leaveAttachment != null) {
      files['leave_attachment'] = await MultipartFile.fromFile(
        leaveAttachment!.path,
      );
    }
    return files;
  }

  @override
  List<Object?> get props => [
    societyId,
    userId,
    userName,
    leaveId,
    oldAttachmentName,
  ];
}
