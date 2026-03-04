import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences prefs;

  static const _keyEmail = 'auth_email';
  static const _keyPassword = 'auth_password';
  static const _keySession = 'auth_logged_in';
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
    await setLoggedIn(true);
  }

  Future<bool> validateCredentials(String email, String password) async {
    final savedEmail = await secureStorage.read(key: _keyEmail);
    final savedPassword = await secureStorage.read(key: _keyPassword);

    return savedEmail == email &&
        savedPassword == _hash(password);
  }

  Future<bool> hasActiveSession() async {
    final email = await secureStorage.read(key: _keyEmail);
    final password = await secureStorage.read(key: _keyPassword);
    final hasStoredAccount = email != null && password != null;
    final sessionFlag = prefs.getBool(_keySession);

    // Migration: old installs had no separate session flag.
    if (sessionFlag == null) {
      return hasStoredAccount;
    }

    return hasStoredAccount && sessionFlag;
  }

  Future<void> setLoggedIn(bool value) async {
    await prefs.setBool(_keySession, value);
  }

  bool isOnboardingCompleted() {
    return prefs.getBool(_keyOnboarding) ?? false;
  }

  Future<void> completeOnboarding() async {
    await prefs.setBool(_keyOnboarding, true);
  }
}
