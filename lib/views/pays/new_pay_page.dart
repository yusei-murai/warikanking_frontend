import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class NewPayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.createAppbar(context,
          TextButton(
              onPressed: (){

              },
              child: const Text("立て替え")
          )
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
                      decoration: const InputDecoration(
                        hintText: '立て替えたもの',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '立て替えた人',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      items: <String>['ユーザA', 'ユーザB', 'ユーザC']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {

                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      '関わった人（支払い者含む）',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Consumer<SelectedUsersProvider>(
                      builder: (context, selectedUsersProvider, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedUsersProvider.userList.length,
                          itemBuilder: (context, index) {
                            final user = selectedUsersProvider.userList[index];
                            return CheckboxListTile(
                              title: Text(user),
                              value: selectedUsersProvider.isSelected(user),
                              onChanged: (bool? newValue) {
                                selectedUsersProvider.toggleUserSelection(user);
                              },
                            );
                          },
                        );
                      },
                    ),
                    const Text(
                      '金額',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
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

class SelectedUsersProvider with ChangeNotifier {
  List<String> _selectedUsers = [];

  List<String> get userList => ['ユーザX', 'ユーザY', 'ユーザZ'];

  bool isSelected(String user) => _selectedUsers.contains(user);

  void toggleUserSelection(String user) {
    if (_selectedUsers.contains(user)) {
      _selectedUsers.remove(user);
    } else {
      _selectedUsers.add(user);
    }
    notifyListeners();
  }
}