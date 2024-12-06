import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionProvider extends ChangeNotifier {
  // static const String apiUrl = "https://e1ba-35-231-35-118.ngrok-free.app/predict";
  static const String apiUrl = "https://bc54-2001-448a-6000-da88-17f-b5f-c730-8f8a.ngrok-free.app/predict";
  
  bool _isLoading = false;
  String? _lastResponse;

  bool get isLoading => _isLoading;
  String? get lastResponse => _lastResponse;

  Future<void> getPrediction(String input) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"input": input}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _lastResponse = data["response"];
      } else {
        _lastResponse = "Server error: ${response.statusCode}";
      }
    } catch (e) {
      _lastResponse = "Connection error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
