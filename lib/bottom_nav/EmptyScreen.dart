import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_safe_travel/MyText.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/no_data.png',width: 100,height: 100,fit: BoxFit.fill),
          const SizedBox(height: 10),
           MyText(text: 'Ride Not Found', fontFamily: 'transport', color: Colors.black, fontSize: 14)
        ],
      ),
    );
  }
}
