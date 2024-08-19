import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product/product_bloc.dart';
import '../widgets/card.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/search_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool _searchMode = false;
  final SearchItem _searchItem = const SearchItem();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadAllProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(LoadAllProductsEvent());
    return SafeArea(
      child: Scaffold(
        appBar: !_searchMode
            ? const HomeAppBar().build(context)
            : _searchItem.searchAppBar(context, () {
                setState(() {
                  _searchMode = false;
                });
              }),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is LoadedAllProductsState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    itemCount: state.products.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _searchMode
                            ? _searchItem.searchTools(context)
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 10, right: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Available Products',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              211, 211, 211, 1),
                                        ),
                                      ),
                                      width: 40,
                                      height: 40,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          setState(() {
                                            _searchMode = true;
                                          });
                                        },
                                        color: const Color.fromRGBO(
                                            211, 211, 211, 1),
                                        icon: const Icon(Icons.search_outlined),
                                        iconSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }
                      return CustomCard(
                        product: state.products[index - 1],
                        deleteFunction: () {},
                        updateFunction: () {},
                      );
                          }),
                      );
                    } else if (state is ErrorState) {
              return Center(
                child: Text(state.message, style: const TextStyle(fontSize: 30)),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).pushNamed('add-items');
          },
          backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 36,
          ),
        ),
      ),
    );
  }
}
