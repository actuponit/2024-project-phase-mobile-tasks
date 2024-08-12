import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUsecase {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  Future<Either<Failure, List<Product>>> execute() async {
    return await repository.getProducts();
  }
}