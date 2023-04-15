import 'package:flutter/material.dart';

class ChangeHidePassword with ChangeNotifier {
  bool hidePassword = true;

  void changeHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }
}