import 'package:flutter/material.dart';
import 'package:imran_mohammed/custom_button.dart';

class AddItem extends StatelessWidget {

  const AddItem({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
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
          centerTitle: true,
          title: const Text(
            "Add  Product",
            style: TextStyle(
              height: 1.5,
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(62, 62, 62, 1)
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                  ),
                  height: 190,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, size: 48, color: Color.fromRGBO(62, 62, 62, 1),),
                      SizedBox(height: 40,),
                      Text('Upload Images', style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)
                      ),)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Text('Name', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Price', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.attach_money, color: Color.fromRGBO(62, 62, 62, 1),),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Category', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Description', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: const TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
                const CustomButton(filled: true, text: 'ADD', width: double.infinity),
                const SizedBox(height: 10,),
                const CustomButton(text: 'DELETE', width: double.infinity)
              ],
          ), 
          ),
        ),
      ),
    );
  }
}