import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/util.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';

class AllAssetsQrGeneratePage extends StatelessWidget {
  final String qr;
  const AllAssetsQrGeneratePage({required this.qr, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const CustomAppbar(title: 'qr_code', isKey: true, titleSpacing: 0),
    body: Center(
      child: Image.memory(Util().base64ToBytes(qr), fit: BoxFit.cover),
    ),
  );
}
