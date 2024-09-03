import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockProudctBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProudctBloc productBloc;

  const product = Product(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1724043492/images/fepsnitchdeb1j7yhyoo.jpg',
  );

  setUp(() {
    productBloc = MockProudctBloc();
  });

  testWidgets('should display a card with product details',
      (WidgetTester tester) async {
    // arrange
    await mockNetworkImagesFor(() async => await tester.pumpWidget(BlocProvider<ProductBloc>.value(
      value: productBloc,
      child: MaterialApp(
        home: const Scaffold(body: CustomCard(product: product)),
        routes: {
          'single': (context) => const Scaffold(
              body: Text('detail page'),
            ),
        },
      ),
    )));

    final nameFinder = find.text(product.name);
    final priceFinder = find.text('\$${product.price}');

    expect(nameFinder, findsExactly(2));
    expect(priceFinder, findsOneWidget);
  });
  
  testWidgets('should navigate to detail page when card is tapped',
      (WidgetTester tester) async {
    // arrange
    await mockNetworkImagesFor(() async => await tester.pumpWidget(BlocProvider<ProductBloc>.value(
      value: productBloc,
      child: MaterialApp(
        home: const Scaffold(body: CustomCard(product: product)),
        routes: {
          'single': (context) => const Scaffold(
              body: Text('detail page'),
            ),
        },
      ),
    )));

    when(() => productBloc.state).thenAnswer((_) => LoadedSingleProductState(product));

    final nameFinder = find.text(product.name);
    final priceFinder = find.text('\$${product.price}');

    expect(nameFinder, findsExactly(2));
    expect(priceFinder, findsOneWidget);

    await tester.tap(find.byType(CustomCard));
    await tester.pumpAndSettle();

    BuildContext context = tester.element(find.text('detail page'));
    expect(find.text('detail page'), findsOneWidget);
    expect(ModalRoute.of(context)?.settings.arguments as String, '1');
  });
}
