import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uk_driving_test/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('currentUser');
    if (userData != null) {
      _user = UserModel.fromJson(
        Map<String, dynamic>.from(json.decode(userData) as Map),
      );
      notifyListeners();
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if email already exists
      final usersJson = prefs.getString('registeredUsers') ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson) as Map);

      if (users.containsKey(email)) {
        _error = 'An account with this email already exists';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Create user
      final user = UserModel(
        id: _generateId(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      // Store hashed password
      final hashedPassword = _hashPassword(password);
      users[email] = {'user': user.toJson(), 'password': hashedPassword};

      await prefs.setString('registeredUsers', json.encode(users));
      await prefs.setString('currentUser', json.encode(user.toJson()));

      _user = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create account. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString('registeredUsers') ?? '{}';
      final users = Map<String, dynamic>.from(json.decode(usersJson) as Map);

      if (!users.containsKey(email)) {
        _error = 'No account found with this email';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final stored = Map<String, dynamic>.from(users[email] as Map);
      final hashedPassword = _hashPassword(password);

      if (stored['password'] != hashedPassword) {
        _error = 'Incorrect password';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final user = UserModel.fromJson(
        Map<String, dynamic>.from(stored['user'] as Map),
      );
      await prefs.setString('currentUser', json.encode(user.toJson()));

      _user = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Login failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    _user = null;
    notifyListeners();
  }

  Future<bool> updateName(String newName) async {
    if (_user == null) return false;
    final updatedUser = UserModel(
      id: _user!.id,
      name: newName,
      email: _user!.email,
      createdAt: _user!.createdAt,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', json.encode(updatedUser.toJson()));

    // Also update in registered users store
    final usersJson = prefs.getString('registeredUsers') ?? '{}';
    final users = Map<String, dynamic>.from(json.decode(usersJson) as Map);
    if (users.containsKey(_user!.email)) {
      final stored = Map<String, dynamic>.from(users[_user!.email] as Map);
      stored['user'] = updatedUser.toJson();
      users[_user!.email] = stored;
      await prefs.setString('registeredUsers', json.encode(users));
    }

    _user = updatedUser;
    notifyListeners();
    return true;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  String _generateId() {
    final rng = Random.secure();
    return List.generate(
      16,
      (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
  }
}
