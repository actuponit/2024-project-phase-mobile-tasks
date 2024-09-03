import 'package:flutter/material.dart';

class Sizes extends StatefulWidget {

  const Sizes({super.key});

  @override
  SizeState createState() => SizeState();
}

class SizeState extends State<Sizes> {
  int _selectedidx = 0; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, idx) =>
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child:
              InkWell(
                onTap: () {
                  setState(() {
                    _selectedidx = idx;
                  });
                },
                child: Container(
                  width: 60,
                  color: idx == _selectedidx? const Color.fromRGBO(63, 81, 243, 1): Colors.white,
                  child: Center(
                    child: Text('${37+idx}', style: 
                    TextStyle(height: 1.5, fontSize: 20, 
                      color: idx == _selectedidx ? Colors.white : Colors.black
                    ),
                  ), 
                ),),
              ),
          ),
        ),
      );
  }
}