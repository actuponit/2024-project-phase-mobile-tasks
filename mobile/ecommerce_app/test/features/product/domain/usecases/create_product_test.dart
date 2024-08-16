import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockProductRepository productRepository;
  late CreateProductUseCase createProductUseCase;

  setUp(() {
    productRepository = MockProductRepository();
    createProductUseCase = CreateProductUseCase(productRepository);
  });

  const tProduct = Product(
    id: '1',
    name: 'Product 1',
    description: 'Product 1 description',
    price: 100,
    imageUrl: 'https://via.placeholder.com/150',
  );

  test('should add product to the repository', () async {
    // arrange
    when(productRepository.addProduct(tProduct)).thenAnswer((_) async => const Right(tProduct));
    // act
    final result = await createProductUseCase(const CreateProductParams(tProduct));
    // assert
    expect(result, const Right(tProduct));
    verify(productRepository.addProduct(tProduct));
    verifyNoMoreInteractions(productRepository);
  });
}