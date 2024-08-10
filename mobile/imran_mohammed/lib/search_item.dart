import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imran_mohammed/custom_button.dart';
import 'package:imran_mohammed/range_slider.dart';

class SearchItem {
  const SearchItem();

  void showFullScreenModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Category', 
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      height: 1.5,
                      color: Color.fromRGBO(62, 62, 62, 1)
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color.fromRGBO(217, 217, 217, 1)
                      ),
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Price', 
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      height: 1.5,
                      color: Color.fromRGBO(62, 62, 62, 1)
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const CustomRangeSlider(),
                  const SizedBox(height: 25,),
                  CustomButton(text: 'APPLY', width: double.infinity, filled: true, onPressed: (){},),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  AppBar searchAppBar(BuildContext context, Function onPressed) {
    return AppBar(
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
        onPressed: (){
          onPressed();
        },
      ),
      centerTitle: true,
      title: const Text(
        "Search  Product",
        style: TextStyle(
          height: 1.5,
          fontSize: 16,
          fontFamily: 'Poppins',
          color: Color.fromRGBO(62, 62, 62, 1)
        ),
      ),
    );
  }

  Widget searchTools(BuildContext context) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 125,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(217, 217, 217, 1)
                ),
                borderRadius: BorderRadius.circular(6)
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Leather",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(102, 102, 102, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.arrow_forward, color: Color.fromRGBO(63, 81, 243, 1), size: 28,)
                ),
              ),
            ),
            const SizedBox(width: 10,),
            IconButton(
              onPressed: (){
                showFullScreenModal(context);
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll<Color>(Color.fromRGBO(63, 81, 243, 1)),
                shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
                ))
              ),
              iconSize: 28,
              icon: const Icon(Icons.filter_list_outlined, color: Colors.white,),
            ),
          ],
        );
  }
}