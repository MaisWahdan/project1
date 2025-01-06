import 'package:flutter/material.dart';

class DeviceControlScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  DeviceControlScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _DeviceControlScreenState createState() => _DeviceControlScreenState();
}

class _DeviceControlScreenState extends State<DeviceControlScreen> {
  String? selectedDevice;
  List<String> devices = ['Water', 'Gas', 'Energy']; // قائمة الأجهزة
  TimeOfDay? selectedTime; // الوقت المختار

  // لتحديد الوقت باستخدام TimePicker
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // تفعيل الجهاز بناءً على الوقت المحدد
  void _activateDevice() {
    if (selectedDevice != null && selectedTime != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Device Activated'),
            content: Text(
              'The $selectedDevice will be turned off at ${selectedTime!.format(context)}.',
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // في حالة عدم اختيار الجهاز أو الوقت
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select a device and a time.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Control'),
        centerTitle: true,
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.blueAccent,
        elevation: 0,
        actions: [
          // تغيير الثيم بين الداكن والفاتح
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.white,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 32),
            // اختيار الجهاز
            _buildDropdown(
              label: 'Select a device',
              value: selectedDevice,
              items: devices,
              onChanged: (value) {
                setState(() {
                  selectedDevice = value;
                });
              },
            ),
            SizedBox(height: 20),
            // اختيار الوقت
            TextButton(
              onPressed: _selectTime,
              child: Text(
                selectedTime == null
                    ? 'Select Time'
                    : 'Time: ${selectedTime!.format(context)}',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),
            // زر تفعيل الجهاز
            ElevatedButton(
              onPressed: _activateDevice,
              child: Text('Activate Device Control'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), backgroundColor: widget.isDarkMode ? Colors.blueAccent : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(label),
      items: items.map((device) {
        return DropdownMenuItem<String>(
          value: device,
          child: Row(
            children: [
              // استخدام الأيقونات بدلاً من الصور
              Icon(
                device == 'Water'
                    ? Icons.water_damage_outlined
                    : device == 'Gas'
                    ? Icons.local_fire_department
                    : Icons.bolt,
                color: Colors.blue,
                size: 24,
              ),
              SizedBox(width: 10),
              Text(device),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
