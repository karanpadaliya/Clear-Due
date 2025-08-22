import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:myco_flutter/core/theme/app_theme.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/payslip/presentation/bloc/payslip_bloc.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// ignore: must_be_immutable
class PayslipWebViewScreen extends StatefulWidget {
  final String url;

  const PayslipWebViewScreen({required this.url, super.key});

  @override
  State<PayslipWebViewScreen> createState() => _PayslipWebViewScreenState();
}

class _PayslipWebViewScreenState extends State<PayslipWebViewScreen> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CustomAppbar(
      title: 'Payslip',
      actions: [
        BlocBuilder<PayslipBloc, PayslipState>(
          builder: (context, state) {
            // when webview is loading or there is an error we don't show print button
            if (state.isWebviewLoading || state.webViewError.isNotEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              onPressed: () async {
                await _webViewController?.printCurrentPage();
              },
              icon: Icon(
                Icons.print,
                color: AppTheme.getColor(context).primary,
              ),
            );
          },
        ),
      ],
    ),
    body: BlocBuilder<PayslipBloc, PayslipState>(
      // Stack to show either loading indicator or error or webview
      // Because inside InAppWebView we can't show flutter widgets
      builder: (context, state) => Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              context.read<PayslipBloc>().add(
                const WebviewLoadingEvent(
                  webviewLoading: true,
                  webViewError: '',
                ),
              );
            },
            onLoadStop: (controller, url) async {
              context.read<PayslipBloc>().add(
                const WebviewLoadingEvent(
                  webviewLoading: false,
                  webViewError: '',
                ),
              );
            },
            onReceivedError: (controller, request, error) {
              context.read<PayslipBloc>().add(
                WebviewLoadingEvent(
                  webviewLoading: false,
                  webViewError: 'Error Loading Page : ${error.description}',
                ),
              );
            },
          ),
          if (state.isWebviewLoading)
            Center(
              child: CircularProgressIndicator(
                color: AppTheme.getColor(context).primary,
              ),
            ),
          if (state.webViewError.isNotEmpty)
            Center(
              child: CustomText(
                state.webViewError,
                color: AppTheme.getColor(context).error,
                fontSize: 16 * Responsive.getResponsiveText(context),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    ),
  );
}
