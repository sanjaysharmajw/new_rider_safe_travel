import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/custom_button.dart';
import 'package:ride_safe_travel/switchbutton.dart';
import '../DeleteButton.dart';
import '../Error.dart';
import '../FamilyMemberDataModel.dart';
import '../LoginModule/custom_color.dart';
import '../LoginModule/preferences.dart';
import '../Models/MemberBlockDeleteModel.dart';
import '../Utils/EmptyScreen.dart';
import '../Utils/Loader.dart';
import '../Utils/circular_image_widgets.dart';
import '../family_list_item.dart';
import '../familylist_controller.dart';
import '../new_widgets/my_new_text.dart';
import '../new_widgets/new_button.dart';
import '../start_ride_map.dart';
import '../users_status_controller.dart';

class TrackingMeList extends StatefulWidget {
  final String riderId;
  final String socketToken;
  final String dName;
  final String dMobile;
  final String dPhoto;
  final String model;
  final String vOwnerName;
  final String vRegNo;
  final String driverLicense;
  final String otpRide;
  const TrackingMeList({Key? key, required this.riderId, required this.socketToken, required this.dName, required this.dMobile, required this.dPhoto, required this.model, required this.vOwnerName, required this.vRegNo, required this.driverLicense, required this.otpRide}) : super(key: key);

  @override
  State<TrackingMeList> createState() => _UserFamilyListState();
}

class _UserFamilyListState extends State<TrackingMeList> {
  var _future;

  /*Future<List<FamilyMemberDataModel>> getUserFamilyList() async {
    setState(() {});
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      (Uri.parse(
          ApiUrl.myFamilyList)), //old end url: userFamilyList
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user_id": userId}),
    );
    if (response.statusCode == 200) {
      print('RES:${response.body}');
      List<FamilyMemberDataModel> loginData = jsonDecode(response.body)['data']
          .map<FamilyMemberDataModel>(
              (data) => FamilyMemberDataModel.fromJson(data))
          .toList();
      return loginData;
    } else {
      throw Exception('Failed to load');
    }
  }*/

  @override
  void initState() {
    super.initState();
    setState(() {
      familyListApi();
    });
  }


