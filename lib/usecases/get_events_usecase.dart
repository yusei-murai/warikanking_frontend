import 'package:warikanking_frontend/apis/events_api.dart';

class GetEventsUsecase{
  static Future<dynamic> getEvents(String userId) async {
    try{
      var _result = await EventsApi.getEvents(userId);
      return _result;
    }catch(e){
      if(e=="login"){
        return "login";
      }
      return null;
    }
  }
}