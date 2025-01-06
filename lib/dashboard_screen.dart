import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'device_control_screen.dart';
import 'ConsumptionReportScreen.dart'; // استيراد صفحة تقرير الاستهلاك

class DashboardScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  DashboardScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: widget.isDarkMode ? Colors.grey[800] : Colors.blueAccent,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Dashboard', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Profile', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // انتقل إلى شاشة الـ Profile عند الضغط
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      toggleTheme: widget.toggleTheme,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Notifications', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // انتقل إلى شاشة الإشعارات عند الضغط
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsScreen(
                      toggleTheme: widget.toggleTheme,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Settings', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // إضافة منطق التنقل إلى الإعدادات
                Navigator.pop(context);
              },
            ),
            // إضافة قائمة جديدة للتحكم بالجهاز
            ListTile(
              leading: Icon(Icons.devices, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Device Control', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // انتقل إلى شاشة التحكم بالجهاز عند الضغط
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeviceControlScreen(
                      toggleTheme: widget.toggleTheme,
                      isDarkMode: widget.isDarkMode,
                    ),
                  ),
                );
              },
            ),
            // إضافة خيار لتقرير الاستهلاك
            ListTile(
              leading: Icon(Icons.receipt, color: widget.isDarkMode ? Colors.white : Colors.black),
              title: Text('Consumption Reports', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
              onTap: () {
                // انتقل إلى صفحة تقرير الاستهلاك
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsumptionReportScreen(isDarkMode: widget.isDarkMode),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Monitor your water, gas, and energy levels with real-time updates.',
              style: TextStyle(
                fontSize: 16,
                color: widget.isDarkMode ? Colors.white70 : Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildSensorCard(
                    icon: Icons.water_damage_outlined,
                    title: 'Water',
                    color: Colors.blue,
                    level: '75%',
                    lastUpdate: 'Increased',
                    isDarkMode: widget.isDarkMode,
                  ),
                  buildSensorCard(
                    icon: Icons.local_fire_department,
                    title: 'Gas',
                    color: Colors.orange,
                    level: '50%',
                    lastUpdate: 'Decreased',
                    isDarkMode: widget.isDarkMode,
                  ),
                  buildSensorCard(
                    icon: Icons.bolt,
                    title: 'Energy',
                    color: Colors.yellow[700]!,
                    level: '90%',
                    lastUpdate: 'Increased',
                    isDarkMode: widget.isDarkMode,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSensorCard({
    required IconData icon,
    required String title,
    required Color color,
    required String level,
    required String lastUpdate,
    required bool isDarkMode,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level: $level',
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white70 : Colors.grey[800],
              ),
            ),
            Text(
              'Last Update: $lastUpdate',
              style: TextStyle(
                fontSize: 16,
                color: lastUpdate == 'Increased'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
