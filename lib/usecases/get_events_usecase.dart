import 'package:flutter/cupertino.dart';
import 'package:warikanking_frontend/apis/events_api.dart';

class GetEventsUsecase{
  static Future<dynamic> getEvents(String userId, BuildContext context) async {
    try{
      var _result = await EventsApi.getEvents(userId,context);
      return _result;
    }catch(e){
      // if(e.toString()=="Exception: Exception: login"){
      //    return "login";
      //  }
      return null;
    }
  }
}