part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {}

final class IntialState extends ProductState {
  @override
  List<Object> get props => [];
}

final class LoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

final class SuccessfullyDeletedState extends ProductState {
  @override
  List<Object> get props => [];
}

final class LoadedAllProductsState extends ProductState {
  final List<Product> products;

  LoadedAllProductsState(this.products);
  @override
  List<Object> get props => [];
}

final class ErrorState extends ProductState {
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [];
}

final class LoadedSingleProductState extends ProductState {
  final Product product;

  LoadedSingleProductState(this.product);
  @override
  List<Object> get props => [];
}


