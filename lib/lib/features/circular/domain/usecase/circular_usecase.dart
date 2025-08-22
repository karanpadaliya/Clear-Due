
import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';
import 'package:myco_flutter/features/circular/domain/repositories/circular_repository.dart';

class CircularUseCase {
  final CircularRepository repository;

  CircularUseCase({required this.repository});

  Future<Either<Failure, NoticeBoardResponseEntity>> callNoticeFilter(NoticeFilterRequest request) async => await repository.getNoticeFilter(request);
  Future<Either<Failure, NoticeBoardResponseEntity>> callNoticeSingle(NoticeSingleRequest request) async => await repository.callNoticeSingle(request);

}