import 'package:flutter/material.dart';
import 'package:warikanking_frontend/apis/events_api.dart';
import 'package:warikanking_frontend/apis/friends_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  var checkboxState = ["9b08b2d5-8bba-4a68-8d6c-e93d6ae274c7"];
  final eventNameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.createAppbar(context, TextButton(
        onPressed: () async {
          if (eventNameInputController.text.isNotEmpty &&
              eventNameInputController.text != "" &&
              checkboxState.length > 1
          ){
            var result = await EventsApi.createEvents({
              "name": eventNameInputController.text,
              "user_ids": checkboxState,
            });
            if (result is Map<String, dynamic>) {
              Navigator.pop(context);
            }
          }
        },
        child: const Text("イベント作成"),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                    FutureBuilder<List<dynamic>?>(
                      future: FriendsApi.getFriends("9b08b2d5-8bba-4a68-8d6c-e93d6ae274c7"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final userId = snapshot.data![index]['friend_user']['friend_user_id'];
                              final userName = snapshot.data![index]['friend_user']['friend_user_name'];
                              final isChecked = checkboxState.contains(userId);


                              return CheckboxListTile(
                                title: Text(userName),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value != null && value) {
                                      checkboxState.add(userId);
                                    } else {
                                      checkboxState.remove(userId);
                                    }
                                  });
                                },
                              );
                            },
                          );
                        } else {
                          return const Text("ユーザデータがありません");
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
