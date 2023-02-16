import 'package:flutter/material.dart';
import 'package:ride_safe_travel/LoginModule/custom_color.dart';
import 'package:get/get.dart';



class UserVehicleInfo extends StatefulWidget {
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
  const UserVehicleInfo({Key? key, required this.dInfoName, required this.dInfoMobile, required this.dInfoImage,
    required this.dInfoLicense, required this.vInfoImage, required this.vInfoModel, required this.vInfoOwnerName,
    required this.vInfoRegNo, required this.vInfoPuc, required this.vInfoFitness, required this.vInfoInsurance,
    required this.press, required this.pressBtn, required this.pressBtnText}) : super(key: key);

  @override
  State<UserVehicleInfo> createState() => _UserVehicleInfoState();
}

class _UserVehicleInfoState extends State<UserVehicleInfo> {

  bool checkBoxValue = false;
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: widget.press,
                  child: const Icon(Icons.keyboard_backspace_sharp,
                      color: CustomColor.black)),
              const SizedBox(
                height: 20,
              ),
              const Text("Driver Information",
                  style: TextStyle(fontFamily: 'transport', fontSize: 18)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
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
                              radius: 30,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  child: (widget.dInfoImage != null)
                                      ? Image.network(
                                    widget.dInfoImage,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.asset('assets/user_avatar.png'),
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
                              Text(widget.dInfoName,
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

                              Text(widget.dInfoMobile,
                                  style: const TextStyle(
                                      fontFamily: 'transport', fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Driving License No: ",
                                  style: TextStyle(
                                      fontFamily: 'transport', fontSize: 16)),
                              Text(widget.dInfoLicense,
                                  style: const TextStyle(
                                      fontFamily: 'transport', fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
                                    child: (widget.vInfoImage != null)
                                        ? Image.network(
                                      widget.vInfoImage!,
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
                              Text(widget.vInfoModel,
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
                                  Text(widget.vInfoOwnerName,
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
                          Text(widget.vInfoRegNo,
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
                          Text(widget.vInfoPuc,
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
                          Text(widget.vInfoFitness,
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
                          Text(widget.vInfoInsurance,
                              style: const TextStyle(
                                  fontFamily: 'transport', fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Details not matched ?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),

                          SizedBox(width: 40,),
                          Transform.scale(

                            scale: 1.0,
                            child: Checkbox(

                                value: checkBoxValue,
                                checkColor: CustomColor.white,
                                activeColor: CustomColor.yellow,
                                onChanged: (value){
                              setState((){
                                checkBoxValue = value!;
                              });

                                }),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        child: Container(
                          height: 100,
                          decoration:  BoxDecoration (
                            borderRadius:  BorderRadius.circular(8),
                            border:  Border.all(color: Color(0xffffd91d)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20,top: 2),
                            child: TextFormField(
                               controller: commentController,

                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a Comment',
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Can\'t be empty';
                                }
                                if (text.length < 4) {
                                  return 'Too short';
                                }
                                return null;
                              },
                              // update the state variable when the text changes

                            ),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: widget.pressBtn,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: CustomColor.yellow,
                          foregroundColor: CustomColor.black),
                      child: Text(
                        widget.pressBtnText,
                        style: const TextStyle(
                            fontFamily: "transport",
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

