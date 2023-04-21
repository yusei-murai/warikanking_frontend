import 'dart:convert';

import 'package:http/http.dart' as http;

class PaysApi{
  static Future<List<dynamic>>? getPays(String eventId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/get-pays/');
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({
        'event_id': eventId,
      });

      http.Response response = await http.post(url, headers: headers, body: body);

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
}