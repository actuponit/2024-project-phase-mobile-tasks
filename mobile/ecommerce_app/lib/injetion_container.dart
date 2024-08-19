import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/network/network_info_impl.dart';
import 'core/utils/input_converter.dart';
import 'features/product/data/datasources/product_local_datasource.dart';
import 'features/product/data/datasources/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/get_single_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/blocs/product/product_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // features
  locator.registerFactory(() => ProductBloc(
    getProduct: locator(),
    getProducts: locator(),
    addProduct: locator(),
    updateProduct: locator(),
    deleteProduct: locator(),
    inputConverter: locator(),
  ));

  //  usecases
  locator.registerLazySingleton(() => GetSingleProductUsecase(locator()));
  locator.registerLazySingleton(() => GetProductUsecase(locator()));
  locator.registerLazySingleton(() => CreateProductUseCase(locator()));
  locator.registerLazySingleton(() => UpdateProductUsecase(locator()));
  locator.registerLazySingleton(() => DeleteProductUsecase(locator()));
  
  // repositories
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    localDatasource: locator(),
    remoteDatasource: locator(),
    networkInfo: locator(),
  ));

  // Data sources
  locator.registerLazySingleton<ProductLocalDatasource>(() => ProductLocalDatasourceImpl(locator()));
  locator.registerLazySingleton<ProductRemoteDatasource>(() => ProductRemoteDatasourceImpl(locator()));

  // core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
  locator.registerLazySingleton(() => InputConverter());

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => InternetConnectionChecker());
}