import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:warikanking_frontend/providers/hide_password_provider.dart';
import 'package:warikanking_frontend/utils/apis/accounts/accounts_api.dart';
import 'package:warikanking_frontend/utils/usecases/signin_usecase.dart';
import 'package:warikanking_frontend/views/accounts/signup_page.dart';

class SetSigninErrorMessage with ChangeNotifier {
  String errorMsg = "";

  void setErrorMessage(String msg) {
    errorMsg = msg;
    notifyListeners();
  }
}

class SigninPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hidePassword = Provider.of<ChangeHidePassword>(context);
    final errorMsg = Provider.of<SetSigninErrorMessage>(context);

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
                      if(emailController.text.isNotEmpty&&
                          passController.text.isNotEmpty) {
                        //var _result = await AccountsApi.getToken(emailController.text, passController.text);
                        var _result = await SigninUsecase.signinUsecase(emailController.text, passController.text);
                        if(_result == null){
                          errorMsg.setErrorMessage("ログインに失敗しました");
                        }
                      }else{
                        errorMsg.setErrorMessage("入力項目に誤りがあります");
                      }
                    },
                    child: const Text('ログイン'),
                  ),
                  const SizedBox(height: 10,),
                  RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const TextSpan(text: "アカウント作成がお済みでない方は"),
                          TextSpan(
                              text: "こちら",
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
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
