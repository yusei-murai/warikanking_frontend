import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventPage extends StatelessWidget {
  final String eventId;

  const EventPage({Key? key,required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){

        },
      ),
    );
  }
}
