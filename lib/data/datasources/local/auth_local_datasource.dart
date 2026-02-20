import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences prefs;

  static const _keyEmail = 'auth_email';
  static const _keyPassword = 'auth_password';
  static const _keyOnboarding = 'onboarding_completed';

  AuthLocalDataSource({
    required this.secureStorage,
    required this.prefs,
  });

  String _hash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  Future<void> saveCredentials(String email, String password) async {
    await secureStorage.write(key: _keyEmail, value: email);
    await secureStorage.write(
      key: _keyPassword,
      value: _hash(password),
    );
  }

  Future<bool> validateCredentials(String email, String password) async {
    final savedEmail = await secureStorage.read(key: _keyEmail);
    final savedPassword = await secureStorage.read(key: _keyPassword);

    return savedEmail == email &&
        savedPassword == _hash(password);
  }

  Future<bool> hasCredentials() async {
    final email = await secureStorage.read(key: _keyEmail);
    return email != null;
  }

  Future<void> clear() async {
    await secureStorage.deleteAll();
  }

  bool isOnboardingCompleted() {
    return prefs.getBool(_keyOnboarding) ?? false;
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_keyOnboarding, true);
  }
}