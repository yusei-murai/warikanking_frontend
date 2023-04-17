import 'package:warikanking_frontend/utils/apis/accounts/accounts_api.dart';
import 'package:warikanking_frontend/utils/infras/secure_storage_infra.dart';

class SigninUsecase{
  static Future<dynamic> signinUsecase(String email, String password) async {
    var _result = await AccountsApi.getToken(email, password);
    if(_result != null){
      await SecureStorageInfra.setStorage("access", _result['access']);
      await SecureStorageInfra.setStorage("refresh", _result['refresh']);
      return true;
    }else{
      return null;
    }
  }
}