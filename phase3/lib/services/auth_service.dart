import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Auth State Stream (Hata veren 'user' getter'ı burası)
  Stream<User?> get user => _auth.authStateChanges();

  // 2. Sign Up (Kayıt - Provider'ın beklediği isim)
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // 3. Sign In (Giriş - Provider'ın beklediği isim)
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  // Logout
  Future<void> signOut() async => await _auth.signOut();
}