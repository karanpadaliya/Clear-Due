import 'package:myco_flutter/features/circular/data/models/request/notice_filter_request.dart';
import 'package:myco_flutter/features/circular/data/models/request/notice_single_request.dart';
import 'package:myco_flutter/features/circular/data/models/response/notice_board_response.dart';

abstract class CircularDataSource {

  Future<NoticeBoardResponse> getNoticeFilter(NoticeFilterRequest request);
  Future<NoticeBoardResponse> callNoticeSingle(NoticeSingleRequest request);

}
