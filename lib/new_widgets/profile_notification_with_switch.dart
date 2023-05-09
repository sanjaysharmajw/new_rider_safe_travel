

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_switch/flutter_switch.dart';


import '../MyText.dart';
import '../color_constant.dart';

class ProfileNotification extends StatelessWidget {
  final bool status4;
  final String  title;
  final String  subTitle;
  final ValueChanged valueChanged;
  final String imageAssets;
  const ProfileNotification({Key? key, required this.valueChanged, required this.status4, required this.title, required this.subTitle, required this.imageAssets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 4,top: 5,bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(imageAssets,width: 25,height: 25,color: appBlack),
                      const SizedBox(
                        height: 10,width: 25                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: title, fontFamily: 'Gilroy', color: Colors.black, fontSize: 16, ),
                          const SizedBox(height: 5),
                          MyText(text: subTitle, fontFamily: 'Gilroy', color: Colors.black54, fontSize: 12,),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right:10 ),
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
              ),

            ],
          ),
        ),
        const  Divider(color: lightText),
      ],
    );
  }
}

