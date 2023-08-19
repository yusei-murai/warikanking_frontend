import 'package:warikanking_frontend/apis/accounts_api.dart';
import 'package:warikanking_frontend/infras/secure_storage_infra.dart';

class SignoutUsecase{
  static Future<void> signoutUsecase() async {
    await SecureStorageInfra.deleteStorage("access");
    await SecureStorageInfra.deleteStorage("refresh");
  }
}