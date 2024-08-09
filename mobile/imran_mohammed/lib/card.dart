import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: const Color.fromARGB(126, 215, 208, 208),
              clipBehavior: Clip.antiAlias,
              child:
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('single');
                },
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset('images/image.png', height: 160, fit: BoxFit.fill,),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: SizedBox( 
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Derby Leather Shoes", 
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    height: 1.5,
                                    color: Color.fromRGBO(62, 62, 62, 1)
                                  ),
                                ),
                                Text("\$120", 
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(62, 62, 62, 1),
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Men's shoe",
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Color.fromRGBO(170, 170, 170, 1),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star, size: 20, color: Color.fromRGBO(255, 215, 0, 1)),
                                    Text("(40)",
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
                                        color: Color.fromRGBO(170, 170, 170, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    )
                  ],
                ), 
            ),
    );
    
  }
}