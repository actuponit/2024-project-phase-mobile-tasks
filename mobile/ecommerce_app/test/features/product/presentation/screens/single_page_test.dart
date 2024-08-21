import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/screens/single_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';


class MockProudctBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

Future<void> pumpWidgets(WidgetTester tester, MockProudctBloc productBloc, String id) async {
  await tester.pumpWidget(BlocProvider<ProductBloc>.value(
    value: productBloc,
    child: MaterialApp(
      home: SinglePage(id: id,),
      ),
    ),
  );
}
void main() {
  late MockProudctBloc productBloc;

  const Product product = Product(
    id: '1',
    name: 'Product 1',
    price: 100,
    imageUrl: 'image1',
    description: 'Description 2',
  );

  setUp(() {
    productBloc = MockProudctBloc();
  });

  testWidgets('should display a product passed the id as an argument', (WidgetTester tester) async {
    // arrange
    when(() => productBloc.state).thenAnswer((_) => LoadedSingleProductState(product));
    await mockNetworkImagesFor(() async => await pumpWidgets(tester, productBloc, product.id));
    await tester.pump();
    expect(find.text(product.name), findsNWidgets(2));
    expect(find.text('\$${product.price}'), findsOneWidget);
    expect(find.text(product.description), findsOneWidget);
  });
}