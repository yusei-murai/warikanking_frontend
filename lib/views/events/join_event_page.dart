import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warikanking_frontend/apis/events_api.dart';

class JoinEventPage extends StatelessWidget {
  JoinEventPage(this.eventId);
  String eventId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'このイベントに参加しますか？',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              eventId,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var _result = await EventsApi.addUserEvent([], eventId);
                    if(_result == true){
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  child: const Text('キャンセル'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('はい'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
