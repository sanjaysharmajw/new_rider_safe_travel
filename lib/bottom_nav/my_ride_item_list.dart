import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/MyText.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/RideDataModel.dart';
import 'new_my_rider_model.dart';


class MyRiderItemsList extends StatelessWidget {
  final DataMyRider myRideList;
  final VoidCallback pressOnView;
  final VoidCallback pressOnEnd;

  const MyRiderItemsList({Key? key, required this.myRideList, required this.pressOnView, required this.pressOnEnd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      width: double.infinity,
      decoration:  BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              MyText(text: myRideList.date.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 15),
              MyText(text: myRideList.date.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 15),

            ],
          ),*/
          const SizedBox(height: 15),
          Row(
            children: [
              /* ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: const BorderRadius.all(Radius.circular(60)),
                child: Image.network(myRideList.driverPhoto.toString(),width: 40,height: 40,fit: BoxFit.cover),
              ),*/
              const SizedBox(height: 10,width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(text: myRideList.vehicleRegistrationNumber.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 16),
                  const SizedBox(height: 5),
                  MyText(text: myRideList.vehicleModel.toString(), fontFamily: 'Gilroy', color: Colors.black, fontSize: 14),
                ],
              )

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipOval(
                child: Material(
                  color:
                  theme.colorScheme.error.withAlpha(28), // button color
                  child: InkWell(
                    splashColor: theme.colorScheme.error.withAlpha(100),
                    highlightColor: theme.colorScheme.error.withAlpha(28),
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          FeatherIcons.eye,
                          color: theme.colorScheme.error,
                        )),
                    onTap: pressOnView,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: Material(
                    color: CustomColor.lightYellow, // button color
                    child: InkWell(
                      splashColor: Colors.yellow,
                      highlightColor:
                      theme.colorScheme.primary.withAlpha(28),
                      child:  SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.asset('images/End_Ride.png'),
                      ),
                      onTap: pressOnEnd,
                    ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
