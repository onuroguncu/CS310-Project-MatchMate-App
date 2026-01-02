import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false; // Hata veren değişken eklendi

  User? get user => _user;
  bool get isLoading => _isLoading; // Getter eklendi

  AuthProvider() {
    _authService.user.listen((User? newUser) {
      _user = newUser;
      notifyListeners();
    });
  }

  // Yükleme durumunu değiştiren yardımcı fonksiyon
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    final result = await _authService.signIn(email, password);
    _setLoading(false);
    return result != null;
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    final result = await _authService.signUp(email, password);
    _setLoading(false);
    return result != null;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}