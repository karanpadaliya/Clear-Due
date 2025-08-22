import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:myco_flutter/constants/app_assets.dart';
import 'package:myco_flutter/constants/constants.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/asset/presentation/widgets/qr_scanner.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool isFlashOn = false;

  void toggleFlashlight() {
    _scannerController.toggleTorch();
    setState(() => isFlashOn = !isFlashOn);
    log('Flash toggled: ${isFlashOn ? "ON" : "OFF"}');
  }

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        isKey: true,
        title: 'scan_asset',
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: _scannerController.switchCamera,
            child: Image.asset(
              AppAssets.imageCamera,
              width: 0.07 * Responsive.getWidth(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left:
                  VariableBag.screenHorizontalPadding *
                  Responsive.getResponsive(context),
              right:
                  VariableBag.screenHorizontalPadding *
                  Responsive.getResponsive(context),
            ),
            child: GestureDetector(
              onTap: toggleFlashlight,
              child: SvgPicture.asset(
                AppAssets.assetsVector,
                width: 0.07 * Responsive.getWidth(context),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              VariableBag.screenHorizontalPadding *
              Responsive.getResponsive(context),
        ),
        child: Column(
          children: [
            SizedBox(height: 0.02 * Responsive.getHeight(context)),
            Center(
              child: QRScannerWidget(
                controller: _scannerController,
                boarderRadius: VariableBag.commonCardBorderRadius,
                height: 0.5 * Responsive.getHeight(context),
                width: double.infinity, //0.85 * Responsive.getWidth(context),
                imageButtonSpacing:
                    VariableBag.formContentSpacingVertical *
                    Responsive.getResponsive(context),
                onScanned: (data) {
                  log(name: 'Qr scanned data', data.toString());

                  Navigator.pop(context);
                  // Navigator.pop(context, data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
