import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool filled;
  final double width;
  final String text;
  const CustomButton({super.key, this.filled=false, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    if(filled) {
      return SizedBox(
        height: 50,
        width: width,
        child: FilledButton(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            backgroundColor: const WidgetStatePropertyAll(Color.fromRGBO(63, 81, 243, 1)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ))
          ),
          onPressed: (){}, 
          child: Text(text),
        ),
      );
    }
    return SizedBox(
      height: 50,
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateColor.transparent,
          side: const WidgetStatePropertyAll(BorderSide(color: Colors.red)),
          foregroundColor: const WidgetStatePropertyAll(Colors.red),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))
        ),
        onPressed: (){}, 
        child: Text(text),
      ),
    );
  }
}