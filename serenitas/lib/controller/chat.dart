import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  bool _isInChatRoom = false;
  final List<Map<String, String>> _messages = [];

  bool get isInChatRoom => _isInChatRoom;

  List<Map<String, String>> get messages => _messages;

  void switchToChatRoom() {
    _isInChatRoom = true;
    notifyListeners();
  }

  void switchToHomePage() {
    _isInChatRoom = false;
    notifyListeners();
  }

  void addMessage(String text, String sender) {
    _messages.add({"text": text, "sender": sender});
    notifyListeners();
  }

  void resetConversation() {
    _messages.clear();
    notifyListeners();
  }
}
