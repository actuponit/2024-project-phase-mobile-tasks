import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const CustomButton({super.key, required this.onPressed, required this.text});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
  height: 50,
  child: FilledButton(
    style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: const WidgetStatePropertyAll(Color.fromRGBO(63, 81, 243, 1)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ))
    ),
    onPressed: () {onPressed();},
    child: Text(text, style: const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600, height: 1.5)),
    ),
  );
  }
}
