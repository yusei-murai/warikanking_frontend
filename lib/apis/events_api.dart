import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';

class EventsApi{
  static Future<List?> getEvents(String userId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/events/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=utf8','Authentication': 'JWT ${jwtToken['access']}'};

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
      throw Exception('Failed to load data');
    }
  }

  static Future<List<dynamic>>? createEvents(Map<String,dynamic> requestEvent) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/create/');
      Map<String, String> headers = {'content-type': 'application/json; charset=utf8'};
      String body = json.encode({
        'name': requestEvent['name'],
        'user_ids': requestEvent['user_ids']
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else {
        var data = jsonDecode(response.body);
        throw Exception(data[0]);
      }
    }catch(e){
      throw Exception('Failed to load data');
    }
  }

  static Future<List?> adjustEvents(String eventId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/adjustment/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json','Authentication': 'JWT ${jwtToken['access']}'};

      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 403){
        throw Exception('login');
      } else {
        var data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    }catch(e){
      throw Exception('Failed to load data');
    }
  }
}