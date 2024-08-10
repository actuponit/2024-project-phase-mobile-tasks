import 'package:flutter/material.dart';
import 'package:imran_mohammed/add_item.dart';
import 'package:imran_mohammed/home.dart';
import 'package:imran_mohammed/models/shoe.dart';
import 'package:imran_mohammed/single_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'add-items':
      final Shoe? shoe = settings.arguments as Shoe?;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AddItem(shoe: shoe),
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
      final Shoe shoe = settings.arguments as Shoe;
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SinglePage(shoe: shoe),
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