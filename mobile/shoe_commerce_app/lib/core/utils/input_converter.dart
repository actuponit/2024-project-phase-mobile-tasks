import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

const INVALID_INPUT_FAILURE_MESSAGE = 'Invalid input - The number must be a positive double';

class InputConverter {
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      final price = double.parse(str);
      if (price < 0) throw const FormatException();
      return Right(price);
    } on FormatException {
      return const Left(InvalidInputFailure(INVALID_INPUT_FAILURE_MESSAGE));
    }
  }
}