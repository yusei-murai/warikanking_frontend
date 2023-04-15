import 'package:flutter/material.dart';

class ErrorMsg with ChangeNotifier {
  bool hidePassword = true;

  void changeHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
}