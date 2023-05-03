import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/views/accounts/signin_page.dart';

class PaysApi{
  static Future<List<dynamic>>? getPays(String eventId) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/pays/');
      Map<String, String> headers = {'content-type': 'application/json'};
      String body = json.encode({
        'event_id': eventId,
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data;
      } if (response.statusCode == 401){
        
      } else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      throw Exception('Failed to load data');
    }
  }
}