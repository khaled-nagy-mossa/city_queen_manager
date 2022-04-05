import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatefulWidget {
  const CustomNumberPicker({this.initialValue = 0, this.onChanged, Key key})
      : super(key: key);
  final int initialValue;
  final void Function(int value) onChanged;

  @override
  _CustomNumberPickerState createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: _currentValue,
      minValue: 0,
      maxValue: 1000000,
      itemCount: 5,
      onChanged: (value) {
        setState(() => _currentValue = value);
        widget.onChanged(_currentValue);
      },
    );
  }
}
