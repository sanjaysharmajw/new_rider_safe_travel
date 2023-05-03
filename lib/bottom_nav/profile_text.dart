



import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ride_safe_travel/MyText.dart';

class ProfileText extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icons;
  final VoidCallback voidCallback;
  const ProfileText({Key? key, required this.title, required this.subTitle, required this.icons,required this.voidCallback}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
      child: GestureDetector(
        onTap: voidCallback,
        child: Container(
          height: 55,
          width: 500,
          color: Colors.transparent,
          child: Center(
            child: Row(
              children:  [
                Icon(icons),
                const SizedBox(
                  height: 10,width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    MyText(text: title,  fontFamily: 'Gilroy', color: Colors.black, fontSize: 16,),
                    const SizedBox(height: 5),
                    MyText(text: subTitle,  fontFamily: 'Gilroy', color: Colors.black, fontSize: 12),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
