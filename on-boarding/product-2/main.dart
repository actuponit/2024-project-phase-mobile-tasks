import 'dart:ffi';
import 'dart:io';

import 'product-manager.dart';
import 'product.class.dart';

void main(List<String> arguments) {

  ProductManager pm = new ProductManager([]);

  print('Welcome to the product manager!');

  try {

    while (true) {
      print(pm);
      print('Please read the manual and choose the action u want to do:');  
      print('Insert 1 to add product:');  
      print('Insert 2 to remove product:');  
      print('Insert 3 to find a single product:');  
      print('Insert 4 to edit product:');  
      print('Enter any thing else to exit:');  
      
      String? userInput = stdin.readLineSync();
      if (userInput == '1') {
        print('Enter the product name:');
        String? name = stdin.readLineSync();
        print("Enter the product id");
        String? id = stdin.readLineSync();
        print("Enter the product description");
        String? description = stdin.readLineSync();
        print("Enter the product price");
        String? priceInput = stdin.readLineSync();
        double? price = double.tryParse(priceInput!);

        Product p = new Product(name: name!, id: id!, description: description!, price: price!);
        pm.addProduct(p);
        print('Product added Successfully');
      } else if (userInput == '2') {
        print('Enter the id of the product u want to remove');
        String? id = stdin.readLineSync();
        pm.removeProduct(id!);
        print('Product removed Successfully');
      } else if (userInput == '3') {
        print('Enter the id of the product u want to find');
        String? id = stdin.readLineSync();
        var product = pm.getProduct(id!);
        if (product != null) {
          print(product);
        } else {
          print('No product with this id');
        }
      } else if (userInput == '4') {
        print("Enter the product id u want to edit");
        String? id = stdin.readLineSync();
        var product = pm.getProduct(id!);
        if (product != null) {
          print(product);
          print('Enter the new product name, or leave it blank to keep the current name:');
          String? name = stdin.readLineSync();
          print('Enter the new product description, or leave it blank to keep the current description:');
          String? description = stdin.readLineSync();
          print('Enter the new product price, or leave it blank to keep the current price:');
          String? priceInput = stdin.readLineSync();
          double? price; 
          if (priceInput != null && priceInput != '') {
            price = double.tryParse(priceInput);
          }
          print("Here is the updated product");
          print(pm.updateProduct(id, name, description, price));
        } else {
          print('No product with this id');
        }
      }else {
        print('Exiting the program');
        break;
      }
    }
  } catch (e) {
    print('Invalid input for price');
  }
}