
import 'dart:convert';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const ProductModel tProductModel = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl: 'image1.jpg',
  );

  test('should be a subclass of Product entity', () {
    // assert
    expect(tProductModel, isA<Product>());
  });

  test('should convert json to a model object', () {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(fixtureReader('product.json'));

    // act
    final result = ProductModel.fromJson(jsonMap);

    // assert
    expect(result, tProductModel);
  });

  test('should convert product model object to a json without the image field', () {
    // arrange
    final Map<String, dynamic> expectedMap = json.decode(fixtureReader('product.json'));

    // act
    final result = tProductModel.toJson();
    expectedMap.remove('imageUrl');
    // assert
    expect(result, expectedMap);
  });
  
}