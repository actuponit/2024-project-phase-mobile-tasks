import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/blocs/auth/auth_bloc.dart';
import '../blocs/product/product_bloc.dart';
import 'snack_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            Navigator.of(context).pushReplacementNamed('login');
            showSnackBar(context, Colors.blueAccent, 'Susscessfully logged out');
          }
        },
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(204, 204, 204, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: PopupMenuButton(
                iconColor: Colors.transparent,
                offset: const Offset(0, 50),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Profile'),
                    ),
                    PopupMenuItem(
                      child: const Text('Logout'),
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
                      },
                    ),
                  ];
                },
              ),
            ),
            const SizedBox(width: 6),
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is LoadedUserState) {
                      return RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Hello,',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(102, 102, 102, 1),
                              ),
                            ),
                            TextSpan(
                              text: ' ${state.user.name}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: Card(
                          color: Color.fromRGBO(102, 102, 102, 1),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
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
                  BlocProvider.of<ProductBloc>(context)
                      .add(LoadAllProductsEvent());
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
