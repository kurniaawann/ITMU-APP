import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_itmu/framework/core/logger/config_logger.dart';

class SecureStorageDbService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> writeData(String value) async {
    try {
      await _secureStorage.write(key: 'refreshToken', value: value);
    } catch (e) {
      logger().e("error write Data", e);
    }
  }

  Future<String?> readData(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      logger().e('Error read Data', e);
      return null;
    }
  }

  Future<void> deleteData({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      logger().e('Error delete data', e);
    }
  }

  Future<bool> checkUserLoggedIn() async {
    final storageService = SecureStorageDbService();
    String? token = await storageService.readData('refreshToken');
    return token != null && token.isNotEmpty;
  }
}
