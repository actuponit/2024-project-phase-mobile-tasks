import '../models/product_model.dart';

abstract class ProductRemoteDatasource {

  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getSingleProduct(String id);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<ProductModel> deleteProduct(String id);
  Future<ProductModel> addProduct(ProductModel product);
}