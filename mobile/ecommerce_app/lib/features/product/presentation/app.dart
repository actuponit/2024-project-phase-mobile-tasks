import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injetion_container.dart';
import 'blocs/product/product_bloc.dart';
import 'routes.dart';
import 'screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => locator(),
      child:  MaterialApp(
        title: 'Flutter interface',
        onGenerateRoute: generateRoute,
        home: const MyHomePage(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          fontFamily: 'Poppins',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}