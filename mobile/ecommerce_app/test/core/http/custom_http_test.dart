import 'package:ecommerce_app/core/http/custom_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main()  {
  late MockClient client;
  late MockTokenHandler tokenHandler;
  late CustomHttp customHttp;

  String token = 'token';
  setUp((){
    client = MockClient();
    tokenHandler = MockTokenHandler();
    customHttp = CustomHttp(client: client, tokenHandler: tokenHandler);
  });

  test('should add headers to request', () async {
    // arrange
    when(client.send(any)).thenAnswer((_) async => StreamedResponse(const Stream.empty(), 200));
    when(tokenHandler.getToken()).thenAnswer((_) async => token);
    final request = Request('GET', Uri.parse(''));
    // act
    await customHttp.send(request);
    // assert
    expect(request.headers['Content-Type'], 'application/json');
    expect(request.headers['Accept'], 'application/json');
    expect(request.headers['Authorization'], 'Bearer $token');
  });
}