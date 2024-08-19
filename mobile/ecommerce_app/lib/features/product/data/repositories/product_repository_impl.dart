import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  
  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({required this.networkInfo, required this.remoteDatasource, required this.localDatasource});

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try{
        var products = await remoteDatasource.getProducts();
        localDatasource.cacheProducts(products);
        return Right(products);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    } else {
      try{
        return Right(await localDatasource.getProducts());
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }catch (e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getSingleProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        var product = await remoteDatasource.getSingleProduct(id);
        localDatasource.cacheSingleProduct(product);
        return Right(product);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    } else {
      try{
        return Right(await localDatasource.getSingleProduct());
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      } catch (e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        var updatedProduct = await remoteDatasource.updateProduct(ProductModel.fromEntity(product));
        return Right(updatedProduct as Product);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch (e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    } else {
      return const Left(NoConnection('Can\'t connect to the server'));
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        ProductModel deletedProduct = await remoteDatasource.deleteProduct(id);
        return Right(deletedProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      }
    } else {
      return const Left(NoConnection('Can\'t connect to the server'));
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        ProductModel newProduct = await remoteDatasource.addProduct(ProductModel.fromEntity(product));
        return Right(newProduct);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } catch(e) {
        return const Left(UnexpectedFailure('Unexpected Failure'));
      }
    } else {
      return const Left(NoConnection('Can\'t connect to the server'));
    }
  }

}