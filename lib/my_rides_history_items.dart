

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'LoginModule/custom_color.dart';
import 'Models/rider_history_model.dart';
import 'color_constant.dart';
import 'new_widgets/my_new_text.dart';
import 'new_widgets/new_my_image.dart';

class MyRidesHistoryItems extends StatelessWidget {
 final RiderHistoryData riderHistoryData;
 final VoidCallback clickList;
 final String fromDestination;
 final String toDestination;
  const MyRidesHistoryItems({Key? key, required this.riderHistoryData, required this.clickList, required this.toDestination, required this.fromDestination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat.yMMMd(); // use any format
    String formatted = formatter.format(DateTime.parse(riderHistoryData.date.toString()));
    print(formatted);

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
                          NewMyText(textValue: formatted, fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16),
                          NewMyText(textValue: riderHistoryData.totalTime.toString() == "null" ? "" : riderHistoryData.totalTime.toString(),
                              fontName: 'Gilroy', color: lightText, fontWeight: FontWeight.w200, fontSize: 14)
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NewMyText(textValue: riderHistoryData.vehicleRegistrationNumber.toString(), fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w700, fontSize: 16),
                          NewMyText(textValue: riderHistoryData.driverName.toString(), fontName: 'Gilroy', color: lightText, fontWeight: FontWeight.w400, fontSize: 14)
                        ],
                      ),
                    ),

                  const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: NewMyText(textValue: fromDestination.toString() +toDestination.toString() == null ? " " :
                          fromDestination.toString() +toDestination.toString(),
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
