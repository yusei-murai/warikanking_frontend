import 'dart:convert';

import 'package:http/http.dart' as http;

class EventsApi{
  static Future<dynamic> getEvents(String userId) async {
    try{
      Uri url = Uri.parse('http://localhost:8000/api/v1/get-events');
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({
        'user_id': userId,
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    }catch(e){
      return null;
    }
  }
}