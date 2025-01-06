import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';
import 'sign_up_screen.dart';
import 'profile_screen.dart'; // استيراد الملف الذي يحتوي على شاشة الملف الشخصي
import 'notifications_screen.dart'; // استيراد شاشة الإشعارات
import 'device_control_screen.dart'; // استيراد شاشة التحكم بالجهاز
import 'package:app/ConsumptionReportScreen.dart'; // استيراد صفحة تقرير الاستهلاك

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional App',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: widget.isLoggedIn
          ? DashboardScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode)
          : LoginScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      routes: {
        '/login': (context) => LoginScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/signup': (context) => SignUpScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/dashboard': (context) => DashboardScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/profile': (context) => ProfileScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/notifications': (context) => NotificationsScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/deviceControl': (context) => DeviceControlScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
        '/consumptionReport': (context) => ConsumptionReportScreen(isDarkMode: isDarkMode),  // إضافة المسار لتقرير الاستهلاك
      },
    );
  }
}
