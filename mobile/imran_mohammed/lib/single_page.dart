import 'package:flutter/material.dart';
import 'package:imran_mohammed/custom_button.dart';
import 'package:imran_mohammed/models/shoe.dart';
import 'package:imran_mohammed/sizes.dart';

class SinglePage extends StatelessWidget {
  final Shoe shoe;
  const SinglePage({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(shoe.category,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color.fromRGBO(170, 170, 170, 1),
                      ),
                    ),
                    const Row(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(shoe.title, 
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)
                      ),
                    ),
                    Text("\$${shoe.price}", 
                      style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  shoe.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(102, 102, 102, 1)
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(text: 'DELETE', width: 150, onPressed: (){
                      print("delete");
                      Navigator.of(context).pop('delete');
                    },),
                    CustomButton(filled: true, width: 150, text: 'UPDATE', onPressed: () {
                      Navigator.of(context).pop('update');
                    },)
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );   
  }
}