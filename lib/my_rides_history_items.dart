

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'LoginModule/custom_color.dart';
import 'color_constant.dart';
import 'new_widgets/my_new_text.dart';
import 'new_widgets/new_my_image.dart';

class MyRidesHistoryItems extends StatelessWidget {
  final String vehicleReg;
  final String driverName;

  final String fromdestination;
  final String todestination;
  final VoidCallback clickList;
  const MyRidesHistoryItems({Key? key, required this.vehicleReg, required this.driverName,
    required this.fromdestination, required this.clickList, required this.todestination, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          SizedBox(height: 8,),
          Padding(
          padding: const EdgeInsets.only(left: 15,right:15),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: CustomColor.white,
            child: InkWell(
              onTap: clickList,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NewMyText(textValue: vehicleReg, fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w700, fontSize: 16),
                          NewMyText(textValue: driverName, fontName: 'Gilroy', color: lightText, fontWeight: FontWeight.w400, fontSize: 14)
                        ],
                      ),
                    ),

                  const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: NewMyText(textValue: fromdestination.toString() +todestination.toString() == "null" ? " " :
                          fromdestination.toString() +todestination.toString(),
                              fontName: 'Gilroy', color: lightText, fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        const NewMyImage(image: 'new_assets/forword_arrow.png', width: 15, height: 15, fit: BoxFit.contain, color: appBlack),
                      ],
                    ),
                    const SizedBox(height: 5),

                  ],
                ),
              ),
            ),
          ),
    ),
        ],
      );
  }
}
