import 'package:todowoo/model/auth.dart';
import 'package:todowoo/model/register_model.dart';
import 'package:todowoo/networking/app_exception.dart';
import 'package:todowoo/provider/auth_provider.dart';
import 'package:todowoo/utils/app_key.dart';
import 'package:todowoo/utils/shared_preferences_util.dart';

class UserRepository {
  UserRepository._privateConstructor();

  static final UserRepository shared = UserRepository._privateConstructor();

  bool get hasJWT {
    return (jwt.isNotEmpty);
  }

  void deleteJWT() async {
    SharedPreferencesUtils.remove(AppKey.kJWT);
  }

  set jwt(String jwt) {
    SharedPreferencesUtils.putString(AppKey.kJWT, jwt);
  }

  String get jwt {
    return SharedPreferencesUtils.getString(AppKey.kJWT) ?? '';
  }

  Future<String?> authenticate({required RegisterModel model}) async {
    if (!validateRegisterModel(model)) return '';
    final response = await AuthProvider.login(model);
    if (response == null) throw const FetchDataException(message: '伺服器無回應');
    return Auth.fromJson(response).token;
  }

  Future<void> unAuthenticate() async => AuthProvider.logout();

  bool validateRegisterModel(RegisterModel registerModel) {
    if (registerModel.username == null) {
      throw const ValidateException(message: '請輸入 Email');
    }
    if (registerModel.username!.isEmpty) {
      throw const ValidateException(message: '請輸入 Email');
    }
    if (registerModel.username == null) {
      throw const ValidateException(message: '請輸入密碼');
    }
    if (registerModel.username!.isEmpty) {
      throw const ValidateException(message: '請輸入密碼');
    }
    return true;
  }
}
