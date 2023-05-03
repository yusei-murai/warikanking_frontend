import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warikanking_frontend/apis/pays_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class EventPage extends StatelessWidget {
  final String eventId;
  final String eventName;

  const EventPage({Key? key,required this.eventId,required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: FutureBuilder(
        future: PaysApi.getPays(eventId),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(snapshot.data![index]['title']),
                  );
                }
            );
          }else{
            return const Text("支払いがありません");
          }
        },
      ),
    );
  }
}
