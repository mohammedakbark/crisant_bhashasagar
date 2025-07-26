import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String notificationId;
  final DateTime timestamp;

  const NotificationTile({
    super.key,
    required this.title,
    required this.notificationId,
    required this.timestamp,
  });

  String _formatTimestamp(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inDays == 0) {
      return 'Today, ${DateFormat.jm().format(time)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat.jm().format(time)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(time);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Card(
      color: AppColors.kWhite,
      child: ListTile(
        title: Text(title, style: AppStyle.normalStyle()),
        subtitle: Text(
          _formatTimestamp(timestamp),
          style:  AppStyle.smallStyle(color: AppColors.kGrey),
        ),
        leading: CircleAvatar(
          child: Icon(Icons.notifications_active, color: AppColors.kWhite),
        ),
      ),
    );
  }
}
