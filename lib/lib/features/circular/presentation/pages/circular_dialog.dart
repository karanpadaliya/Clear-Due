import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/theme/colors.dart';
import 'package:myco_flutter/core/utils/language_manager.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/custom_image_preview_page.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/image_grid_preview_widget.dart';
import 'package:myco_flutter/features/circular/domain/entity/notice_board_response_entity.dart';
import 'package:myco_flutter/features/circular/presentation/bloc/circular_bloc.dart';
import 'package:myco_flutter/features/circular/presentation/pages/shimmer_circular_dialog.dart';
import 'package:myco_flutter/features/idea_box/presentation/widgets/common_container.dart';
import 'package:myco_flutter/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CircularDialog extends StatefulWidget {
  final String noticeId;
  const CircularDialog({required this.noticeId, super.key});

  @override
  State<CircularDialog> createState() => _CircularDialogState();
}

class _CircularDialogState extends State<CircularDialog> {
  late final WebViewController _webViewController;
  double _webViewHeight = 300.0; // Initial height

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            // This runs after the HTML content is loaded
            // It executes JavaScript to get the content's full scrollable height
            final contentHeight = await _webViewController
                .runJavaScriptReturningResult(
                  'document.documentElement.scrollHeight;',
                );

            if (mounted) {
              setState(() {
                _webViewHeight =
                    double.tryParse(contentHeight.toString()) ?? 300.0;
              });
            }
          },
          // --- THIS IS THE CORRECTED LOGIC ---
          onNavigationRequest: (request) async {
            final url = request.url;
            if (url.startsWith('http') || url.startsWith('https')) {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                Fluttertoast.showToast(
                  msg: 'Could not find an app to open this link',
                );
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _fetchNoticeSingle();
  }

  void _fetchNoticeSingle() {
    context.read<CircularBloc>().add(
      NoticeSingleFetch(noticeId: widget.noticeId),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: 'Could not open the file.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.getResponsive(context);

    return Container(
      padding: EdgeInsets.only(bottom: 40 * r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24 * r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(AppAssets.backArrowDown, width: 75 * r),
          ),
          SizedBox(height: 25 * r),
          Expanded(
            child: BlocConsumer<CircularBloc, CircularState>(
              listener: (context, state) {
                if (state is NoticeSingleApiSuccess) {
                  final notice = state.response.notices?.firstOrNull;
                  if (notice?.noticeDescription?.isNotEmpty == true) {
                    _webViewController.loadHtmlString(
                      notice!.noticeDescription!,
                    );
                  }
                } else if (state is CircularApiError) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    backgroundColor: AppColors.red,
                    textColor: AppColors.white,
                  );
                }
              },
              builder: (context, state) {
                if (state is CircularSingleApiLoading) {
                  return const ShimmerCircularDialog();
                }

                if (state is NoticeSingleApiSuccess) {
                  final notice = state.response.notices?.firstOrNull;
                  if (notice != null) {
                    return _buildSuccessUI(notice, r);
                  }
                }

                return _buildEmptyStateCard(r);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateCard(double r) => Container(
    padding: EdgeInsets.all(20 * r),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no_data_illustration.png',
          height: 150 * r,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.image_not_supported,
            size: 100 * r,
            color: AppColors.gray,
          ),
        ),
        SizedBox(height: 16 * r),
        Text(
          LanguageManager().get('no_data'),
          style: TextStyle(
            fontSize: 14 * r,
            fontWeight: FontWeight.normal,
            color: AppColors.black,
          ),
        ),
      ],
    ),
  );

  Widget _buildSuccessUI(NoticeEntity notice, double r) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20 * r).copyWith(bottom: 20 * r),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical:
                VariableBag.commonCardVerticalPadding *
                Responsive.getResponsive(context),
            horizontal:
                VariableBag.commonCardHorizontalPadding *
                Responsive.getResponsive(context),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(
                (VariableBag.commonCardBorderRadius) *
                        Responsive.getResponsive(context) -
                    3.0,
              ),
              bottom: Radius.circular(
                1 * Responsive.getResponsive(context) - 3.0,
              ),
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: AppTheme.getColor(context).secondary.withAlpha(180),
              ),
              BoxShadow(
                color: AppTheme.getColor(context).secondary,
                offset: const Offset(1, 4),
                spreadRadius: -6.0,
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                notice.noticeTitle!,
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 18 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 4 * r),
              CustomText(
                notice.noticeTime!,
                color: AppTheme.getColor(context).onPrimary,
                fontSize: 14 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
        if (notice.noticeDescription != null &&
            notice.noticeDescription!.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.borderColor,
                          width: 1 * r,
                        ),
                        left: BorderSide(
                          color: AppColors.borderColor,
                          width: 1 * r,
                        ),
                        right: BorderSide(
                          color: AppColors.borderColor,
                          width: 1 * r,
                        ),
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8 * r),
                      ),
                    ),
                    height: _webViewHeight,
                    padding: EdgeInsets.symmetric(vertical: 20 * r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(8 * r),
                      ),
                      child: _webViewController != null
                          ? WebViewWidget(
                              controller: _webViewController,
                              gestureRecognizers: const {
                                Factory<VerticalDragGestureRecognizer>(
                                  VerticalDragGestureRecognizer.new,
                                ),
                              },
                            )
                          : SizedBox(
                              height: 300 * r,
                              child: _buildEmptyStateCard(r),
                            ),
                    ),
                  ),

                  SizedBox(height: 16 * r),
                  if (notice.noticeAttachment != null &&
                      notice.noticeAttachment!.isNotEmpty)
                    _buildAttachmentCard(notice, r),
                ],
              ),
            ),
          )
        else
          SizedBox(height: 300 * r, child: _buildEmptyStateCard(r)),
      ],
    ),
  );

  Widget _buildAttachmentIcon(String url, double r) {
    final lowercasedUrl = url.toLowerCase();

    if (lowercasedUrl.endsWith('.jpg') ||
        lowercasedUrl.endsWith('.jpeg') ||
        lowercasedUrl.endsWith('.png')) {
      return GestureDetector(
        onTap: () {
          ImagePreview(images: [url], startIndex: 1);
          print('Image tapped: $url');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8 * r),
          child: Image.network(
            url,
            height: 70 * r,
            width: 70 * r,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 70 * r,
                width: 70 * r,
                color: AppColors.gray10,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              );
            },
          ),
        ),
      );
    }

    String iconPath;
    if (lowercasedUrl.endsWith('.pdf')) {
      iconPath = AppAssets.pdfIcon;
    } else if (lowercasedUrl.endsWith('.doc') ||
        lowercasedUrl.endsWith('.docx')) {
      iconPath = AppAssets.docIcon;
    } else if (lowercasedUrl.endsWith('.ppt') ||
        lowercasedUrl.endsWith('.pptx')) {
      iconPath = AppAssets.pptxIcon;
    } else if (lowercasedUrl.endsWith('.xls') ||
        lowercasedUrl.endsWith('.xlsx')) {
      iconPath = AppAssets.xlsxIcon;
    } else if (lowercasedUrl.endsWith('.zip')) {
      iconPath = AppAssets.zipIcon;
    } else {
      iconPath = AppAssets.pdfIcon;
    }

    return SvgPicture.asset(iconPath, height: 70 * r, width: 70 * r);
  }

  Widget _buildAttachmentCard(NoticeEntity notice, double r) {
    final attachmentUrl = notice.noticeAttachment ?? '';
    if (attachmentUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    String fileName = 'Attachment';
    try {
      fileName = attachmentUrl.split('/').last;
    } catch (e) {
      // Fallback
    }

    return CommonCard(
      title: LanguageManager().get('view_attachment'),
      bottomWidget: InkWell(
        onTap: () {
          final lowercasedUrl = attachmentUrl.toLowerCase();
          if (lowercasedUrl.endsWith('.pdf') ||
              lowercasedUrl.endsWith('.doc') ||
              lowercasedUrl.endsWith('.ppt') ||
              lowercasedUrl.endsWith('.xls') ||
              lowercasedUrl.endsWith('.zip')) {
            _launchURL(attachmentUrl);
          }
        },
        child: Container(
          padding: EdgeInsets.all(12 * r),
          child: Row(
            children: [
              _buildAttachmentIcon(attachmentUrl, r),
              SizedBox(width: 12 * r),
              Expanded(
                child: Text(
                  fileName,
                  style: TextStyle(
                    fontSize: 14 * r,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
