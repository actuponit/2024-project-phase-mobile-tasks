import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product/product_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/sizes.dart';
import '../widgets/snack_bar.dart';

class SinglePage extends StatelessWidget {
  final String id;
  const SinglePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is SuccessfullyDeletedState) {
          showSnackBar(context, Colors.green, 'Successfully deleted');
          BlocProvider.of<ProductBloc>(context).add(LoadAllProductsEvent());
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is ErrorState) {
          showSnackBar(context, Colors.red, state.message);
          // Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is LoadedSingleProductState) {
          final product = state.product;
          return SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 286,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 24,
                      child: IconButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(Colors.white),
                          shape: WidgetStatePropertyAll<OutlinedBorder>(
                            CircleBorder(),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromRGBO(63, 81, 243, 1),
                        ),
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context).add(LoadAllProductsEvent());
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Color.fromRGBO(170, 170, 170, 1),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Color.fromRGBO(255, 215, 0, 1)),
                          Text(
                            ' (40)',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Color.fromRGBO(170, 170, 170, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            height: 1.5,
                            color: Color.fromRGBO(62, 62, 62, 1)),
                      ),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(62, 62, 62, 1),
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Size:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontFamily: 'Poppins',
                      color: Color.fromRGBO(62, 62, 62, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Sizes(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    product.description,
                    style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(102, 102, 102, 1)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: 'DELETE',
                        width: 150,
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context)
                              .add(DeleteProductEvent(product.id));
                        },
                      ),
                      CustomButton(
                        filled: true,
                        width: 150,
                        text: 'UPDATE',
                        onPressed: () {
                          Navigator.of(context).pushNamed('add-items', arguments: product);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        );
      }
      if (state is ErrorState) {
        return Scaffold(
          body: Center(
            child: Text(state.message, style: const TextStyle(fontSize: 30)),
          ),
        );
      }
      if (state is LoadingState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
