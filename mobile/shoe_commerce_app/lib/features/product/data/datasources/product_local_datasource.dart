import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getSingleProduct();
  Future<void> cacheSingleProduct(ProductModel product);
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  final SharedPreferences sharedPreferences;
  ProductLocalDatasourceImpl(this.sharedPreferences);
  static String porductsKey = 'CACHED_PRODUCTS';
  static String singleProductKey = 'CACHED_PRODUCT';
  
  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    var jsonResults = products.map((e) => json.encode(e.toJson())).toList();
    sharedPreferences.setStringList(ProductLocalDatasourceImpl.porductsKey, jsonResults);
  }
  
  @override
  Future<List<ProductModel>> getProducts() {
    var jsonResults = sharedPreferences.getStringList(porductsKey);
    if (jsonResults == null) {
      throw CacheException();
    }
    return Future.value(jsonResults.map((e) => ProductModel.fromJson(json.decode(e))).toList());
  }
  
  @override
  Future<ProductModel> getSingleProduct() {
    var jsonResult = sharedPreferences.getString(singleProductKey);
    if (jsonResult == null) {
      throw CacheException();
    }
   return Future.value(ProductModel.fromJson(json.decode(jsonResult))); 
  }
  
  @override
  Future<void> cacheSingleProduct(ProductModel product) async {
    sharedPreferences.setString(singleProductKey, json.encode(product.toJson()));
  }
}