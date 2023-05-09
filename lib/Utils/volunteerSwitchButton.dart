import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class volunteerSwitchButton extends StatelessWidget {
  final bool status4;

  final ValueChanged valueChanged;

  const volunteerSwitchButton(
      {Key? key, required this.status4, required this.valueChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: FlutterSwitch(
        width: 50.0,
        height: 25.0,
        valueFontSize: 12.0,
        toggleSize: 20.0,
        value: status4,
        activeColor: Colors.black,
        inactiveColor: Colors.black38,
        onToggle: valueChanged,
      ),
    );
    }
}
