import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DeleteButton.dart';
import '../LoginModule/Map/FamilyListDataModel.dart';
import '../LoginModule/custom_color.dart';
import '../Utils/view_image.dart';
import '../new_widgets/my_new_text.dart';

class TrackFamilyItem extends StatelessWidget {
  FamilyListDataModel familyListDataModel;
  final VoidCallback deleteClick;

   TrackFamilyItem({Key? key, required this.familyListDataModel, required this.deleteClick}) : super(key: key);

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 7),
                      child: CircularImage(
                          imageUrl: familyListDataModel.memberPhoto,
                          boxFit: BoxFit.cover,
                          width: 40,
                          height: 40),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          NewMyText(textValue: familyListDataModel.memberName.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                              fontSize: 16),
                          const SizedBox(height: 5),
                          NewMyText(textValue: "Relation: ${familyListDataModel.memberRelation.toString()}", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
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
                      child: NewMyText(textValue: familyListDataModel.memberMobileNumber.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: NewMyText(textValue: familyListDataModel.memberEmailId.toString() == "" ?
                      "Email: N/A" : familyListDataModel.memberEmailId.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DeleteButtonWidget(userId: familyListDataModel.userId.toString(), memberId: "",
                      status: familyListDataModel.memberStatus.toString(),
                      click: deleteClick, onTap: () {  },

                    )
                  ],
                ),

              ],
            )


        ),
      ],
    );
  }
}
