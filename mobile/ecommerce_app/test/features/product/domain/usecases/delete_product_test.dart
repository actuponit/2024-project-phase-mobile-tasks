import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  MockProductRepository? mockProductRepository;
  DeleteProductUsecase? usecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = DeleteProductUsecase(mockProductRepository!);
  });


  const productId = '1';
  const deletedProduct = Product(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl: 'image1.jpg',
  );
  test('should delte the product with the given id', () async {
    // arrange
    when(mockProductRepository?.deleteProduct(productId)).thenAnswer((_) async => const Right(deletedProduct));

    // act
    final result = await usecase!(const DeleteProducntParams(productId));

    // assert
    expect(result, const Right(deletedProduct));
    verify(mockProductRepository?.deleteProduct(productId));
    verifyNoMoreInteractions(mockProductRepository);
  });
}