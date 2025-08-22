import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/network/api_client.dart';
import 'package:myco_flutter/core/services/preference_manager.dart';
import 'package:myco_flutter/features/circular/data/data_source/circular_data_source.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/data/models/response/notice_board_response.dart';

class CircularDataSourceImpl implements CircularDataSource {
  final Dio dio;

  CircularDataSourceImpl({required this.dio});

  final preferenceManager = GetIt.I<PreferenceManager>();

  @override // It's good practice to add the @override annotation
  Future<NoticeBoardResponse> getNoticeFilter(NoticeFilterRequest request) async {

    final response = await GetIt.I<ApiClient>(instanceName: VariableBag.residentApiNew).postFormDynamic('noticeBoardController.php', request.toJson());
    return NoticeBoardResponse.fromJson(json.decode(response));
  }
  @override // It's good practice to add the @override annotation
  Future<NoticeBoardResponse> callNoticeSingle(NoticeSingleRequest request) async {

    final response = await GetIt.I<ApiClient>(instanceName: VariableBag.residentApiNew).postFormDynamic('noticeBoardController.php', request.toJson());
    return NoticeBoardResponse.fromJson(json.decode(response));
  }
}
