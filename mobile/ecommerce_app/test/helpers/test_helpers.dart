import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/core/utils/input_converter.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/get_single_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository, 
    NetworkInfo, 
    ProductLocalDatasource, 
    ProductRemoteDatasource, 
    InternetConnectionChecker, 
    SharedPreferences,
    GetProductUsecase,
    GetSingleProductUsecase,
    CreateProductUseCase,
    UpdateProductUsecase,
    DeleteProductUsecase,
    InputConverter,
  ],
  customMocks: [MockSpec<Client>(as: #MockClient)]
)

void main() {

}