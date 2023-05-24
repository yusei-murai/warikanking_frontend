import 'package:flutter/material.dart';
import 'package:warikanking_frontend/apis/accounts_api.dart';
import 'package:warikanking_frontend/apis/events_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class AdjustEventPage extends StatelessWidget {
  final String eventId;
  final String eventName;

  const AdjustEventPage({Key? key, required this.eventId, required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(eventName, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: EventsApi.adjustEvents(eventId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: snapshot.data![index]['adjust_user']['adjust_user_name'],
                                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text: ' から ',
                                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  ),
                                  TextSpan(
                                    text: snapshot.data![index]['adjusted_user']['adjusted_user_name'],
                                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text: ' へ',
                                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: snapshot.data![index]['amount_pay'].toString(),
                                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  const TextSpan(
                                    text: ' 円',
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  const TextSpan(
                                    text: ' 支払う',
                                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }else{
                  return const Text("精算がありません");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
