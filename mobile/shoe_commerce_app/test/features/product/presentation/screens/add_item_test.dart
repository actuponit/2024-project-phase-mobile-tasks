import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/presentation/blocs/product/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/screens/add_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockProudctBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockImagePicker mockImagePicker;
  late MockProudctBloc productBloc;

  setUp(() {
    mockImagePicker = MockImagePicker();
    productBloc = MockProudctBloc();
  });

  const Product product = Product(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl:
        'https://res.cloudinary.com/g5-mobile-track/image/upload/v1724043492/images/fepsnitchdeb1j7yhyoo.jpg',
  );

  Future<void> pumpWidgets(WidgetTester tester) async {
    await tester.pumpWidget(BlocProvider<ProductBloc>.value(
      value: productBloc,
      child: MaterialApp(
        home: AddItem(
            imagePicker: mockImagePicker,
          ),
        routes: {
          'single_product': (context) => const Scaffold(body: Text('Single Page'),)
        },
        ),
      ),
    );
  }
  testWidgets('should be able to pick image from gallery',
      (WidgetTester tester) async {
    // arrange
    when(() => productBloc.state).thenAnswer((_) => IntialState());
    
    when(() => mockImagePicker.pickImage(source: ImageSource.gallery))
        .thenAnswer((_) async => XFile('path'));
    
    await pumpWidgets(tester);
    // act
    await tester.tap(find.byKey(const Key('image')));

    await tester.pumpAndSettle();
    // assert
    verify(() => mockImagePicker.pickImage(source: ImageSource.gallery))
        .called(1);
    expect(find.image(FileImage(File('path'))), findsOneWidget);
  });

  testWidgets(
      'should show success snackbar when all fields are field correctly filled',
      (WidgetTester tester) async {
    // arrange
    whenListen<ProductState>(productBloc, Stream<ProductState>.fromIterable([
      IntialState(),
      LoadedSingleProductState(product),
    ]), initialState: IntialState());
    await pumpWidgets(tester);
    await tester.pumpAndSettle();
    // assert
    expect(find.text('Product added successfully'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets(
      'should show error snackbar when some fields are not field correctly',
      (WidgetTester tester) async {
    // arrange
    whenListen<ProductState>(productBloc, Stream<ProductState>.fromIterable([
      IntialState(),
      ErrorState('An Error occured'),
    ]), initialState: IntialState());
    await pumpWidgets(tester);
    await tester.pumpAndSettle();
    // assert
    expect(find.text('An Error occured'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
