import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


import '../../../../core/constants/constant.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/http/custom_http.dart';
import '../models/product_model.dart';
abstract class ProductRemoteDatasource {

  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getSingleProduct(String id);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<ProductModel> deleteProduct(String id);
  Future<ProductModel> addProduct(ProductModel product);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final CustomHttp client;

  ProductRemoteDatasourceImpl(this.client);
  @override
  Future<ProductModel> deleteProduct(String id) async {
    var response = await client.delete(Uri.parse('$baseUrl/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200){
      return ProductModel(id: id, name: '', price: 0, description: '', imageUrl: '');
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<List<ProductModel>> getProducts() async {
    var jsonResult = await client.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
    });
    if (jsonResult.statusCode == 200) {
      var products = json.decode(jsonResult.body)['data'];
      var productsList = products.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
      return productsList;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<ProductModel> getSingleProduct(String id) async {
    var jsonResult = await client.get(Uri.parse('$baseUrl/$id'), headers: {
      'Content-Type': 'application/json',
    });

    if (jsonResult.statusCode == 200){
      var product = json.decode(jsonResult.body)['data'];
      return ProductModel.fromJson(product);
    } else {
      throw ServerException();
    }
  }
 
  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    var jsonResult = await client.put(Uri.parse('$baseUrl/${product.id}'), headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode(product.toJson()));
    if (jsonResult.statusCode == 200){
      var product = json.decode(jsonResult.body)['data'];
      return ProductModel.fromJson(product);
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    request.fields['name'] = product.name;
    request.fields['price'] = product.price.toString();
    request.fields['description'] = product.description;
    
    var pic = await http.MultipartFile.fromPath('image', product.imageUrl, contentType: MediaType('image', 'jpg'));
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 201){
      var jsonResult = await http.Response.fromStream(response);
      var product = json.decode(jsonResult.body)['data'];
      return ProductModel.fromJson(product);
    } else {
      throw 
      ServerException();
    }
  }
  }