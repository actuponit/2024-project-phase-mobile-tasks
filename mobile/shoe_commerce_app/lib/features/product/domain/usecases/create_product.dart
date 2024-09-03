import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductUseCase extends UseCase<Product, CreateProductParams> {
  final ProductRepository repository;

  CreateProductUseCase(this.repository);

  @override
  Future<Either<Failure, Product>> call(CreateProductParams params) async {
    return await repository.addProduct(params.product);
  }
}

class CreateProductParams extends Equatable {
  final Product product;

  const CreateProductParams(this.product);

  @override
  List<Object?> get props => [product];
}