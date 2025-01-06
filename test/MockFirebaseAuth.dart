import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

// محاكاة كلاس User
class UserMock extends Mock implements User {
  final String uid;
  final String email;

  UserMock({required this.uid, required this.email});
}

// محاكاة كلاس UserCredential
class UserCredentialMock extends Mock implements UserCredential {
  final UserMock user;

  UserCredentialMock({required this.user});
}

// محاكاة كلاس MockFirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // محاكاة عملية تسجيل الدخول
    return UserCredentialMock(user: UserMock(uid: 'testUid', email: email));
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // محاكاة عملية إنشاء حساب جديد
    return UserCredentialMock(user: UserMock(uid: 'newUserUid', email: email));
  }

  @override
  Stream<User?> authStateChanges() {
    // محاكاة التغييرات في حالة المستخدم
    return Stream.value(UserMock(uid: "testUid", email: "testuser@example.com"));
  }
}
