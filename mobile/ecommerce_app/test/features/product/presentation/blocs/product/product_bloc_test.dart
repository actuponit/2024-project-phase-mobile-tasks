import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/errors/failure.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockGetProductUsecase getProductUsecase;
  late MockGetSingleProductUsecase getSingleProductUsecase;
  late MockCreateProductUseCase createProductUseCase;
  late MockUpdateProductUsecase updateProductUseCase;
  late MockDeleteProductUsecase deleteProductUseCase;
  late MockInputConverter inputConverter;
  late ProductBloc productBloc;

  setUp(() {
    getProductUsecase = MockGetProductUsecase();
    getSingleProductUsecase = MockGetSingleProductUsecase();
    createProductUseCase = MockCreateProductUseCase();
    inputConverter = MockInputConverter();
    updateProductUseCase = MockUpdateProductUsecase();
    deleteProductUseCase = MockDeleteProductUsecase();
    productBloc = ProductBloc(
      updateProduct: updateProductUseCase,
      deleteProduct: deleteProductUseCase,
      inputConverter: inputConverter,
      getProduct: getSingleProductUsecase,
      getProducts: getProductUsecase,
      addProduct: createProductUseCase,
    );
  });

  const SERVER_FAILURE_MESSAGE = 'Server Failure';
  const products = [
    Product(id: '1', name: 'Product 1', price: 100, imageUrl: 'image.png', description: 'Description 1'),
    Product(id: '2', name: 'Product 2', price: 200, imageUrl: 'image.png', description: 'Description 2'),
  ];
  const product = Product(id: '1', name: 'Product 1', price: 100, imageUrl: 'image.png', description: 'Description 1');
  const id = '1';
  
  
  test('initial state is ProductInitial', () {
    expect(productBloc.state, IntialState());
  });

  group('GetProducts', () {
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, ProductLoaded] when GetProducts is added if no failure',
      build: () {
        when(getProductUsecase(NoParams())).thenAnswer((_) async => const Right(products));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState(products),
      ],
    );
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, ProductError] when GetProducts is added and there is a failure',
      build: () {
        when(getProductUsecase(NoParams())).thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE_MESSAGE)));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        ErrorState(SERVER_FAILURE_MESSAGE),
      ],
    );
  });
  group('GetProduct', () {
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, LoadedSingleProductState] when GetSingleProductEvent is added if no failure',
      build: () {
        when(getSingleProductUsecase(const GetSingleProductParams(id))).thenAnswer((_) async => const Right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(GetSingleProductEvent(id)),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(product),
      ],
      verify: (_) => verify(getSingleProductUsecase(const GetSingleProductParams(id))),
    );
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, ProductError] when GetSingleProductEvent is added and there is a failure',
      build: () {
        when(getSingleProductUsecase(const GetSingleProductParams(id))).thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE_MESSAGE)));
        return productBloc;
      },
      act: (bloc) => bloc.add((GetSingleProductEvent(id))),
      expect: () => [
        LoadingState(),
        ErrorState(SERVER_FAILURE_MESSAGE),
      ],
    );
  });

  group('AddProduct', () {
    final tproduct = Product(name: product.name, price: product.price, imageUrl: product.imageUrl, description: product.description);
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, LoadedSingleProductState] when CreateProductEvent is added with no failure',
      build: () {
        when(inputConverter.stringToUnsignedDouble('100')).thenReturn(const Right(100));
        when(createProductUseCase(CreateProductParams(tproduct))).thenAnswer((_) async => const Right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(name: product.name, price: '100', imageUrl: product.imageUrl, description: product.description)),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(product),
      ],
      verify: (_) => verify(createProductUseCase(CreateProductParams(tproduct))),
    );
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, ErrorState] when CreateProductEvent is added and there is a failure',
      build: () {
        when(inputConverter.stringToUnsignedDouble('100')).thenReturn(const Right(100));
        when(createProductUseCase(CreateProductParams(tproduct))).thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE_MESSAGE)));
        return productBloc;
      },
      act: (bloc) => bloc.add(CreateProductEvent(name: product.name, price: '100', imageUrl: product.imageUrl, description: product.description)),
      expect: () => [
        LoadingState(),
        ErrorState(SERVER_FAILURE_MESSAGE),
      ],
      verify: (_) => verify(createProductUseCase(CreateProductParams(tproduct))),
    );
  });
  group('DeleteProduct', () {
    
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, SuccessfullyDeletedState] when DeleteProductEvent is added with no failure',
      build: () {
        when(deleteProductUseCase(const DeleteProductParams(id))).thenAnswer((_) async => const Right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(id)),
      expect: () => [
        LoadingState(),
        SuccessfullyDeletedState(),
      ],
      verify: (_) => verify(deleteProductUseCase(const DeleteProductParams(id))),
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when DeleteProductEvent is added with and there is a failure',
      build: () {
        when(deleteProductUseCase(const DeleteProductParams(id))).thenAnswer((_) async => const Left(ServerFailure(SERVER_FAILURE_MESSAGE)));
        return productBloc;
      },
      act: (bloc) => bloc.add(DeleteProductEvent(id)),
      expect: () => [
        LoadingState(),
        ErrorState(SERVER_FAILURE_MESSAGE),
      ],
      verify: (_) => verify(deleteProductUseCase(const DeleteProductParams(id))),
    );
    
  });
  
  group('UpdateProduct', () {
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, LoadedSingleProductState] when UpdateProductEvent is added with no failure',
      build: () {
        when(inputConverter.stringToUnsignedDouble('100')).thenReturn(const Right(100));
        when(updateProductUseCase(const UpdateProductParams(product))).thenAnswer((_) async => const Right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(id:id, name: product.name, price: '100', imageUrl: product.imageUrl, description: product.description)),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(product),
      ],
      verify: (_) => verify(updateProductUseCase(const UpdateProductParams(product))),
    );
    
    blocTest<ProductBloc, ProductState>(
      'emits [Loading, LoadedSingleProductState] when CreateProductEvent is added with no failure',
      build: () {
        when(inputConverter.stringToUnsignedDouble('100')).thenReturn(const Right(100));
        when(updateProductUseCase(const UpdateProductParams(product))).thenAnswer((_) async => const Right(product));
        return productBloc;
      },
      act: (bloc) => bloc.add(UpdateProductEvent(id: product.id, name: product.name, price: '100', imageUrl: product.imageUrl, description: product.description)),
      expect: () => [
        LoadingState(),
        LoadedSingleProductState(product),
      ],
      verify: (_) => verify(updateProductUseCase(const UpdateProductParams(product))),
    );
    
  });

}