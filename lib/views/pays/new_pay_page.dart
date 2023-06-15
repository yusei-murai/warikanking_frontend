import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warikanking_frontend/apis/accounts_api.dart';
import 'package:warikanking_frontend/apis/pays_api.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class NewPayPage extends StatefulWidget {
  final String eventId;

  NewPayPage(this.eventId);

  @override
  _NewPayPageState createState() => _NewPayPageState();
}

class _NewPayPageState extends State<NewPayPage> {
  String? selectedUser;
  Set<String> checkboxState = {};
  final payNameInputController = TextEditingController();
  final amountPayInputController = TextEditingController();

  late Future<Map<String, dynamic>?> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = fetchUser(widget.eventId);
  }

  Future<Map<String, dynamic>?> fetchUser(String eventId) async {
    var result = await AccountsApi.getUsersDictByEventId(eventId);
    if(result != null){
      return result;
    }else{
      return null;
    }
  }

  bool isCorrectCheckbox(List checkboxState,String selectedUser){
    if (checkboxState.contains(selectedUser) && checkboxState.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.createAppbar(
        context,
        TextButton(
          onPressed: () async {
            if (payNameInputController.text.isNotEmpty &&
                selectedUser != null &&
                isCorrectCheckbox(checkboxState.toList(), selectedUser!) &&
                checkboxState.isNotEmpty &&
                amountPayInputController.text.isNotEmpty) {
              final amountPay = int.tryParse(amountPayInputController.text);
              if(amountPay != null){
                var result = await PaysApi.createPays({
                  "name": payNameInputController.text,
                  "event_id": widget.eventId,
                  "user_id": selectedUser!,
                  "related_users": checkboxState.toList(),
                  "amount_pay": int.parse(amountPayInputController.text),
                });
                if(result is Map<String, dynamic> && mounted){
                  Navigator.pop(context);
                }
              }
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '何を立て替えた？',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: payNameInputController,
                      decoration: const InputDecoration(
                        hintText: '立て替えたもの',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //validator: DescriptionValidator.validate,
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '立て替えた人',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: usersFuture,
                      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('エラー: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final users = snapshot.data!;
                          return DropdownButton<String>(
                            value: selectedUser,
                            items: users.entries.map((MapEntry<String, dynamic> entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedUser = newValue;
                              });
                            },
                          );
                        } else {
                          return const Text("ユーザデータがありません");
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '関わった人（支払い者含む）',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: usersFuture,
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
                              final userId = users.keys.elementAt(index);
                              final userName = users.values.elementAt(index);
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
                    const Text(
                      '金額',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: amountPayInputController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        hintText: '金額を入力してください',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}