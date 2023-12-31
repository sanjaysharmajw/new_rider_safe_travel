import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:ride_safe_travel/MyText.dart';
import 'package:ride_safe_travel/controller/check_active_ride_models.dart';
import 'package:ride_safe_travel/controller/check_active_rider.dart';

class HomePageDetails extends StatelessWidget {
  final VoidCallback goRide;
  final VoidCallback stopRide;
  final CheckData data;
  const HomePageDetails(
      {Key? key,
      required this.goRide,
      required this.stopRide,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Visibility(
      visible: true,
      child: Padding(
        padding: const EdgeInsets.only(right: 17.0, left: 17.0),
        child: GestureDetector(
          onTap: goRide,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                      imageUrl: data.vehiclePhoto.toString(),
                                      width: 80,
                                      height: 60,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Image(
                                            image: AssetImage(
                                              "assets/carImage.png",
                                            ),
                                            height: 50,
                                            width: 50,
                                          )),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 35,
                                  top: 4,
                                  child: CircleAvatar(
                                    backgroundColor: CustomColor.black,
                                    radius: 22,
                                    child: CircleAvatar(
                                      radius: 21,
                                      backgroundColor: Colors.white,
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  data.driverPhoto.toString(),
                                              width: 25,
                                              height: 25,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Image(
                                                      image: AssetImage(
                                                          "assets/user_avatar.png"))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                              text: data.vehicleRegistrationNumber.toString().isEmpty || data.vehicleRegistrationNumber.toString() == "null" ?
                              " " : data.vehicleRegistrationNumber.toString(),
                              fontFamily: 'Gilroy',
                              color: Colors.black,
                              fontSize: 16),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              MyText(
                                  text: data.vehicleMake.toString().isEmpty || data.vehicleMake.toString() == "null" ? " "
                                      : data.vehicleMake.toString(),
                                  fontFamily: 'Gilroy',
                                  color: Colors.black,
                                  fontSize: 14),
                              const SizedBox(width: 3),
                              MyText(
                                  text: data.vehicleModel.toString().isEmpty || data.vehicleMake.toString() == "null" ? " " :
                                  data.vehicleModel.toString(),
                                  fontFamily: 'Gilroy',
                                  color: Colors.black,
                                  fontSize: 14),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            data.driverName.toString().isEmpty || data.driverName.toString() == "null" ? " " :
                            data.driverName.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Gilroy',
                                decoration: TextDecoration.underline),
                          ),
                          Visibility(
                            visible:  data.rating==null?false:true,
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 3, right: 3),
                                  child: Text("."),
                                ),
                                Text(
                                  data.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Gilroy',
                                  ),
                                ),
                                Icon(
                                  Icons.star_outlined,
                                  color: Colors.blueGrey,
                                  size: 14.0,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 20),
                          child: ClipOval(
                            child: Material(
                              //color: CustomColor.lightYellow, // button color
                              child: InkWell(
                                splashColor: Colors.blue,
                                highlightColor:
                                    theme.colorScheme.primary.withAlpha(28),
                                onTap: stopRide,
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Image.asset(
                                      'new_assets/stop-sign (2).png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
