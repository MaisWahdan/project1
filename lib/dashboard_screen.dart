import 'package:flutter/material.dart';

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
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: widget.isDarkMode ? Colors.white : Colors.black),
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
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Add navigation logic to settings
                Navigator.pop(context);
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
                    : Colors.red, // اللون الأخضر للزيادة والأحمر للنقصان
              ),
            ),
          ],
        ),
      ),
    );
  }
}
