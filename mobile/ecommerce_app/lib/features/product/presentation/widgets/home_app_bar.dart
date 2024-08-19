import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product/product_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  AppBar build(BuildContext context) {
  return AppBar(
    title: Row(
    children: [
    Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(204, 204, 204, 1),
      borderRadius: BorderRadius.circular(10),
    ),
    ),
    const SizedBox(width: 8),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'July 14, 2023',
        style: TextStyle(
          fontSize: 12,
          color: Color.fromRGBO(170, 170, 170, 1),
        ),
      ),
      RichText(
        text: const TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Hello,',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(102, 102, 102, 1),
              ),
            ),
            TextSpan(
              text: ' John Doe',
              style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromRGBO(211, 211, 211, 1),
                ),
              ),
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<ProductBloc>(context).add(LoadAllProductsEvent());
                },
                icon: const Icon(Icons.notifications_none_outlined),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
      ],
  );
  }
}
