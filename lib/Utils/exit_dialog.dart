import 'package:flutter/material.dart';

import '../Widgets/my_text.dart';
import '../color_constant.dart';

exitShowDialog(BuildContext context,String title,String noValue,String yesValue,String subTitle,VoidCallback cancelClick,VoidCallback okClick) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(text: title, fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w700, textColor: appBlack),
          const SizedBox(height: 10),
          MyText(text: subTitle, fontName: 'Gilroy', fontSize: 16, fontWeight: FontWeight.w500, textColor: appBlack),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: cancelClick,
          child:  MyText(text: noValue, fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w600, textColor: appBlack),
        ),
        TextButton(
          onPressed: okClick,
          child:  MyText(text: yesValue, fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w600, textColor: appBlack),
        ),
      ],
    ),
  );
}