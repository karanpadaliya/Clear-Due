import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/core/shimmer/common_shimmer.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';
import 'package:myco_flutter/features/circular/presentation/bloc/circular_bloc.dart';
import 'package:myco_flutter/features/circular/presentation/pages/circular_dialog.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/widgets/custom_month_year_picker_header/month_year_header.dart';

class CircularPage extends StatefulWidget {
  const CircularPage({super.key});

  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  // --- State Variables ---
  String startDate = '';
  String endDate = '';
  final int month = DateTime.now().month;
  final int year = DateTime.now().year;

  bool _showAll = true;
  String _searchQuery = '';
  bool _isLoading = true; // <-- State variable added and initialized

  List<NoticeEntity>? _cachedNotices;
  List<NoticeEntity> _unreadNotices = [];

  @override
  void initState() {
    super.initState();
    final firstDay = DateTime(year, month);
    final lastDay = DateTime(year, month + 1, 0);
    startDate = firstDay.toIso8601String().substring(0, 10);
    endDate = lastDay.toIso8601String().substring(0, 10);

    _fetchNoticeFilter();
  }

  void _fetchNoticeFilter() {
    // When fetching new data, set loading to true
    setState(() {
      _isLoading = true;
    });
    context.read<CircularBloc>().add(
      NoticeFilterList(
        startDate: startDate.toString(),
        endDate: endDate.toString(),
      ),
    );
  }

  void _updateUnreadList() {
    if (_cachedNotices == null) {
      _unreadNotices = [];
      return;
    }
    _unreadNotices = _cachedNotices!
        .where((notice) => !(notice.readStatus ?? true))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final r = Responsive.getResponsive(context);

    final List<NoticeEntity> baseList =
    _showAll ? (_cachedNotices ?? []) : _unreadNotices;

    final List<NoticeEntity> displayList;
    if (_searchQuery.isEmpty) {
      displayList = baseList;
    } else {
      displayList = baseList.where((notice) {
        final title = notice.noticeTitle?.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return title.contains(query);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // Add padding only to the left side
        leading: Padding(
          padding: EdgeInsets.only(left: 10 * Responsive.getResponsive(context)),
          child: IconButton(
            icon: Image.asset('assets/sign_in/back_arrow.png', height: 24, width: 24),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        title: const Text('Circular'),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0 * r),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAll = !_showAll;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.darksecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15 * r),
                  ),
                ),
                child: Text(
                  _showAll ? 'Unread (${_unreadNotices.length})' : 'Show All',
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * r, vertical: 8 * r),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: LanguageManager().get('search'),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: ImageIcon(
                      AssetImage('assets/take_order/search-normal.png'),
                      size: 20,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15 * r),
                  borderSide: const BorderSide(color: AppColors.gray10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15 * r),
                  borderSide: const BorderSide(color: AppColors.gray10),
                ),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 10.0 * r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * r, vertical: 16 * r),
            child: MonthYearHeader(
              allowAll: false,
              startYear: 2022,
              endYear: 2026,
              iconSize: 24.0 * r,
              onChanged: (month, year) {
                // We don't need setState here since _fetchNoticeFilter will handle it
                final firstDay = DateTime(year, month);
                final lastDay = DateTime(year, month + 1, 0);
                startDate = firstDay.toIso8601String().substring(0, 10);
                endDate = lastDay.toIso8601String().substring(0, 10);
                _fetchNoticeFilter();
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<CircularBloc, CircularState>(
              listener: (context, state) {
                if (state is NoticeFilterApiSuccess) {
                  setState(() {
                    _isLoading = false;
                    _cachedNotices = state.response.notices;
                    _updateUnreadList();
                  });
                } else if (state is CircularApiError) {
                  setState(() {
                    _isLoading = false;
                  });
                  Fluttertoast.showToast(
                    msg: state.message,
                    backgroundColor: AppColors.greenDark,
                    textColor: AppColors.white,
                  );
                }
              },
              builder: (context, state) {
                if (_isLoading) {
                  return const CommonShimmer();
                }

                if (displayList.isEmpty) {
                  return Center(
                    child: Text(
                      _searchQuery.isEmpty
                          ? (_showAll
                          ? 'No circulars found for this period.'
                          : 'No unread circulars.')
                          : 'No circulars found for your search.',
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * r,
                  ).copyWith(bottom: 40 * r),
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final notice = displayList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16 * r),
                      child: NoticeCard(
                        noticeId: notice.noticeBoardId,
                        title: notice.noticeTitle ?? 'No Title',
                        dateTime: notice.noticeTime ?? '',
                        description: notice.noticeDescription ?? 'No Description',
                        attachmentUrl: notice.noticeAttachment,
                        r: r,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Your NoticeCard class remains the same
class NoticeCard extends StatelessWidget {
  final String? noticeId;
  final String title;
  final String dateTime;
  final String description;
  final String? attachmentUrl;
  final double r;

  const NoticeCard({
    required this.noticeId,
    required this.title,
    required this.dateTime,
    required this.description,
    required this.r,
    super.key,
    this.attachmentUrl,
  });

  @override
  Widget build(BuildContext context) {
    final circularBloc = BlocProvider.of<CircularBloc>(context);

    void openCircularDialog() {
      showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 0.8,
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext innerContext) =>
            Builder(builder: (context) => BlocProvider.value(
                value: circularBloc,
                child: CircularDialog(noticeId: noticeId ?? ''),
              )),
      );
    }

    return InkWell(
      onTap: openCircularDialog,
      borderRadius: BorderRadius.circular(12 * r),
      child: CommonCard(
        title: title,
        subTitle: dateTime,
        headerColor: AppColors.primary,
        bottomWidget: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: AppColors.borderColor.withAlpha(200),
                width: 10,
              ),
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16 * r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[700], height: 1.4),
                ),
                SizedBox(height: 12 * r),
                Row(
                  children: [
                    if (attachmentUrl != null && attachmentUrl!.isNotEmpty)
                      Text(
                        LanguageManager().get('view_attachment'),
                        style: const TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const Spacer(),
                    SvgPicture.asset(
                      AppAssets.circleArrowDown,
                      width: 25 * r,
                      height: 25 * r,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}