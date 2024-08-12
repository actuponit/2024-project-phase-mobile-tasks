import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetSingleProductUsecase {
  final ProductRepository repository;

  GetSingleProductUsecase(this.repository);

  Future<Either<Failure, Product>> execute(String id) async {
    return await repository.getSingleProduct(id);
  }
}