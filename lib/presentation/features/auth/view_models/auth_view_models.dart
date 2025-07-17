import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  // Example state variables
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Example method to simulate a login process
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));

    // Example: Handle success or error
    _isLoading = false;
    // _errorMessage = "Invalid credentials"; // Uncomment to simulate an error
    notifyListeners();
  }
}