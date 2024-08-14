import 'package:ecommerce_app/core/network/network_info_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockInternetConnectionChecker connectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp((){
    connectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(connectionChecker);
  });

  test('should forward the result of the package', () async {
    final returnedResult = Future.value(true);
    // arrage
    when(connectionChecker.hasConnection).thenAnswer((_) => returnedResult);

    // act
    var result = networkInfoImpl.isConnected;

    // assert
    verify(connectionChecker.hasConnection);
    expect(result, returnedResult);
  });
}