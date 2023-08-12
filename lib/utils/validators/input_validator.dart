import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

const String emptyStr = "入力してください";
const String notEmojiStr = "絵文字のみが使用可能です";
const String notEmojiOver20Str = "20文字まで、絵文字のみが使用可能です";
const String invalidEmailStr = "Emailアドレスを入力してください";
const String invalidPassStr = "パスワードは8文字以上、半角英数を含むようにしてください";

class InputValidator{
  static String? emptyValidator(value) {
    if (value == null || value.isEmpty) {
      return emptyStr;
    }
    return null;
  }

  static String? emailValidator(value){
    if ((value == null) || !EmailValidator.validate(value)) {
      return invalidEmailStr;
    }
    return null;
  }

  static String? userValidator(value){
    if ((value == null) || !EmailValidator.validate(value)) {
      return invalidEmailStr;
    }
    return null;
  }

  static String? passValidator(value){
    RegExp passRegex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)$');
    if ((value == null) || !passRegex.hasMatch(value) || value.length < 8) {
      return invalidPassStr;
    }
    return null;
  }

}