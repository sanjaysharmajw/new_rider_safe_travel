import 'package:flutter/material.dart';

import '../LoginModule/custom_color.dart';
import '../Utils/view_image.dart';
import '../color_constant.dart';
import '../new_widgets/my_new_text.dart';
import 'co_passanger_models.dart';


class CoPassangerItems extends StatelessWidget {
  final Copassenger passangerListData;
  const CoPassangerItems({Key? key, required this.passangerListData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: CustomColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewMyText(textValue: passangerListData.name.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewMyText(textValue: passangerListData.age.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),


                  ],
                ),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewMyText(textValue: passangerListData.gender.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewMyText(textValue: passangerListData.bloodgroup.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),

                  ],
                ),


              ],
            )


        ),
      ],
    );

  /*  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children:   [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                NewMyText(textValue: passangerListData.name.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                    fontSize: 16),
                NewMyText(textValue: passangerListData.age.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                    fontSize: 16),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                NewMyText(textValue: passangerListData.gender.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                    fontSize: 14),
                NewMyText(textValue: passangerListData.bloodgroup??"", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                    fontSize: 14),
              ],
            ),
          ],
        ),
      ],
    );*/
     /* Container(

      margin: const EdgeInsets.only( top: 5, bottom: 10),
      width: double.infinity,
      decoration:  BoxDecoration(
        border: Border.all(color: appLightGrey),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children:   [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  NewMyText(textValue: passangerListData.name.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                      fontSize: 16),
                  NewMyText(textValue: passangerListData.age.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                      fontSize: 16),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  NewMyText(textValue: passangerListData.gender.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                      fontSize: 14),
                  NewMyText(textValue: passangerListData.bloodgroup??"", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                      fontSize: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );*/
  }
}
