
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockProductRemoteDatasource mockProductRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late MockProductLocalDatasource mockProductLocalDatasource;
  late ProductRepositoryImpl repository;

  setUp((){
    mockProductRemoteDatasource = MockProductRemoteDatasource();
    mockNetworkInfo = MockNetworkInfo();
    mockProductLocalDatasource = MockProductLocalDatasource();
    repository = ProductRepositoryImpl(
      remoteDatasource: mockProductRemoteDatasource,
      networkInfo: mockNetworkInfo,
      localDatasource: mockProductLocalDatasource
    );
  });

  void runOnlineTests(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runOffineTests(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getProduct', (){
    const products = [
      ProductModel(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 100.0,
        imageUrl: 'image1.jpg',
      ),
      ProductModel(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 200.0,
        imageUrl: 'image2.jpg',
      ),
    ];

    runOnlineTests(() {

      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.getProducts()).thenAnswer((_) async => products);
        // act
        var result = await repository.getProducts();
        // assert
        expect(result, const Right(products as List<Product>));
        verify(mockProductRemoteDatasource.getProducts());
      });
      
      test('should cache the latest remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.getProducts()).thenAnswer((_) async => products);
        // act
        await repository.getProducts();
        // assert
        verify(mockProductRemoteDatasource.getProducts());
        verify(mockProductLocalDatasource.cacheProducts(products));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.getProducts()).thenThrow(ServerException());
        // act
        var result = await repository.getProducts();
        // assert
        verify(mockProductRemoteDatasource.getProducts());
        verifyZeroInteractions(mockProductLocalDatasource);
        expect(result, const Left(ServerFailure('Server Failure')));
      });

    });

    runOffineTests((){

      test('should get local data when there is cached data', () async {
        // arrange
        when(mockProductLocalDatasource.getProducts()).thenAnswer((_) async => products);
        // act
        var result = await repository.getProducts();
        // assert
        verify(mockProductLocalDatasource.getProducts());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Right(products as List<Product>));
      });

      test('should throw CacheFailure when there is no cached data', () async {
        // arrange
        when(mockProductLocalDatasource.getProducts()).thenThrow(CacheException());
        // act
        var result = await repository.getProducts();
        // assert
        verify(mockProductLocalDatasource.getProducts());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(CacheFailure('Cache Failure')));
      });

    });
  });
  group('getSingleProduct', (){
    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'image1.jpg',
    );

    const id = '1';
    

    runOnlineTests(() {
      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.getSingleProduct(id)).thenAnswer((_) async => product);
        // act
        var result = await repository.getSingleProduct(id);
        // assert
        expect(result, const Right(product as Product));
        verify(mockProductRemoteDatasource.getSingleProduct(id));
      });

      test('should cache the data when the remote data call is successfull', () async {
        // arrange
        when(mockProductRemoteDatasource.getSingleProduct(id)).thenAnswer((_) async => product);
        // act
        await repository.getSingleProduct(id);
        // assert
        verify(mockProductRemoteDatasource.getSingleProduct(id));
        verify(mockProductLocalDatasource.cacheSingleProduct(product));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.getSingleProduct(id)).thenThrow(ServerException());
        // act
        var result = await repository.getSingleProduct(id);
        // assert
        verify(mockProductRemoteDatasource.getSingleProduct(id));
        verifyZeroInteractions(mockProductLocalDatasource);
        expect(result, const Left(ServerFailure('Server Failure')));
      });

    });

    runOffineTests((){

      test('should get local data when the requested data is cached', () async {
        // arrange
        when(mockProductLocalDatasource.getSingleProduct()).thenAnswer((_) async => product);
        // act
        var result = await repository.getSingleProduct(id);
        // assert
        verify(mockProductLocalDatasource.getSingleProduct());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Right(product as Product));
      });

      test('should throw CacheFailure when there is no cached data', () async {
        // arrange
        when(mockProductLocalDatasource.getSingleProduct()).thenThrow(CacheException());
        // act
        var result = await repository.getSingleProduct(id);
        // assert
        verify(mockProductLocalDatasource.getSingleProduct());
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(CacheFailure('Cache Failure')));
      });

    });
  });
  
  group('updateProduct', (){
    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'image1.jpg',
    );  

    runOnlineTests(() {
      test('should return remote data when the remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.updateProduct(product)).thenAnswer((_) async => product);
        // act
        var result = await repository.updateProduct(product);
        // assert
        expect(result, const Right(product as Product));
        verify(mockProductRemoteDatasource.updateProduct(product));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.updateProduct(product)).thenThrow(ServerException());
        // act
        var result = await repository.updateProduct(product);
        // assert
        verify(mockProductRemoteDatasource.updateProduct(product));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.updateProduct(product);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Can\'t connect to the server')));
      });
    });
  });
  
  group('deleteProduct', (){
    const id = '1';

    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'image1.jpg',
    );

    runOnlineTests(() {
      test('should should delete the data when remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.deleteProduct(id)).thenAnswer((_) async => product);
        // act
        var result = await repository.deleteProduct(id);
        // assert
        expect(result, const Right(product as Product));
        verify(mockProductRemoteDatasource.deleteProduct(id));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.deleteProduct(id)).thenThrow(ServerException());
        // act
        var result = await repository.deleteProduct(id);
        // assert
        verify(mockProductRemoteDatasource.deleteProduct(id));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.deleteProduct(id);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Can\'t connect to the server')));
      });
    });
  });
  
  group('addProduct', (){
    const product = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'image1.jpg',
    );

    runOnlineTests(() {
      test('should should return the new data when remote data call is success', () async {
        // arrange
        when(mockProductRemoteDatasource.addProduct(product)).thenAnswer((_) async => product);
        // act
        var result = await repository.addProduct(product);
        // assert
        expect(result, const Right(product as Product));
        verify(mockProductRemoteDatasource.addProduct(product));
      });
      
      test('should throw exception when the remote data call is unsuccessfull', () async {
        // arrange
        when(mockProductRemoteDatasource.addProduct(product)).thenThrow(ServerException());
        // act
        var result = await repository.addProduct(product);
        // assert
        verify(mockProductRemoteDatasource.addProduct(product));
        expect(result, const Left(ServerFailure('Server Failure')));
      });
    });

    runOffineTests((){
      test('should throw failure if no connection', () async {
        // act
        var result = await repository.addProduct(product);
        // assert
        verify(mockNetworkInfo.isConnected);
        verifyZeroInteractions(mockProductRemoteDatasource);
        expect(result, const Left(NoConnection('Can\'t connect to the server')));
      });
    });
  });
}