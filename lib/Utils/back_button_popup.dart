import 'package:flutter/material.dart';

Widget BackButtonPopup(BuildContext context, VoidCallback press) {
  return AlertDialog(
    title: const Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: press,
        child: const Text('Close'),
      ),
    ],
  );
}
