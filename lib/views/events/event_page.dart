import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:warikanking_frontend/apis/pays_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';
import 'package:warikanking_frontend/views/events/adjust_event_page.dart';
import 'package:warikanking_frontend/views/pays/new_pay_page.dart';

class EventPage extends StatelessWidget {
  final String eventId;
  final String eventName;

  const EventPage({Key? key,required this.eventId,required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          Center(
            child: Text(
              eventName,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPayPage()),
                  );
                },
                child: const Text('支払い追加'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdjustEventPage(eventId: eventId, eventName: eventName)),
                  );
                },
                child: const Text('精算'),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: const Text(
              '支払い一覧',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<List?>(
              stream: Stream.fromFuture(PaysApi.getPays(eventId)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Text(snapshot.data![index]['name']), subtitle: Text(snapshot.data![index]['name']),
                          trailing: Text(DateFormat('yyyy/M/d').format(DateTime.parse(snapshot.data![index]['created_at'])),style: const TextStyle(fontSize: 12.0)),
                        );
                      }
                  );
                }else{
                  return const Text("支払いがありません");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}