import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/screens/home.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockProudctBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

Future<void> pumpWidgets(WidgetTester tester, MockProudctBloc productBloc) async {
  await tester.pumpWidget(BlocProvider<ProductBloc>.value(
    value: productBloc,
    child: MaterialApp(
      home: const MyHomePage(),
      routes: {
        'single_product': (context) => const Scaffold(body: Text('Single Page'),)
      },
      ),
    ),
  );
}
void main() {
  late MockProudctBloc productBloc;

  const products = [
    Product(
      id: '1',
      name: 'Product 1',
      price: 100,
      imageUrl: 'image1',
      description: 'Description 2',
    ),
    Product(
      id: '2',
      name: 'Product 2',
      price: 100,
      imageUrl: 'image1', 
      description: 'Description 2',
    ),
  ];

  setUp(() {
    productBloc = MockProudctBloc();
  });

  testWidgets('should display all products', (WidgetTester tester) async {
    // arrange
    when(() => productBloc.state).thenAnswer((_) => LoadedAllProductsState(products));
    await mockNetworkImagesFor(() async => await pumpWidgets(tester, productBloc));
    await tester.pump();
    expect(find.text('Available Products'), findsOneWidget);
    expect(find.byType(CustomCard), findsNWidgets(products.length));
  });
}