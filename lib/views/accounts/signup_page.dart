import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/apis/accounts_api.dart';
import 'package:warikanking_frontend/providers/hide_password_provider.dart';
import 'package:warikanking_frontend/views/accounts/signin_page.dart';

class SetSignupErrorMessage with ChangeNotifier {
  String errorMsg = "";

  void setErrorMessage(String msg) {
    errorMsg = msg;
    notifyListeners();
  }
}

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController userIdentifierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hidePassword = Provider.of<ChangeHidePassword>(context);
    final errorMsg = Provider.of<SetSignupErrorMessage>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(errorMsg.errorMsg,style: const TextStyle(color: Colors.red),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      //hintText: '名前',
                      icon: Icon(Icons.perm_identity_outlined),
                      labelText: '名前',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      hintText: 'example@mail.com',
                      labelText: 'メールアドレス',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: userIdentifierController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      hintText: 'sample_user',
                      labelText: 'ID',
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: passController,
                    obscureText: hidePassword.hidePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.lock),
                      labelText: 'パスワード',
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword.hidePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          hidePassword.changeHidePassword();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () async {
                      if(nameController.text.isNotEmpty&&
                          emailController.text.isNotEmpty&&
                          passController.text.isNotEmpty&&
                      userIdentifierController.text.isNotEmpty
                      ){
                        var _result = await AccountsApi.createUser(nameController.text, userIdentifierController.text, emailController.text, passController.text);
                      }else{
                        errorMsg.setErrorMessage("入力項目に誤りがあります");
                      }
                    },
                    child: const Text('アカウントを作成'),
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const TextSpan(text: "アカウント作成済の方は"),
                          TextSpan(
                              text: "こちらからログイン",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
                              }
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
