import 'package:mobile_itmu/features/auth/data/models/login_model.dart';
import 'package:mobile_itmu/features/auth/data/models/login_params.dart';
import 'package:mobile_itmu/framework/core/exceptions/app_exceptions.dart';
import 'package:mobile_itmu/framework/managers/http_managers.dart';

abstract class AuthenticationRemoteDatasource {
  Future<LoginModel> login(LoginParams loginParams);
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  AuthenticationRemoteDatasourceImpl({required this.httpManager});
  final HttpManager httpManager;
  @override
  Future<LoginModel> login(LoginParams loginParams) {
    return _signInWithCredentials('/authentication/user', loginParams.toJson());
  }

  Future<LoginModel> _signInWithCredentials(
      String url, Map<String, dynamic> body) async {
    final response = await httpManager.post(
      url: url,
      body: body,
    );

    if (response.statusCode == 201) {
      final loginModel = LoginModel.fromJson(response.data['data']);
      return loginModel;
    } else {
      throw ServerException();
    }
  }
}
