import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/entities.dart';
import 'package:ecommerce_app/features/authentication/presentation/blocs/auth/auth_bloc.dart';
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

class MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

Future<void> pumpWidgets(WidgetTester tester, MockProudctBloc productBloc, MockAuthBloc authBloc) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>.value(value: productBloc),
          BlocProvider<AuthBloc>.value(value: authBloc),
        ],
        child: const MyHomePage(),
      ),
    ),
  );
}
void main() {
  late MockProudctBloc productBloc;
  late MockAuthBloc authBloc;

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
    Product(
      id: '2',
      name: 'Product 2',
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
    authBloc = MockAuthBloc();
  });

  testWidgets('should display all products', (WidgetTester tester) async {
    // arrange
    when(() => productBloc.state).thenAnswer((_) => LoadedAllProductsState(products));
    when(() => authBloc.state).thenAnswer((_) => const LoadedUserState(User(id: '1', name: 'name', email: 'email')));
    await mockNetworkImagesFor(() async => await pumpWidgets(tester, productBloc, authBloc));
    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump();
    expect(find.text('Available Products'), findsOneWidget);
    expect(find.byType(CustomCard), findsNWidgets(products.length));
  });
}