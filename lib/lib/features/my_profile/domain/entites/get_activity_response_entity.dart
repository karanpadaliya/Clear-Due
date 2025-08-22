import 'package:equatable/equatable.dart';

class GetActivityResponseEntity extends Equatable {
  final bool? viewClearButton;
  final List<LognameEntity>? logname;
  final String? message;
  final String? status;

  const GetActivityResponseEntity({
    this.viewClearButton,
    this.logname,
    this.message,
    this.status,
  });

  @override
  List<Object?> get props => [viewClearButton, logname, message, status];
}

class LognameEntity extends Equatable {
  final String? logId;
  final String? userId;
  final String? logName;
  final String? logImage;
  final String? logTime;

  const LognameEntity({
    this.logId,
    this.userId,
    this.logName,
    this.logImage,
    this.logTime,
  });

  @override
  List<Object?> get props => [logId, userId, logName, logImage, logTime];
}
