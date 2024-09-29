import 'package:mobile_itmu/framework/managers/secure_storage_config/secure_storage_db_service.dart';

abstract class AuthenticationLocalDatasource {
  Future<void> saveRefreshToken(String value);
}

class AuthenticationLocalDatasourceImpl extends AuthenticationLocalDatasource {
  AuthenticationLocalDatasourceImpl({required this.secureStorageDbService});

  final SecureStorageDbService secureStorageDbService;
  @override
  Future<void> saveRefreshToken(String value) async {
    await secureStorageDbService.writeData(value);
  }
}
