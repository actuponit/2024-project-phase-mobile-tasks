import 'package:flutter/material.dart';
import 'package:imran_mohammed/card.dart';
import 'package:imran_mohammed/models/shoe.dart';
import 'package:imran_mohammed/search_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Shoe> all_shoes = [
    const Shoe(
      title: 'Derby Leather Shoes',
      price: 150,
      category: "Men's Shoe",
      description: "A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.",
    ),
    const Shoe(
      title: 'Nike Air Max 270',
      price: 150,
      category: "Running Shoe",
      description: "The Nike Air Max 270 is a lifestyle shoe made by Nike's Sportswear division. The silhouette made its debut in February 2018 and was the first Air Max model designed specifically for casual wear.",
    ),
    const Shoe(
      title: 'Nike Air Max 270',
      price: 150,
      category: "Running Shoe",
      description: "The Nike Air Max 270 is a lifestyle shoe made by Nike's Sportswear division. The silhouette made its debut in February 2018 and was the first Air Max model designed specifically for casual wear.",
    ),
  ];
  bool _searchMode = false;
  final SearchItem _searchItem = const SearchItem();

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: !_searchMode? AppBar(
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
                    onPressed: () {},
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
        ): _searchItem.searchAppBar(context, () {
            setState(() {
              _searchMode = false;
            });
          }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: all_shoes.length+1,
            itemBuilder: (context, index) {
              if(index == 0)  {
                return _searchMode? _searchItem.searchTools(context):
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 10, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Products",
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
                            color: const Color.fromRGBO(211, 211, 211, 1),
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
                          color: const Color.fromRGBO(211, 211, 211, 1),
                          icon: const Icon(Icons.search_outlined),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return CustomCard(shoe: all_shoes[index-1], deleteFunction: (){
                setState(() {
                  all_shoes.removeAt(index-1);
                });
              }, updateFunction: (){
                Navigator.of(context).pushNamed('add-items', arguments: all_shoes[index-1]).then((value) {
                  if(value != null) {
                    setState(() {
                      all_shoes[index-1] = value as Shoe;
                    });
                  }
                });
              },
              );
            }
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var newShoe = await Navigator.of(context).pushNamed('add-items');
            if(newShoe != null) {
              setState(() {
                all_shoes.add(newShoe as Shoe);
              });
            }
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