import 'dart:convert';

import 'package:warikanking_frontend/infras/secure_storage_infra.dart';
import 'package:http/http.dart' as http;

class FriendsApi{
  static Future<List?> getFriends(String userId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/friends/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=utf8','Authorization': 'JWT ${jwtToken['access']}'};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 403){
        throw Exception('login');
      } else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      throw Exception(e);
    }
  }
}