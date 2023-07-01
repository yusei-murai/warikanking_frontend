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
  Future<dynamic>? _eventsFuture;

  @override
  void initState() {
    super.initState();
    _refreshEvents();
  }

  Future<void> _refreshEvents() async {
    setState(() {
      _eventsFuture = GetEventsUsecase.getEvents("9b08b2d5-8bba-4a68-8d6c-e93d6ae274c7");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: RefreshIndicator(
          onRefresh: _refreshEvents,
          child: FutureBuilder<dynamic>(
            future: _eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('データの取得に失敗しました。'),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data == "login") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninPage()),
                  );
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data![index]['name']),
                        trailing: Text(
                          DateFormat('yyyy/M/d').format(DateTime.parse(snapshot.data![index]['created_at'])),
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventPage(eventId: snapshot.data![index]['id'], eventName: snapshot.data![index]['name'])),
                          ).then((value) {
                            _refreshEvents();
                          });
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("イベントがありません"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}