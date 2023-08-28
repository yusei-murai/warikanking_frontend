import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';
import 'package:warikanking_frontend/usecases/signin_usecase.dart';

class EventsApi{
  static Future<List?> getEvents(String userId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/events/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

      http.Response response = await http.get(url, headers: headers);
      print(jwtToken['access']);
      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          throw Exception('login');
        }
        jwtToken = await SecureStorageInfra.readAllStorage();
        headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
        response = await http.get(url, headers: headers);
      }
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
      }
      throw Exception('Failed to load data');

    }catch(e){
      throw Exception(e);
    }
  }

  static Future<Map<dynamic, dynamic>>? createEvents(Map<String,dynamic> requestEvent) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

      String body = json.encode({
        'name': requestEvent['name'],
        'user_ids': requestEvent['user_ids'] ?? []
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          throw Exception('login');
        }
        jwtToken = await SecureStorageInfra.readAllStorage();
        headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
        response = await http.post(url, headers: headers, body: body);
      }
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return data;
      }
      throw Exception('Failed to load data');
    }catch(e){
      throw Exception(e);
    }
  }

  static Future<bool>? addUserEvent(List requestUsers, String eventId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/users/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

      String body = json.encode({
        'user_ids': requestUsers
      });

      http.Response response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          throw Exception('login');
        }
        jwtToken = await SecureStorageInfra.readAllStorage();
        headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
        response = await http.patch(url, headers: headers, body: body);
      }
      if (response.statusCode == 200) {
        return true;
      }
      throw Exception('Failed to load data');
    }catch(e){
      throw Exception(e);
    }
  }

  static Future<List?> adjustEvents(String eventId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/adjustment/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json','Authorization': 'JWT ${jwtToken['access']}'};

      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          throw Exception('login');
        }
        jwtToken = await SecureStorageInfra.readAllStorage();
        headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
        response = await http.get(url, headers: headers);
      }
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
      }
      var data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }catch(e){
      throw Exception(e);
    }
  }
}