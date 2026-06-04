import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexo_app/auth/auth_service.dart';

class LoginRepository {
  final AuthService _authService = AuthService();

  Future<UserCredential?> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    _authService.signOut();
  }
}
