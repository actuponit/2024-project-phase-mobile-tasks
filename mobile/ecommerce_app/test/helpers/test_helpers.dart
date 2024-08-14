import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_local_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [ProductRepository, NetworkInfo, ProductLocalDatasource, ProductRemoteDatasource, InternetConnectionChecker],
  customMocks: [MockSpec<Client>(as: #MockClient)]
)

void main() {

}