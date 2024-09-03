part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {}

final class LoadAllProductsEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}

final class GetSingleProductEvent extends ProductEvent {
  final String id;

  GetSingleProductEvent(this.id);
  @override
  List<Object> get props => [id];
}

final class CreateProductEvent extends ProductEvent {
  final String name;
  final String price;
  final String imageUrl;
  final String description;

  CreateProductEvent({required this.name, required this.price, required this.imageUrl, required this.description});
  @override
  List<Object> get props => [name, price, imageUrl, description];
}

final class UpdateProductEvent extends  ProductEvent {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String description;

  UpdateProductEvent({required this.id, required this.name, required this.price, required this.imageUrl, required this.description});
  @override
  List<Object> get props => [id, name, price, imageUrl, description];
}

final class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent(this.id);
  @override
  List<Object> get props => [id];
}


