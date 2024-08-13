import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase implements UseCase<Product, DeleteProducntParams> {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(DeleteProducntParams params) async {
    return await repository.deleteProduct(params.id);
  }
}

class DeleteProducntParams extends Equatable {
  final String id;

  const DeleteProducntParams(this.id);

  @override
  List<Object?> get props => [id];
}
