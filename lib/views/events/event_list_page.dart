import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warikanking_frontend/apis/events_api.dart';
import 'package:warikanking_frontend/usecases/get_events_usecase.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';
import 'package:warikanking_frontend/views/events/event_page.dart';

class EventListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: FutureBuilder<dynamic>(
        future: GetEventsUsecase.getEvents("12c7be59-1b7c-40a4-bda0-34793282dc77"),
        builder: (BuildContext context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(snapshot.data![index]['name']),
                    onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => EventPage(eventId: snapshot.data![index]['id'], eventName: snapshot.data![index]['name'])),
                       );
                    },
                  );
                }
            );
          }else{
            return const Text("イベントがありません");
          }
        }
        ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => NewEventPage()),
            // );
          }
      ),
      );
  }
}
