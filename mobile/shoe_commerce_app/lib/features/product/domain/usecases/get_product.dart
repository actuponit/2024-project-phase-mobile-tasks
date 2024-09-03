import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProductUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams noParam) async {
    return await repository.getProducts();
  }
}