import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imran_mohammed/custom_button.dart';
import 'package:imran_mohammed/sizes.dart';

class SinglePage extends StatelessWidget {

  const SinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                width: double.infinity,
                height: 286,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/image.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  top: 25,
                  left: 24,
                  child: IconButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        CircleBorder(),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    icon: const Icon(Icons.arrow_back_ios, color: Color.fromRGBO(63, 81, 243, 1),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Men's shoe",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Color.fromRGBO(170, 170, 170, 1),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color.fromRGBO(255, 215, 0, 1)),
                      Text(" (40)",
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Derby Leather Shoes", 
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      height: 1.5,
                      color: Color.fromRGBO(62, 62, 62, 1)
                    ),
                  ),
                  Text("\$120", 
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(62, 62, 62, 1),
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Size:', style: 
                TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(62, 62, 62, 1),
                ),
              ),
            ),
            const SizedBox(height: 5,),
            const Sizes(),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color.fromRGBO(102, 102, 102, 1)
                ),
              ),
            ),
            const SizedBox(height: 30,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(text: 'DELETE', width: 150),
                  CustomButton(filled: true, width: 150, text: 'UPDATE',)
                ],
              ),
            )
          ],
        ),
      )
    );   
  }
}