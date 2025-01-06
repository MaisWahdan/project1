import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // استيراد مكتبة intl لتنسيق التواريخ

class ConsumptionReportScreen extends StatefulWidget {
  final bool isDarkMode;

  ConsumptionReportScreen({required this.isDarkMode});

  @override
  _ConsumptionReportScreenState createState() =>
      _ConsumptionReportScreenState();
}

class _ConsumptionReportScreenState extends State<ConsumptionReportScreen> {
  DateTime? startDate;
  DateTime? endDate;

  // دالة لاختيار تاريخ البداية
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  // دالة لاختيار تاريخ النهاية
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != endDate)
      setState(() {
        endDate = picked;
      });
  }

  // دالة لعرض التقرير بعد تحديد التواريخ
  void _showReport() {
    if (startDate != null && endDate != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Consumption Report'),
            content: Text(
              'Showing usage report from ${DateFormat('yMd').format(startDate!)} to ${DateFormat('yMd').format(endDate!)} for water, gas, and energy usage.',
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
      // إذا لم يتم اختيار التواريخ
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select both start and end date.'),
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
    bool isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Consumption Reports'),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select a date range to view detailed reports on your water, gas, and energy usage.',
              style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 32),
            // اختيار تاريخ البداية
            Row(
              children: [
                Text(
                  'Start date: ',
                  style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
                ),
                TextButton(
                  onPressed: () => _selectStartDate(context),
                  child: Text(
                    startDate == null
                        ? 'Select Start Date'
                        : DateFormat('yMd').format(startDate!),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.blueAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // اختيار تاريخ النهاية
            Row(
              children: [
                Text(
                  'End date: ',
                  style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white : Colors.black),
                ),
                TextButton(
                  onPressed: () => _selectEndDate(context),
                  child: Text(
                    endDate == null
                        ? 'Select End Date'
                        : DateFormat('yMd').format(endDate!),
                    style: TextStyle(color: isDarkMode ? Colors.white : Colors.blueAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            // زر عرض التقرير
            ElevatedButton(
              onPressed: _showReport,
              child: Text('Generate Report'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), backgroundColor: isDarkMode ? Colors.blueAccent : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
