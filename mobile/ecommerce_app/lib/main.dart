import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/product/presentation/app.dart';
import 'features/product/presentation/bloc_observer.dart';
import 'injetion_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
