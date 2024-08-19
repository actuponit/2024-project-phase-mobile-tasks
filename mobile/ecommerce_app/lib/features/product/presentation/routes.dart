import 'package:flutter/material.dart';

import '../domain/entities/product.dart';
import 'screens/add_item.dart';
import 'screens/home.dart';
import 'screens/single_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'add-items':
      final Product? product = settings.arguments as Product?;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddItem(product: product),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
      );
    case 'single':
      final String id = settings.arguments as String;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SinglePage(id: id,),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.ease;

          var tween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
          var scaleAnimation = animation.drive(tween);

          return ScaleTransition(
            scale: scaleAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
      );
    default:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    }
}