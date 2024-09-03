import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/utils/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const INVALID_INPUT_FAILURE_MESSAGE = 'Invalid input - The number must be a positive double';

  test('should return double when valid string is given', () {
    // arrange
    const str = '12345';
    final inputConverter = InputConverter();
    // act
    final result = inputConverter.stringToUnsignedDouble(str);
    // assert
    expect(result, const Right(12345));
  });
  
  test('should return Failure when invalid double string is given', () {
    // arrange
    const str = '12345j';
    final inputConverter = InputConverter();
    // act
    final result = inputConverter.stringToUnsignedDouble(str);
    // assert
    expect(result, const Left(InvalidInputFailure(INVALID_INPUT_FAILURE_MESSAGE)));
  });

  test('should reutrn Faliure when stirng of negative numebr is given', () {
    // arrange
    const str = '-12345';
    final inputConverter = InputConverter();
    // act
    final result = inputConverter.stringToUnsignedDouble(str);
    // assert
    expect(result, const Left(InvalidInputFailure(INVALID_INPUT_FAILURE_MESSAGE)));
  });
}