import 'dart:convert';

import 'package:http/http.dart' as http;

class EventsApi{
  static Future<List<dynamic>>? getEvents(String userId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/users/$userId/events/');
      Map<String, String> headers = {'content-type': 'application/json'};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
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
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({
        'name': requestEvent['name'],
        'total': 0,
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
}