import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';

class DrawerInfo extends StatelessWidget {
  final String dInfoName;
  final String dInfoMobile;
  final String dInfoImage;
  final String dInfoLicense;

  final String vInfoImage;
  final String vInfoModel;
  final String vInfoOwnerName;
  final String vInfoRegNo;

  final VoidCallback press;
  final bool visibility;

  DrawerInfo(
      {Key? key,
      required this.dInfoName,
      required this.dInfoMobile,
      required this.dInfoImage,
      required this.vInfoImage,
      required this.vInfoModel,
      required this.vInfoOwnerName,
      required this.vInfoRegNo,
      required this.dInfoLicense,
      required this.press, required this.visibility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: press,
              child: const Icon(Icons.keyboard_backspace_sharp,
                  color: CustomColor.black)),
          const SizedBox(
            height: 20,
          ),
          const Text("Driver Information",
              style: TextStyle(fontFamily: 'transport', fontSize: 18)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: CustomColor.listColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.network(
                        dInfoImage,
                        width: 60,
                        height: 60,
                      ),
                      // CircleAvatar(
                      //   backgroundColor: CustomColor.yellow,
                      //   radius: 30.0,
                      //   child: CircleAvatar(
                      //     radius: 29.0,
                      //     backgroundColor: Colors.white,
                      //     child: ClipOval(
                      //       child: (dInfoImage != null)
                      //           ? Image.network(
                      //         dInfoImage!,
                      //         width: 100,
                      //         height: 100,
                      //         fit: BoxFit.cover,
                      //       )
                      //           : Image.asset('images/bottom_drawer_comp.png'),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 35),
                          child: Text(dInfoName,
                              style: const TextStyle(
                                  fontFamily: 'transport', fontSize: 16)),
                        ),
                        Text(dInfoMobile,
                            style: const TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     //   Text("Mobile No: ",
                    //     //     style: TextStyle(
                    //     //         fontFamily: 'transport', fontSize: 16)),
                    //     // Text(dInfoMobile,
                    //     //     style:   TextStyle(
                    //     //         fontFamily: 'transport', fontSize: 16)),
                    //   ],
                    // ),

                    Visibility(
                      visible: visibility,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text("Driving License No: ",
                                style: TextStyle(
                                    fontFamily: 'transport', fontSize: 16)),
                          ),
                          Text(dInfoLicense,
                              style: const TextStyle(
                                  fontFamily: 'transport', fontSize: 16)),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("Vehicles Information",
              style: TextStyle(fontFamily: 'transport', fontSize: 18)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: CustomColor.listColor,
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image(
                            image: AssetImage(vInfoImage),
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(vInfoModel,
                              style: const TextStyle(
                                  fontFamily: 'transport', fontSize: 16)),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 26),
                                child: Text("Vehicle Owner Name: ",
                                    style: TextStyle(
                                        fontFamily: 'transport', fontSize: 16)),
                              ),
                              Text(vInfoOwnerName,
                                  style: const TextStyle(
                                      fontFamily: 'transport', fontSize: 14)),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Registration Number:",
                                      style: TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 16)),
                                  Text(vInfoRegNo,
                                      style: const TextStyle(
                                          fontFamily: 'transport',
                                          fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
