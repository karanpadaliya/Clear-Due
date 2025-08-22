import 'package:dartz/dartz.dart';
import 'package:myco_flutter/core/error/failure.dart';
import 'package:myco_flutter/core/utils/safe_api_call.dart';
import 'package:myco_flutter/features/circular/data/data_source/circular_data_source.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';
import 'package:myco_flutter/features/circular/domain/repositories/circular_repository.dart';

class CircularRepositoryImpl implements CircularRepository {
  final CircularDataSource remoteDataSource;
  final SafeApiCall safeApiCall;

  CircularRepositoryImpl(this.remoteDataSource, this.safeApiCall);

  @override
  Future<Either<Failure, NoticeBoardResponseEntity>> getNoticeFilter(NoticeFilterRequest request) async => safeApiCall.execute(() async {
        final responseModel = await remoteDataSource.getNoticeFilter(request);
        return responseModel.toEntity();
      });
  @override
  Future<Either<Failure, NoticeBoardResponseEntity>> callNoticeSingle(NoticeSingleRequest request) async => safeApiCall.execute(() async {
        final responseModel = await remoteDataSource.callNoticeSingle(request);
        return responseModel.toEntity();
      });
}