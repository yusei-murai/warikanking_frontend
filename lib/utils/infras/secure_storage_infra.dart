import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageInfra{
  static Future<dynamic> setStorage(String key,String value) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  //static Future<dynamic> readStrage(){

  //}

  static Future<dynamic> readAllStorage() async {
    final storage = FlutterSecureStorage();
    try{
      Map<String, String> allValues = await storage.readAll();
      return allValues;
    }catch(e){
      return null;
    }
  }

  static Future<dynamic> deleteStorage(String key) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

  static Future<dynamic> deleteAllStorage() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}