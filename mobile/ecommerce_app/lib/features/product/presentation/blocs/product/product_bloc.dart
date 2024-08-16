import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/input_converter.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/create_product.dart';
import '../../../domain/usecases/delete_product.dart';
import '../../../domain/usecases/get_product.dart';
import '../../../domain/usecases/get_single_product.dart';
import '../../../domain/usecases/update_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final GetSingleProductUsecase getProduct;
  final GetProductUsecase getProducts;
  final CreateProductUseCase addProduct;
  final UpdateProductUsecase updateProduct;
  final DeleteProductUsecase deleteProduct;
  final InputConverter inputConverter;
  
  ProductBloc({
    required this.inputConverter, 
    required this.getProduct, 
    required this.addProduct, 
    required this.getProducts,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(IntialState()) {
    on<LoadAllProductsEvent>((event, emit) async {
      emit(LoadingState());
      final products = await getProducts(NoParams());
      products.fold(
        (l) => emit(ErrorState(l.message)),
        (r) => emit(LoadedAllProductsState(r)),
      );
    });

    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final products = await getProduct(GetSingleProductParams(event.id));
      products.fold(
        (l) => emit(ErrorState(l.message)),
        (r) => emit(LoadedSingleProductState(r)),
      );
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(LoadingState());
      final products = await deleteProduct(DeleteProductParams(event.id));
      products.fold(
        (failure) => emit(ErrorState(failure.message)),
        (_) => emit(SuccessfullyDeletedState()),
      );
    });

    on<CreateProductEvent>((event, emit) async {
      final price = inputConverter.stringToUnsignedDouble(event.price);
      price.fold(
        (l) => emit(ErrorState(l.message)),
        (price) async {
          emit(LoadingState());
          final newProduct = Product(name: event.name, price: price, description: event.description, imageUrl: event.imageUrl);
          final product = await addProduct(CreateProductParams(newProduct));
          product.fold(
            (failure) => emit(ErrorState(failure.message)),
            (product) => emit(LoadedSingleProductState(product)),
          );
        },
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      final price = inputConverter.stringToUnsignedDouble(event.price);
      price.fold(
        (l) => emit(ErrorState(l.message)),
        (price) async {
          emit(LoadingState());
          final newProduct = Product(id:event.id, name: event.name, price: price, description: event.description, imageUrl: event.imageUrl);
          final product = await updateProduct(UpdateProductParams(newProduct));
          product.fold(
            (failure) => emit(ErrorState(failure.message)),
            (product) => emit(LoadedSingleProductState(product)),
          );
        },
      );
    });
  }

  
}
