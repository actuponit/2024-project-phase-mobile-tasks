import 'dart:convert';

import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockSharedPreferences sharedPreferencesMock;
  late ProductLocalDatasourceImpl localDatasourceImpl;

  setUp(() {
    sharedPreferencesMock = MockSharedPreferences();
    localDatasourceImpl = ProductLocalDatasourceImpl(sharedPreferencesMock);
  });

  const product = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100,
    imageUrl: 'image1.jpg',
  );

  const localProduct = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100, 
    imageUrl: '',
  );

  const productList = [
    ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100,
      imageUrl: 'image1.jpg',
    ),
    ProductModel(
      id: '2',
      name: 'Product 2',
      description: 'Description 2',
      price: 200,
      imageUrl: 'image1.jpg',
    ),
    ProductModel(
      id: '3',
      name: 'Product 3',
      description: 'Description 3',
      price: 300,
      imageUrl: 'image1.jpg',
    ),
  ];

  const mockJson = [
    '{"id":"1","name":"Product 1","description":"Description 1","price":100,"imageUrl":"image1.jpg"}',
    '{"id":"2","name":"Product 2","description":"Description 2","price":200,"imageUrl":"image1.jpg"}',
    '{"id":"3","name":"Product 3","description":"Description 3","price":300,"imageUrl":"image1.jpg"}',
  ];
  group('getProducts', (){
    test('should return a list of ProductModel when there is a cached data', () async {
      // arrange
      when(sharedPreferencesMock.getStringList(ProductLocalDatasourceImpl.porductsKey)).thenReturn(mockJson);
      // act
      final result = await localDatasourceImpl.getProducts();
      // assert
      expect(result, productList);
      verify(sharedPreferencesMock.getStringList(ProductLocalDatasourceImpl.porductsKey));
    });

    test('should throw a CacheException when there is no cached data', () async {
      // arrange
      when(sharedPreferencesMock.getStringList(ProductLocalDatasourceImpl.porductsKey)).thenReturn(null);
      // act
      final call = localDatasourceImpl.getProducts;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
  group('cacheProducts', (){
    test('should call sharedReferences.setStringList with the proper parameter', () async {
      // arrange
      var expectedJson = productList.map((e) => json.encode(e.toJson())).toList();
      when(sharedPreferencesMock.setStringList(ProductLocalDatasourceImpl.porductsKey, expectedJson)).thenAnswer((_) async => true);
      // act
      await localDatasourceImpl.cacheProducts(productList);
      // assert
      verify(sharedPreferencesMock.setStringList(ProductLocalDatasourceImpl.porductsKey, expectedJson));
    });
  });
  
  group('getSingleProduct', (){
    test('should return the last cached product and image is not cached', () async {
      // arrange
      when(sharedPreferencesMock.getString(ProductLocalDatasourceImpl.singleProductKey)).thenReturn(json.encode(product.toJson()));
      // act
      var result = await localDatasourceImpl.getSingleProduct();
      // assert
      verify(sharedPreferencesMock.getString(ProductLocalDatasourceImpl.singleProductKey));
      expect(result, localProduct);
    });
    test('should thorw error if no product cached', () async {
      // arrange
      when(sharedPreferencesMock.getString(ProductLocalDatasourceImpl.singleProductKey)).thenReturn(null);
      // act
      var call = localDatasourceImpl.getSingleProduct;
      // assert
      expect(()=>call(), throwsA(isA<CacheException>()));
      verify(sharedPreferencesMock.getString(ProductLocalDatasourceImpl.singleProductKey));
    });
  });

  group('cacheSingleProducts', (){
    test('should call sharedReferences.setString with the proper parameter', () async {
      // arrange
      var expectedJson = json.encode(product.toJson());
      when(sharedPreferencesMock.setString(ProductLocalDatasourceImpl.singleProductKey, expectedJson)).thenAnswer((_) async => true);
      // act
      await localDatasourceImpl.cacheSingleProduct(product);
      // assert
      verify(sharedPreferencesMock.setString(ProductLocalDatasourceImpl.singleProductKey, expectedJson));
    });
  });
}