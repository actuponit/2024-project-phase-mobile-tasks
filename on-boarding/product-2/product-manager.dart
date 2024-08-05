import 'product.class.dart';

class ProductManager {
  var _products = <Product>[];
  ProductManager(this._products);

  Product addProduct(Product product) {
    _products.add(product);
    return product;
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Product? updateProduct(String id, String? name, String? description, double? price) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index == -1)
      return null;

    if (name != null && name != '')
      _products[index].name = name;
    if (description != null && description != '')
      _products[index].description = description;
    if (price != null && price != '')
      _products[index].price = price;
    return _products[index];
  }

  List<Product> getProducts() {
    return _products;
  }

  @override
  String toString() {
    if (_products.isEmpty) {
      return '\nNo products added yet\n';
    }

    var result = '\nAll Products:\n';
    _products.forEach((product) {
      result += 'Product ${product.id}: Name: ${product.name}, Description: ${product.description}, Price: ${product.price} \n';
    });
    result += '\n';
    return result;
  }
}