import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../blocs/product/product_bloc.dart';

class CustomCard extends StatelessWidget {
  final Product product;
  const CustomCard({super.key, required this.product,});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      shadowColor: const Color.fromARGB(126, 215, 208, 208),
      clipBehavior: Clip.antiAlias,
      child:
      InkWell(
        onTap: () async {
          Navigator.of(context).pushNamed('single', arguments: product.id);
          BlocProvider.of<ProductBloc>(context).add(GetSingleProductEvent(product.id));
        },
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(product.imageUrl, height: 160, fit: BoxFit.fill,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: SizedBox( 
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(product.name, 
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            height: 1.5,
                            color: Color.fromRGBO(62, 62, 62, 1)
                          ),
                        ),
                        Text('\$${product.price}', 
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(62, 62, 62, 1),
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.5,
                            color: Color.fromRGBO(170, 170, 170, 1),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(Icons.star, size: 20, color: Color.fromRGBO(255, 215, 0, 1)),
                            Text('(40)',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                color: Color.fromRGBO(170, 170, 170, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            )
          ],
        ), 
      ),
    );
    
  }
}