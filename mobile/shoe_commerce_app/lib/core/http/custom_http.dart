import 'package:http/http.dart';

import '../../features/authentication/data/datasources/token_handler.dart';

class CustomHttp extends BaseClient {
  final Client client;
  final TokenHandler tokenHandler;

  CustomHttp({required this.client, required this.tokenHandler});

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    final token = await tokenHandler.getToken();
    request.headers['Authorization'] = 'Bearer $token';
    return client.send(request);
  }
}