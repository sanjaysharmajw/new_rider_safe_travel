import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';


import '../FamilyMemberDataModel.dart';

import '../switchbutton.dart';
import 'DeleteButton.dart';
import 'LoginModule/custom_color.dart';
import 'Utils/view_image.dart';
import 'color_constant.dart';
import 'familylist_controller.dart';
import 'new_widgets/my_new_text.dart';

class FamilyListItems extends StatelessWidget {

  final FamilyMemberDataModel memberDataModel;
  final VoidCallback deleteClick;
  final VoidCallback blockClick;
  const FamilyListItems({Key? key, required this.memberDataModel, required this.deleteClick, required this.blockClick,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: CustomColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10,top: 7),
                        child: CircularImage(
                            imageUrl: memberDataModel.memberProfileImage.toString(),
                            boxFit: BoxFit.cover,
                            width: 40,
                            height: 40),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            NewMyText(textValue: memberDataModel.memberFName.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                                fontSize: 16),
                            const SizedBox(height: 5),
                            NewMyText(textValue: "Relation: ${memberDataModel.relation.toString()}", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ],
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: NewMyText(textValue: memberDataModel.memberMobileNumber.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: NewMyText(textValue: memberDataModel.memberEmailId.toString() == "" ?
                        "Email: N/A" : memberDataModel.memberEmailId.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ToggleSwitchButton(mstatus: memberDataModel.memberStatus.toString(),
                          memberId: memberDataModel.memberId.toString(),
                          userId:memberDataModel.userId.toString(),),
                      ),
                      DeleteButtonWidget(userId: memberDataModel.userId.toString(), memberId: memberDataModel.memberId.toString(),
                        status: memberDataModel.memberStatus.toString(),
                        click: deleteClick,
                        onTap: blockClick,
                      )
                    ],
                  ),

                ],
              )


          ),
        ),
      ],
    );

      /*Container(
      margin: const EdgeInsets.only( top: 5, bottom: 10),
      width: double.infinity,
      decoration:  BoxDecoration(
        border: Border.all(color: appLightGrey),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 10,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircularImage(
                  imageUrl: memberDataModel.memberProfileImage.toString(),
                  boxFit: BoxFit.cover,
                  width: 40,
                  height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    NewMyText(textValue: memberDataModel.memberFName.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                        fontSize: 16),
                    const SizedBox(height: 5),
                    NewMyText(textValue: "Relation: ${memberDataModel.relation.toString()}", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ],
                ),
              ),

            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: NewMyText(textValue: memberDataModel.memberMobileNumber.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              NewMyText(textValue: memberDataModel.memberEmailId.toString() == "" ?
              "Email: N/A" : memberDataModel.memberEmailId.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToggleSwitchButton(mstatus: memberDataModel.memberStatus.toString(),
                memberId: memberDataModel.memberId.toString(),
                userId:memberDataModel.userId.toString(),),
              DeleteButtonWidget(userId: memberDataModel.userId.toString(), memberId: memberDataModel.memberId.toString(),
                status: memberDataModel.memberStatus.toString(),
                click: deleteClick,
                onTap: blockClick,
              )
            ],
          ),

        ],
      ),
    )*/
  }
}
