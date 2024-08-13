import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetSingleProductUsecase extends UseCase<Product, GetSingleProductParams> {
  final ProductRepository repository;

  GetSingleProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(GetSingleProductParams params) async {
    return await repository.getSingleProduct(params.id);
  }
}

class GetSingleProductParams extends Equatable {
  final String id;

  const GetSingleProductParams(this.id);

  @override
  List<Object?> get props => [id];
}