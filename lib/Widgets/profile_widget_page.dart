
import 'package:flutter/material.dart';


import '../MyText.dart';
import '../color_constant.dart';


class ProfileWidgetPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback click;
  final IconData iconData;
  const ProfileWidgetPage({Key? key, required this.title, required this.subtitle, required this.click, required this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5,top: 5),
            child: Row(
              children:  [
                 Icon(iconData,size: 25),
                const SizedBox(
                  height: 10,width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: title, fontFamily: 'Gilroy', color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),
                    const SizedBox(height: 5),
                    MyText(text: subtitle, fontFamily: 'Gilroy', color: Colors.black54, fontSize: 12, fontWeight: FontWeight.normal,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
