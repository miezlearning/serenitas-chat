import 'package:flutter/material.dart';

class AccountData extends ChangeNotifier {
  final Map<String, Map<String, String>> _registeredUsers = {}; // Stores username-password-gender
  String? _currentUser;

  String? get currentUser => _currentUser;

  String? get currentGender {
  if (_currentUser != null && _registeredUsers[_currentUser] != null) {
    return _registeredUsers[_currentUser]!['gender'];
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
    _registeredUsers[username] = {'password': password, 'gender': gender};
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
