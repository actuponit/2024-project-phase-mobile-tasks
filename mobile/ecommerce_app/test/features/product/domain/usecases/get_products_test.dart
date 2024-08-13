import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  MockProductRepository? mockProductRepository;
  GetProductUsecase? getProductUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getProductUseCase = GetProductUsecase(mockProductRepository!);
  });

  test('should get products from the repository', () async {
    // arrange
    const products = [
      Product(
        id: '1',
        name: 'Product 1',
        description: 'Description 1',
        price: 100.0,
        imageUrl: 'image1.jpg',
      ),
      Product(
        id: '2',
        name: 'Product 2',
        description: 'Description 2',
        price: 200.0,
        imageUrl: 'image2.jpg',
      ),
    ];
    when(mockProductRepository?.getProducts()).thenAnswer((_) async => const Right(products));

    // act
    final result = await getProductUseCase!(NoParams());

    // assert
    expect(result, const Right(products));
    verify(mockProductRepository?.getProducts());
    verifyNoMoreInteractions(mockProductRepository);
  });
}