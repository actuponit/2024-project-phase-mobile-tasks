class Product {
  String name;
  String id;
  String description;
  double price;

  Product({required this.name, required this.id, required this.description, required this.price});

  @override
  String toString() {
    return 'Product $id:\nName: $name, \nDescription: $description, \nPrice: $price';
  }
}