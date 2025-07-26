import 'package:bashasagar/core/components/app_back_button.dart';
import 'package:bashasagar/core/const/appcolors.dart';
import 'package:bashasagar/core/styles/text_styles.dart';
import 'package:bashasagar/core/utils/intl_c.dart';
import 'package:bashasagar/features/notification/screens/widgets/notification_title.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  List<Map<String, dynamic>> notifications = [
    {"title": "Content updated in English", "id": "6", "time": DateTime.now()},
    {
      "title": "Content updated in English",
      "id": "5",
      "time": DateTime(2025, 7, 26, 12, 51),
    },
    {
      "title": "Content updated in English",
      "id": "4",
      "time": DateTime(2025, 7, 25, 12, 51),
    },
    {
      "title": "Content updated in English",
      "id": "3",
      "time": DateTime(2025, 7, 24, 12, 51),
    },
    {
      "title": "Content updated in English",
      "id": "2",
      "time": DateTime(2025, 7, 24, 22, 23),
    },
    {
      "title": "Hi, Welcome Akbar ",
      "id": "1",
      "time": DateTime(2025, 7, 20, 10, 00),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        leading: AppBackButton(),
        backgroundColor: AppColors.kPrimaryColor,

        toolbarHeight: 50,
        surfaceTintColor: AppColors.kWhite,
        title: Text(
          "Notifications",
          style: AppStyle.mediumStyle(fontSize: 18, color: AppColors.kWhite),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        separatorBuilder:
            (context, index) => Divider(color: AppColors.kGreyLight),
        itemCount: notifications.length,
        itemBuilder:
            (context, index) => NotificationTile(
              title: notifications[index]['title'],
              notificationId: notifications[index]['id'],
              timestamp: notifications[index]['time'],
            ),
      ),
    );
  }
}
