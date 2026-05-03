import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_texts.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.notificationTitle.tr()),
      ),
      body: Center(
        child: Text(AppTexts.noNotificationFound.tr()),
      ),
    );
  }
}
