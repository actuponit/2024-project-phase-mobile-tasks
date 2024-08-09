import 'package:flutter/material.dart';
import 'package:imran_mohammed/add_item.dart';
import 'package:imran_mohammed/search_item.dart';
import 'package:imran_mohammed/single_page.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter interface',
      routes: {
        'single': (context) => const SinglePage(),
        'add-items': (context) => const AddItem(),
        'search-item': (context) => const SearchItem(),
      },
      home: const MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}