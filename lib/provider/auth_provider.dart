import 'package:todowoo/model/register_model.dart';
import 'package:todowoo/networking/api_base_helper.dart';
import 'package:todowoo/repository/user_repository.dart';

class AuthProvider {
  static final ApiBaseHelper _helper = ApiBaseHelper();

  static const String baseRoute = '/api';

  static Future<dynamic> login(RegisterModel model) async => _helper.post(
        '$baseRoute/login',
        data: model.toJson(),
      );

  static void logout() => UserRepository.shared.deleteJWT();

  static Future<dynamic> register(RegisterModel model) async {
    final response = await _helper.post(
      '$baseRoute/signup',
      data: model.toJson(),
    );
    return response;
  }
}
