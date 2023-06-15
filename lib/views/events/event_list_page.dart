import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/apis/events_api.dart';
import 'package:warikanking_frontend/usecases/get_events_usecase.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';
import 'package:warikanking_frontend/views/events/event_page.dart';

class EventListPage extends StatefulWidget {
  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: FutureBuilder<dynamic>(
          future: GetEventsUsecase.getEvents("9b08b2d5-8bba-4a68-8d6c-e93d6ae274c7"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData){
              if(snapshot.data=="login"){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              }
              return RefreshIndicator(
                backgroundColor: Colors.blue,
                color: Colors.white,
                onRefresh: () async {
                  await GetEventsUsecase.getEvents("9b08b2d5-8bba-4a68-8d6c-e93d6ae274c7");
                },
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index]['name']),
                          trailing: Text(DateFormat('yyyy/M/d').format(DateTime.parse(snapshot.data![index]['created_at'])),style: const TextStyle(fontSize: 12.0)),
                          onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => EventPage(eventId: snapshot.data![index]['id'], eventName: snapshot.data![index]['name'])),
                             ).then((value) {
                               setState(() {});
                             });
                          },
                        ),
                      );
                    }
                ),
              );
            }else{
              return const Text("イベントがありません");
            }
          }
          ),
      ),
      );
  }
}