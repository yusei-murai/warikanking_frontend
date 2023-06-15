import 'package:flutter/material.dart';
import 'package:warikanking_frontend/apis/events_api.dart';
import 'package:warikanking_frontend/apis/friends_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class NewEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventNameInputController = TextEditingController();

    return Scaffold(
      appBar: AppBarUtils.createAppbar(context, TextButton(
        onPressed: () async {
              var result = await EventsApi.createEvents({
                "name": eventNameInputController.text,
              });
              if (result is Map<String, dynamic>) {
                Navigator.pop(context);
              }
        },
        child: const Text("立て替え"),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'イベント名',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: eventNameInputController,
                      decoration: const InputDecoration(
                        hintText: '〇〇旅行',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //validator: DescriptionValidator.validate,
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
