import 'dart:convert';

import 'package:ecommerce_app/core/constants/constant.dart';
import 'package:ecommerce_app/core/errors/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockClient client;
  late ProductRemoteDatasourceImpl remoteDatasourceImpl;

  setUp(() {
    client = MockClient();
    remoteDatasourceImpl = ProductRemoteDatasourceImpl(client);
  });

  var product = ProductModel.fromJson(json.decode(fixtureReader(('single_product.json')))['data']);
  var productList = json.decode(fixtureReader('products.json'))['data'].map<ProductModel>((e) => ProductModel.fromJson(e)).toList();

  const id = '1';
  group('getProducts', (){

    test('should return a list of ProductModel when the response code is 200', () async {
      // arrange
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(fixtureReader('products.json'), 200));
      // act
      final result = await remoteDatasourceImpl.getProducts();
      // assert
      expect(result, productList);
      verify(client.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      }));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remoteDatasourceImpl.getProducts;
      // assert
      expect(() => call(), throwsA(isA<ServerException>()));
      verify(client.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      }));
    });
  });
  group('getSingleProduct', (){

    test('should return a ProductModel when the response code is 200', () async {
      // arrange
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(fixtureReader('single_product.json'), 200));
      // act
      final result = await remoteDatasourceImpl.getSingleProduct(product.id);
      // assert
      expect(result, isA<ProductModel>());
      expect(result, product);
      verify(client.get(Uri.parse('$baseUrl/${product.id}'), headers: {
      'Content-Type': 'application/json',
      }));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remoteDatasourceImpl.getSingleProduct;
      // assert
      expect(() => call(id), throwsA(isA<ServerException>()));
    });
  });
  group('deleteProduct', (){

    test('should call a the delete end point when the response code is 200', () async {
      // arrange
      when(client.delete(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('', 200));
      // act
      await remoteDatasourceImpl.deleteProduct(id);
      // assert
      verify(client.delete(Uri.parse('$baseUrl/$id'), headers: {
        'Content-Type': 'application/json',
      }));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(client.delete(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remoteDatasourceImpl.deleteProduct;
      // assert
      expect(() => call(id), throwsA(isA<ServerException>()));
      verify(client.delete(Uri.parse('$baseUrl/$id'), headers: {
        'Content-Type': 'application/json',
      }));
    });
  });

  // Not working for real images so I need to change that.
  // group('addProduct', (){

    // test('should return a ProductModel when the response code is 200', () async {
    //   // arrange
    //   when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(fixtureReader('single_product.json'), 200));
    //   // act
    //   final result = await remoteDatasourceImpl.addProduct(product);
    //   // assert
    //   expect(result, isA<ProductModel>());
    //   expect(result, product);
    //   verify(client.post(Uri.parse(baseUrl), headers: {
    //     'Content-Type': 'multipart/form-data',
    //   }, body: {
    //     'image': product.imageUrl,
    //     'name': product.name,
    //     'price': product.price.toString(),
    //     'description': product.description,
    //   }));
    // });

  //   test('should throw a ServerException when the response code is not 200', () async {
  //     // arrange
  //     when(client.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('Not Found', 404));
  //     // act
  //     final call = remoteDatasourceImpl.addProduct;
  //     // assert
  //     expect(() => call(product), throwsA(isA<ServerException>()));
  //     verify(client.post(Uri.parse(baseUrl), headers: {
  //       'Content-Type': 'multipart/form-data',
  //     }, body: {
  //       'image': product.imageUrl,
  //       'name': product.name,
  //       'price': product.price.toString(),
  //       'description': product.description,
  //     }));
  //   });
  // });

  group('updateProduct', (){
    var updatedProduct = ProductModel.fromJson(json.decode(fixtureReader('update.json'))['data']);
    test('should return an updated ProductModel when the response code is 200', () async {
      // arrange
      when(client.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(fixtureReader('update.json'), 200));
      // act
      final result = await remoteDatasourceImpl.updateProduct(product);
      // assert
      expect(result, isA<ProductModel>());
      expect(result, updatedProduct);
      verify(client.put(Uri.parse('$baseUrl/${product.id}'), headers: {
        'Content-Type': 'application/json',
        }, body: json.encode(product.toJson())));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = remoteDatasourceImpl.getSingleProduct;
      // assert
      expect(() => call(id), throwsA(isA<ServerException>()));
    });
  });
}