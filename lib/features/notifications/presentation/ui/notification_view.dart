import 'package:flutter/material.dart';
import 'package:habispace/utils/app_color.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Not Notification Found'),
      ),

    );
  }
}
