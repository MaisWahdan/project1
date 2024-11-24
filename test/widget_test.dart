import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/login_screen.dart'; // تأكد من تعديل مسار الملف بناءً على بنية مجلدات مشروعك

void main() {
  testWidgets('LoginScreen has email, password fields, and login button', (WidgetTester tester) async {
    // تحميل واجهة LoginScreen في الاختبار
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(
        toggleTheme: () {},
        isDarkMode: false,
      ),
    ));

    // التحقق من وجود حقول الإدخال لاسم المستخدم وكلمة المرور
    expect(find.byType(TextFormField), findsNWidgets(2)); // حقلين: واحد لاسم المستخدم وآخر لكلمة المرور

    // التحقق من وجود زر تسجيل الدخول
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // إدخال اسم المستخدم وكلمة المرور
    await tester.enterText(find.byType(TextFormField).first, 'testuser');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // النقر على زر تسجيل الدخول
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // إعادة بناء واجهة المستخدم بعد النقر
    await tester.pump();
  });
}
