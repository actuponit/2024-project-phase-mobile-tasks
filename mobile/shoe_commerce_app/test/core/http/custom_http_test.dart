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

  test('should add token to headeer if token exists in shared preferences', () async {
    // arrange
    when(client.send(any)).thenAnswer((_) async => StreamedResponse(const Stream.empty(), 200));
    when(tokenHandler.getToken()).thenAnswer((_) async => token);
    final request = Request('GET', Uri.parse(''));
    // act
    await customHttp.send(request);
    // assert
    verify(tokenHandler.getToken());
    expect(request.headers['Content-Type'], 'application/json');
    expect(request.headers['Accept'], 'application/json');
    expect(request.headers['Authorization'], 'Bearer $token');
  });

  test('should add empty token header to request if token doesn\'t exist', () async {
    // arrange
    when(client.send(any)).thenAnswer((_) async => StreamedResponse(const Stream.empty(), 200));
    when(tokenHandler.getToken()).thenAnswer((_) async => '');
    final request = Request('GET', Uri.parse(''));
    // act
    await customHttp.send(request);
    // assert
    verify(tokenHandler.getToken());
    expect(request.headers['Content-Type'], 'application/json');
    expect(request.headers['Accept'], 'application/json');
    expect(request.headers['Authorization'], 'Bearer ');
  });
}