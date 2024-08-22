import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
abstract class TokenHandler {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class TokenHandlerImpl implements TokenHandler {
  final SharedPreferences sharedPreferences;

  TokenHandlerImpl({required this.sharedPreferences});

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString('token') ?? '';
  }

  @override
  Future<void> removeToken() async {
    if (sharedPreferences.containsKey('token')) {
      await sharedPreferences.remove('token');
    } else {
      throw CacheException();
    }
  }
}