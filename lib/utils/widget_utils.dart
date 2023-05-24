import 'package:flutter/material.dart';
import 'package:warikanking_frontend/apis/accounts_api.dart';

class AppBarUtils {
  static AppBar createAppbar(BuildContext context,TextButton textButton) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: <Widget>[
        textButton,
      ],
    );
  }

  static AppBar screenAppBar(BuildContext context,String title) {
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black),),
      centerTitle: true,
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 1,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}

class SnackBarUtils{
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> doneSnackBar(String msg,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(msg),
      ),
    );
  }
}

class Userutils{
  static Future<String?> getUsername(String userId) async {
    var result = await AccountsApi.getUsername(userId);
    if(result != null){
      return result;
    }else{
      return null;
    }
  }
}