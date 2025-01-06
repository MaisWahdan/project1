import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  NotificationsScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // قائمة بالإشعارات
  List<Map<String, String>> notifications = [
    {
      'title': 'Scheduled Device Activation',
      'message': 'The previously detected leak has been resolved. No further action needed.',
      'icon': 'home' // نوع الأيقونة
    },
    {
      'title': 'Gas Leak Alert',
      'message': 'Your selected device has been turned on as per your schedule.',
      'icon': 'fire' // نوع الأيقونة
    },
    {
      'title': 'Water Leak Detected',
      'message': 'The previously detected leak has been resolved. No further action needed.',
      'icon': 'water' // نوع الأيقونة
    },
  ];

  // منطق مسح جميع الإشعارات
  void clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  // منطق حذف إشعار فردي
  void removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: widget.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: widget.toggleTheme,
          ),
          TextButton(
            onPressed: clearAllNotifications, // مسح جميع الإشعارات
            child: Text(
              'Clear All',
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return buildNotificationCard(
              icon: notifications[index]['icon']!, // أيقونة الإشعار
              title: notifications[index]['title']!,
              message: notifications[index]['message']!,
              isDarkMode: widget.isDarkMode,
              onClose: () => removeNotification(index), // إضافة منطق لحذف الإشعار
            );
          },
        ),
      ),
    );
  }

  Widget buildNotificationCard({
    required String icon,
    required String title,
    required String message,
    required bool isDarkMode,
    required VoidCallback onClose, // دالة لحذف الإشعار
  }) {
    Color iconColor;

    // تحديد اللون المناسب لكل أيقونة
    switch (icon) {
      case 'home':
        iconColor = Colors.blue;
        break;
      case 'fire':
        iconColor = Colors.orange;
        break;
      case 'water':
        iconColor = Colors.blueAccent;
        break;
      default:
        iconColor = Colors.grey;
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: isDarkMode ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // حواف مدورة
      ),
      elevation: 8, // تأثير الظل
      shadowColor: Colors.black.withOpacity(0.2),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        leading: CircleAvatar(
          radius: 30, // حجم الدائرة
          backgroundColor: iconColor.withOpacity(0.2), // لون خلفية الدائرة
          child: Icon(
            icon == 'home'
                ? Icons.home
                : icon == 'fire'
                ? Icons.local_fire_department
                : Icons.water_damage_outlined,
            color: iconColor, // أيقونة بألوان مخصصة
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white70 : Colors.grey[800],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black),
          onPressed: onClose, // حذف الإشعار عند الضغط على X
        ),
      ),
    );
  }
}
