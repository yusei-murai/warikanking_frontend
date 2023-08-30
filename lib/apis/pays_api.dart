import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';
import 'package:warikanking_frontend/usecases/signin_usecase.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';

class PaysApi{
  static Future<List?> getPays(String eventId, BuildContext context) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$eventId/pays/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          if(context.mounted){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SigninPage()),
            );
          }
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

  static Future<dynamic> createPays(Map<String,dynamic> requestPay, BuildContext context) async {
    try{
      Uri url = Uri.parse('http://10.0.2.2:8000/api/v1/pays/');
      var jwtToken = await SecureStorageInfra.readAllStorage();
      Map<String, String> headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};

      String body = json.encode({
        'name': requestPay['name'],
        'event_id': requestPay['event_id'],
        'related_users': requestPay['related_users'],
        'user_id': requestPay['user_id'],
        'amount_pay': requestPay['amount_pay']
      });

      http.Response response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 401) {
        var ref = await SigninUsecase.refresh(jwtToken['refresh']);
        if (ref != true) {
          if(context.mounted){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SigninPage()),
            );
          }
          throw Exception('login');
        }
        jwtToken = await SecureStorageInfra.readAllStorage();
        headers = {'content-type': 'application/json; charset=UTF-8','Authorization': 'JWT ${jwtToken['access']}'};
        response = await http.get(url, headers: headers);
      }
      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
      if (response.statusCode == 400) {
        return "bad request";
      } else {
        throw Exception('Failed to load data');
      }
    }catch(e){
      throw Exception(e);
    }
  }
}