import 'package:flutter/material.dart';

class CustomRangeSlider extends StatefulWidget {

  const CustomRangeSlider({super.key});

  @override
  RangeSliderState createState() => RangeSliderState();
}

class RangeSliderState extends State<CustomRangeSlider> {
  double _lowerValue = 20;
  double _upperValue = 80;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(data: SliderTheme.of(context).copyWith(
      thumbColor: Colors.white,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      trackHeight: 10,
      ), child: RangeSlider(
        values: RangeValues(_lowerValue, _upperValue),
        min: 0,
        max: 100,
        labels: RangeLabels(
          _lowerValue.toString(),
          _upperValue.toString()
        ),
        activeColor: const Color.fromRGBO(63, 81, 243, 1),
        inactiveColor: const Color.fromRGBO(217, 217, 217, 1),
        onChanged: (values) {
          setState(() {
            _lowerValue = values.start;
            _upperValue = values.end;
          });
        },
      )
    );
  }
}