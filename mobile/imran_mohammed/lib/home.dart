import 'package:flutter/material.dart';
import 'package:imran_mohammed/card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
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
                        Navigator.of(context).pushNamed('search-item');
                      },
                      color: const Color.fromRGBO(211, 211, 211, 1),
                      icon: const Icon(Icons.search_outlined,),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            const CustomCard(),
            const SizedBox(height: 20,),
            const CustomCard(),
            const SizedBox(height: 20,),
            const CustomCard(),
            const SizedBox(height: 20,),
            const CustomCard(),
            const SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add-items');
        },
        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 36,),
      ),
    ));
  }
}