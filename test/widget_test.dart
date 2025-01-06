import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/login_screen.dart'; // تأكد من مسار الملف بناءً على مكان الملف
import 'package:mockito/mockito.dart';  // استيراد مكتبة mockito لمحاكاة FirebaseAuth
import 'MockFirebaseAuth.dart';  // استيراد MockFirebaseAuth بعد تغيير اسم الملف
import 'package:app/dashboard_screen.dart';  // تأكد من مسار الملف بناءً على مكانه


void main() {
  testWidgets('LoginScreen has email, password fields, and login button', (WidgetTester tester) async {
    // محاكاة FirebaseAuth
    final mockFirebaseAuth = MockFirebaseAuth();

    // تحميل واجهة LoginScreen في الاختبار
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(
        toggleTheme: () {},
        isDarkMode: false,
      ),
    ));

    // التحقق من وجود حقول الإدخال لاسم المستخدم وكلمة المرور
    expect(find.byType(TextFormField), findsNWidgets(2));  // التحقق من وجود حقلين: بريد إلكتروني وكلمة مرور

    // التحقق من وجود زر تسجيل الدخول
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // إدخال اسم المستخدم وكلمة المرور
    await tester.enterText(find.byType(TextFormField).first, 'testuser@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'password123');

    // محاكاة النقر على زر تسجيل الدخول
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // محاكاة عملية تسجيل الدخول باستخدام mockFirebaseAuth
    await tester.pump();

    // التحقق من أنه تم الانتقال إلى شاشة Dashboard بعد تسجيل الدخول
    expect(find.byType(DashboardScreen), findsOneWidget);  // تأكد من أنه تم الانتقال إلى صفحة Dashboard
  });
}
