import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  MockProductRepository? mockProductRepository;
  UpdateProductUsecase? updateProductUseCase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProductUseCase = UpdateProductUsecase(mockProductRepository!);
  });

  const updatedProduct = Product(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl: 'image1.jpg',
  );
  test('should update and return the update', () async {
    // arrange
    when(mockProductRepository?.updateProduct(updatedProduct)).thenAnswer((_) async => const Right(updatedProduct));

    // act
    final result = await updateProductUseCase!(const UpdateProductParams(updatedProduct));

    // assert
    expect(result, const Right(updatedProduct));
    verify(mockProductRepository?.updateProduct(updatedProduct));
    verifyNoMoreInteractions(mockProductRepository);
  });
}