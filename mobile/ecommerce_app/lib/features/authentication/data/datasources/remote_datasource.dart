import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/http/custom_http.dart';
import '../../../../core/urls/auth.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<String> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<UserModel> getUser();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final CustomHttp client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser() async {
    final response = await client.get(Uri.parse(me));
    if (response.statusCode != 200) {
      throw ServerException();
    }
    final userJson = json.decode(response.body)['data'];
    return UserModel.fromJson(userJson);
  }

  @override
  Future<String> login(String email, String password) async {
    final response = await client.post(Uri.parse(loginUrl), body: json.encode({'email': email, 'password': password}));
    if (response.statusCode != 201) {
      throw ServerException();
    }
    final token = json.decode(response.body)['data']['access_token'];
    return token;
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    final response = await client.post(Uri.parse(signupUrl), body: json.encode({'email': email, 'password': password, 'name': name}));
    if (response.statusCode != 201) {
      throw ServerException();
    }
    final userJson = json.decode(response.body)['data'];
    return UserModel.fromJson(userJson);
  }

}