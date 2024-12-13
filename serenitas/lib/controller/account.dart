import 'package:flutter/material.dart';
import 'dart:typed_data';

class AccountData extends ChangeNotifier {
  final Map<String, Map<String, dynamic>> _registeredUsers = {}; // Change profilePicture to dynamic
  String? _currentUser;

  String? get currentUser => _currentUser;

  String? get currentGender {
    if (_currentUser != null && _registeredUsers[_currentUser] != null) {
      return _registeredUsers[_currentUser]!['gender'] as String?;
    }
    return null;
  }

  Uint8List? get profilePicture {
    if (_currentUser != null && _registeredUsers[_currentUser] != null) {
      return _registeredUsers[_currentUser]!['profilePicture'] as Uint8List?;
    }
    return null;
  }

  bool login(String username, String password) {
    if (_registeredUsers.containsKey(username) &&
        _registeredUsers[username]?['password'] == password) {
      _currentUser = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool register(String username, String password, String gender) {
    if (_registeredUsers.containsKey(username)) {
      return false;
    }
    _registeredUsers[username] = {
      'password': password,
      'gender': gender,
      'profilePicture': null, // Default profile picture is null
    };
    notifyListeners();
    return true;
  }

  void updateProfilePicture(Uint8List newProfilePicture) {
    if (_currentUser != null && _registeredUsers[_currentUser] != null) {
      _registeredUsers[_currentUser]!['profilePicture'] = newProfilePicture;
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}