import '../models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getSingleProduct(String id);
  Future<void> cacheProducts(List<ProductModel> products);
}