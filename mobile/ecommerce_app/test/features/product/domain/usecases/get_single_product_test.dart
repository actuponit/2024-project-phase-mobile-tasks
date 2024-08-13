import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helpers.mocks.dart';

void main() {
  MockProductRepository? mockProductRepository;
  GetSingleProductUsecase? getSingleProduct;

  setUp(() {
    mockProductRepository = MockProductRepository();
    getSingleProduct = GetSingleProductUsecase(mockProductRepository!);
  });
  const product = Product(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl: 'image1.jpg',
  );
  test('should get single product from the repository', () async {
    // arrange
    when(mockProductRepository?.getSingleProduct('1')).thenAnswer((_) async => const Right(product));

    // act
    final result = await getSingleProduct!(const GetSingleProductParams('1'));

    // assert
    expect(result, const Right(product));
    verify(mockProductRepository?.getSingleProduct('1'));
    verifyNoMoreInteractions(mockProductRepository);
  });
}