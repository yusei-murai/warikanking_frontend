import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warikanking_frontend/apis/friends_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class SelectFriendsPage extends StatefulWidget {
  const SelectFriendsPage({Key? key}) : super(key: key);

  @override
  State<SelectFriendsPage> createState() => _SelectFriendsPageState();
}

class _SelectFriendsPageState extends State<SelectFriendsPage> {
  @override
  Widget build(BuildContext context) {
    List<String> checkboxState = [];
    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>?>(
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
      ),
    );
  }
}
