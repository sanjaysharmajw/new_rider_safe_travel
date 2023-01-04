import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:get/get.dart';

class UserVehiclesInfo extends StatelessWidget {
  final String dInfoName;
  final String dInfoMobile;
  final String dInfoImage;
  final String dInfoLicense;

  final String vInfoImage;
  final String vInfoModel;
  final String vInfoOwnerName;
  final String vInfoRegNo;
  final String vInfoPuc;
  final String vInfoFitness;
  final String vInfoInsurance;
  final VoidCallback press;
  final VoidCallback pressBtn;
  final String pressBtnText;

  const UserVehiclesInfo(
      {Key? key,
      required this.dInfoName,
      required this.dInfoMobile,
      required this.dInfoImage,
      required this.vInfoImage,
      required this.vInfoModel,
      required this.vInfoOwnerName,
      required this.vInfoRegNo,
      required this.vInfoPuc,
      required this.vInfoFitness,
      required this.vInfoInsurance,
      required this.dInfoLicense,
      required this.press,
      required this.pressBtn,
      required this.pressBtnText})
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
                      CircleAvatar(
                        backgroundColor: CustomColor.yellow,
                        radius: 30.0,
                        child: CircleAvatar(
                          radius: 29.0,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: (dInfoImage != null)
                                ? Image.network(
                                    dInfoImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/car.png'),
                          ),
                        ),
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(dInfoName,
                            style: const TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                        // Text(dInfoMobile,
                        //     style: const TextStyle(
                        //         fontFamily: 'transport', fontSize: 16)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Mobile No: ",
                            style: TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                        Text(dInfoMobile,
                            style: const TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Driving License No: ",
                            style: TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                        Text(dInfoLicense,
                            style: const TextStyle(
                                fontFamily: 'transport', fontSize: 16)),
                      ],
                    ),
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
                          CircleAvatar(
                            backgroundColor: CustomColor.yellow,
                            radius: 30.0,
                            child: CircleAvatar(
                              radius: 29.0,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: (vInfoImage != null)
                                    ? Image.network(
                                        vInfoImage!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/car.png'),
                              ),
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Vehicle Owner Name: ",
                                  style: TextStyle(
                                      fontFamily: 'transport', fontSize: 16)),
                              Text(vInfoOwnerName,
                                  style: const TextStyle(
                                      fontFamily: 'transport', fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Registration Number: ",
                          style:
                              TextStyle(fontFamily: 'transport', fontSize: 16)),
                      Text(vInfoRegNo,
                          style:
                              TextStyle(fontFamily: 'transport', fontSize: 16)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("PUC Validity: ",
                          style:
                              TextStyle(fontFamily: 'transport', fontSize: 16)),
                      Text(vInfoPuc,
                          style: const TextStyle(
                              fontFamily: 'transport', fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Fitness Validity: ",
                          style:
                              TextStyle(fontFamily: 'transport', fontSize: 16)),
                      Text(vInfoFitness,
                          style: const TextStyle(
                              fontFamily: 'transport', fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Insurance Validity: ",
                          style:
                              TextStyle(fontFamily: 'transport', fontSize: 16)),
                      Text(vInfoInsurance,
                          style: const TextStyle(
                              fontFamily: 'transport', fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 65,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: pressBtn,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: CustomColor.yellow,
                    foregroundColor: CustomColor.black),
                child: Text(
                  pressBtnText,
                  style: const TextStyle(
                      fontFamily: "transport",
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
