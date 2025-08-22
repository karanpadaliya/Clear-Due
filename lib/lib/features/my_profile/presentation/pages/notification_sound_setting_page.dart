import 'package:flutter/material.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';

class NotificationSoundSettingPage extends StatefulWidget {
  const NotificationSoundSettingPage({super.key});

  @override
  State<NotificationSoundSettingPage> createState() =>
      _NotificationSoundSettingPageState();
}

class _NotificationSoundSettingPageState
    extends State<NotificationSoundSettingPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) => const Scaffold(
    appBar: CustomAppbar(isKey: true, title: 'sound_settings'),
    body: SingleChildScrollView(child: Column()),
    // body: NotificationSoundSettingCard(
    //   isSwitched: isSwitched,
    //   onToggle: (value) {
    //     setState(() {
    //       isSwitched = value;
    //     });
    //   },
    // ),
  );
}