  final familyListController=Get.put(FamilyListController());
  final userstatusController = Get.put(UserStatusController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 15,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: CustomColor.white,
                  size: 25,
                )),
          ),
          title: const Text("People Tracking Me",
              style: TextStyle(
                color: CustomColor.white,
                fontSize: 20,
                fontFamily: 'Gilroy',
              )),

        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: appBlue,
          onPressed: (){
            Get.to(
                StartRide(
                    riderId: widget.riderId.toString(),
                    dName: widget.dName.toString() == 'null' ? "" : widget.dName.toString(),
                    dMobile: widget.dMobile.toString() == 'null' ? "" : widget.dMobile.toString(),
                    dPhoto: widget.dPhoto.toString() == 'null' ? "" :  widget.dPhoto.toString(),
                    model: widget.model.toString() == 'null' ? "" : widget.model.toString(),
                    vOwnerName: widget.vOwnerName.toString() == 'null' ? "" : widget.vOwnerName.toString(),
                    vRegNo: widget.vRegNo.toString() == 'null' ? "" : widget.vRegNo.toString(),
                    socketToken: widget.socketToken.toString(), driverLicense: widget.driverLicense.toString(),otpRide: widget.otpRide.toString())
            );

            Preferences.setNewRiderId(widget.riderId.toString());
          },
          label: Text("Start Ride"),
        ),


        body: Column(
          children: [
            SizedBox(height: 25,),
            Expanded(
              child: Obx(() {
                return familyListController.isLoading.value
                    ? LoaderUtils.loader()
                    : familyListController.getFamilyListData.isEmpty
                    ? Center(
                  child: EmptyScreen(),
                ) : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: familyListController.getFamilyListData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FamilyListItems(memberDataModel: familyListController.getFamilyListData[index],
                        deleteClick: () {
                          userStatusApi(index,familyListController.getFamilyListData[index].userId.toString(),
                              familyListController.getFamilyListData[index].memberId.toString(), 'Deleted');
                        }, blockClick: () {
                          setState(() {
                            userStatusApi(index,familyListController.getFamilyListData[index].userId.toString(),
                                familyListController.getFamilyListData[index].memberId.toString(), 'Blocked');
                          });
                        },);
                    });
              }),
            ),
          ],
        ),

      /*Container(
          child: Column(
            children: [
              Expanded(child: FutureBuilder<List<FamilyMemberDataModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isEmpty
                    ? Center(
                    child: Text(
                      'Data not found',
                      style: TextStyle(fontSize: 20, color: Colors.black12),
                    ))
                    : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // var item = snapshot.data![index].data?[index];
                    image =
                    "${snapshot.data![index].memberProfileImage.toString()}";
                    memberId = snapshot.data![index].memberId.toString();
                    memberStatus =
                        snapshot.data![index].memberStatus.toString();
                    memberName =
                        "${snapshot.data![index].memberFName.toString()}" +
                            " " +
                            "${snapshot.data![index].memberLName.toString()}";
                    print(snapshot.data!.length);
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    return InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child:   Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                            child: Container(
                              height: 155,
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
                                                imageLink: image,
                                                //boxFit: BoxFit.cover,
                                                imageWidth: 40,
                                                imageHeight: 40, borderColor: Colors.black,),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,top: 7),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:  [
                                                NewMyText(textValue:snapshot.data![index].memberFName.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                                const SizedBox(height: 5),
                                                NewMyText(textValue: "Relation: ${snapshot.data![index].relation.toString()}", fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
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
                                            child: NewMyText(textValue:snapshot.data![index].memberMobileNumber.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: NewMyText(textValue: snapshot.data![index].memberEmailId.toString() == "null" ?
                                            "Email: " :snapshot.data![index].memberEmailId.toString(), fontName: 'Gilroy', color: Colors.black, fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: ToggleSwitchButton(mstatus: snapshot.data![index].memberStatus.toString(),
                                              memberId: snapshot.data![index].memberId.toString(),
                                              userId:snapshot.data![index].userId.toString(),),
                                          ),
                                          DeleteButtonWidget(userId: snapshot.data![index].userId.toString(), memberId: snapshot.data![index].memberId.toString(),
                                            status: snapshot.data![index].memberStatus.toString(),
                                            click: deleteClick,
                                            onTap: blockClick,
                                          )
                                        ],
                                      ),

                                    ],
                                  )


                              ),
                            ),
                          ),
                        ],

                      )
                      /*Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    height: 180,
                                    width: 320,
                                    child: Card(
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              height: 170,
                                              width: 350,
                                              decoration: BoxDecoration(
                                                  color: CustomColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0)),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            right: 20,
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: CustomColor.white,
                                              ),
                                              child:  ClipRRect(
                                                child: CachedNetworkImage(
                                                    imageUrl: snapshot.data![index].memberProfileImage
                                                        .toString(),
                                                    width: 80,
                                                    height: 60,
                                                    progressIndicatorBuilder: (context, url,
                                                        downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value: downloadProgress.progress),
                                                    errorWidget: (context, url, error) =>
                                                    const Image(
                                                      image: AssetImage(
                                                        "assets/user_avatar.png",
                                                      ),
                                                      height: 50,
                                                      width: 50,
                                                    )),
                                              ),

                                            ),
                                          ),

                                          Positioned(
                                            top: 30,
                                            left: 40,
                                            child: Text(
                                                memberName.toString() == "null"
                                                    ? " "
                                                    : memberName.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 16)),
                                          ),
                                          Positioned(
                                            top: 50,
                                            left: 40,
                                            child: Text(
                                                snapshot.data![index]
                                                            .memberEmailId
                                                            .toString() ==
                                                        "null"
                                                    ? " "
                                                    : snapshot.data![index]
                                                        .memberEmailId
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 16)),
                                          ),
                                          Positioned(
                                            top: 70,
                                            left: 40,
                                            child: Text(
                                                snapshot.data![index]
                                                            .memberMobileNumber
                                                            .toString() ==
                                                        "null"
                                                    ? " "
                                                    : snapshot.data![index]
                                                        .memberMobileNumber
                                                        .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy',
                                                  fontSize: 16,
                                                )),
                                          ),
                                          Positioned(
                                            top: 90,
                                            left: 40,
                                            child: Text(
                                                snapshot.data![index].relation
                                                            .toString()
                                                            .toString() ==
                                                        "null"
                                                    ? " "
                                                    : snapshot
                                                        .data![index].relation
                                                        .toString()
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 14)),
                                          ),
                                          Positioned(
                                            top: 120,
                                            left: 40,
                                            child: ToggleSwitchButton(
                                              mstatus: memberStatus.toString(),
                                              memberId: snapshot.data![index].memberId.toString(), userId: snapshot.data![index].userId.toString(),
                                            ),
                                          ),
                                          Positioned(
                                              top: 120,
                                              right: 20,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      print("Deleted");
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                          context) {
                                                            return StatefulBuilder(
                                                                builder: (BuildContext
                                                                context,
                                                                    StateSetter
                                                                    setState) {
                                                                  return AlertDialog(
                                                                    content:
                                                                    Container(
                                                                      height: 120,
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          const SizedBox(
                                                                            height:
                                                                            10,
                                                                          ),
                                                                          Text("Do you really want to delete ${snapshot
                                                                              .data![index]
                                                                              .memberMobileNumber} ?"),
                                                                          const SizedBox(
                                                                              height:
                                                                              15),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child:
                                                                                ElevatedButton(
                                                                                  onPressed:
                                                                                      () {
                                                                                    // OverlayLoadingProgress.start(context);
                                                                                    getMembersStatus("Deleted");
                                                                                    setState(() {});
                                                                                   // Get.back();
                                                                                    snapshot.data!.removeAt(index);
                                                                                    //getUserFamilyList();
                                                                                  },
                                                                                  child:
                                                                                  Text("Yes"),
                                                                                  style:
                                                                                  ElevatedButton.styleFrom(primary: CustomColor.yellow),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                  width:
                                                                                  15),
                                                                              Expanded(
                                                                                  child:
                                                                                  ElevatedButton(
                                                                                    onPressed:
                                                                                        () {
                                                                                      print('no selected');
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: Text(
                                                                                        "No",
                                                                                        style: TextStyle(color: Colors.black)),
                                                                                    style:
                                                                                    ElevatedButton.styleFrom(
                                                                                      primary:
                                                                                      Colors.white,
                                                                                    ),
                                                                                  ))
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          });
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_rounded,
                                                    size: 28,
                                                    color: CustomColor.red,
                                                  )))
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),*/


                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(child: CircularProgressIndicator());
            },
          )),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: CustomButton(press: (){
                  Get.to(
                      StartRide(
                          riderId: widget.riderId.toString(),
                          dName: widget.dName.toString() == 'null' ? "" : widget.dName.toString(),
                          dMobile: widget.dMobile.toString() == 'null' ? "" : widget.dMobile.toString(),
                          dPhoto: widget.dPhoto.toString() == 'null' ? "" :  widget.dPhoto.toString(),
                          model: widget.model.toString() == 'null' ? "" : widget.model.toString(),
                          vOwnerName: widget.vOwnerName.toString() == 'null' ? "" : widget.vOwnerName.toString(),
                          vRegNo: widget.vRegNo.toString() == 'null' ? "" : widget.vRegNo.toString(),
                          socketToken: widget.socketToken.toString(), driverLicense: widget.driverLicense.toString(),otpRide: widget.otpRide.toString())
                  );

                  Preferences.setNewRiderId(widget.riderId.toString());
                }, buttonText: "Start Ride"),
              )

            ],
          ),
        )*/
    );
  }
  void userStatusApi(int index,String userId, String memberId, String status) async {
    await userstatusController.getUserStatus(index,userId, memberId, status)
        .then((value) async {
      if (value != null) {
        if (value.status == true) {
          familyListController.getFamilyListData.removeAt(index);
          setState(() async {
            familyListApi();
          });

          Get.back();
        } else {
          LoaderUtils.showToast(value.message.toString());
        }
      }
    });
  }
  void familyListApi()async{
    await familyListController.familyListApi(Preferences.getId(Preferences.id));
  }
  /*Future<MemberBlockDeleteModel> getMembersStatus(String status) async {
    setState(() {});

    if (status.toLowerCase().toString() == "Deleted") {
      Get.snackbar("Hello!", "Family member is deleted",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
      setState(() {
        getUserFamilyList();
      });
    } else if (status.toLowerCase().toString() == "Blocked") {
      Get.snackbar("Hello!", "Family member is blocked",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: CustomColor.black);
    }
    await Preferences.setPreferences();
    String userId = Preferences.getId(Preferences.id).toString();
    final response = await http.post(
      Uri.parse(
          ApiUrl.userStatus),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": userId,
        "member_id": memberId,
        "status": status.toString()
      }),
    );
    if (response.statusCode == 200) {
      setState(() {});
      getUserFamilyList();
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      var msg = jsonDecode(response.body)[ErrorMessage.message];
      print("Body: " + response.body);
      if (status == true) {
        setState(() {
          // getUserFamilyList();
        });
        getUserFamilyList();
        // Navigator.pop(context);
        // updateStatus();
        Get.snackbar("Hello!", msg.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: CustomColor.black);
      } else if (status == false) {
        Get.snackbar("Ooops!", msg.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: CustomColor.red,
            colorText: CustomColor.black);
        Navigator.pop(context);
      }
      return MemberBlockDeleteModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }*/

}
