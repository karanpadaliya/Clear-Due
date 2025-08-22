import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';

abstract class CircularRepository {
  Future<Either<Failure, NoticeBoardResponseEntity>> getNoticeFilter(NoticeFilterRequest request);
  Future<Either<Failure, NoticeBoardResponseEntity>> callNoticeSingle(NoticeSingleRequest request);
}