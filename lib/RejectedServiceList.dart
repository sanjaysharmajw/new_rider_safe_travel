import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:ride_safe_travel/color_constant.dart';
import 'package:ride_safe_travel/controller/permision_controller.dart';
import 'package:ride_safe_travel/users_status_controller.dart';

import 'LoginModule/custom_color.dart';
import 'LoginModule/preferences.dart';
import 'MyText.dart';
import 'ServicesPage.dart';
import 'Services_Module/complete_service_request_body.dart';
import 'Services_Module/complete_service_request_contoller.dart';
import 'Services_Module/requested_servicelists_item.dart';
import 'Services_Module/service_requestlist_controller.dart';
import 'Services_Module/service_types.dart';
import 'Utils/CustomLoader.dart';
import 'Utils/Loader.dart';
import 'Utils/exit_dialog.dart';
import 'Widgets/add_custom_btn.dart';
import 'accept_reject_controller.dart';
import 'body_request/accept_reject_body_request.dart';
import 'bottom_nav/EmptyScreen.dart';
import 'bottom_nav/custom_bottom_navi.dart';
import 'new_widgets/my_new_text.dart';

class RejectedServiceList extends StatefulWidget {
  const RejectedServiceList({Key? key}) : super(key: key);

  @override
  State<RejectedServiceList> createState() => _RejectedServiceListState();
}

class _RejectedServiceListState extends State<RejectedServiceList> {
  final requestedservicelist = Get.put(ServiceRequestListController());
  final permissionController = Get.put(PermissionController());

  LocationData? currenctLoaction;
  Location? location;
   double? _rating;
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  void getCurrentLocation() async {
    location = Location();
    currenctLoaction = await location!.getLocation();

    if (currenctLoaction != null) {
      requestedServiceListApi(
          currenctLoaction!.longitude!, currenctLoaction!.latitude!);
      print(
          "requestedServiceList....." + currenctLoaction!.longitude.toString());
      print(
          "requestedServiceList....." + currenctLoaction!.latitude.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBlue,
          elevation: 0,
          title: Text("road_side_assistance".tr,
              style: TextStyle(
                color: appWhiteColor,
                fontSize: 22,
                fontFamily: 'Gilroy',
              )),
          leading: IconButton(
            color: appWhiteColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomBottomNav()));
            },
            icon: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return requestedservicelist.isLoading.value
                      ? LoaderUtils.loader()
                      : requestedservicelist.requestedList.isEmpty
                          ? Center(
                              child: EmptyScreen(
                                text: 'reqquested_list_not_found'.tr,
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  requestedservicelist.requestedList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                print(
                                  requestedservicelist.requestedList.length,
                                );

                                return RequestedServiceListItems(
                                  requestedList:
                                      requestedservicelist.requestedList[index],
                                  feedBackClick: () {
                                    commentDialogBox(
                                        context,
                                        requestedservicelist
                                            .requestedList[index].id
                                            .toString());
                                  },
                                  deleteUser: () {
                                    print("REJECT");
                                    exitShowDialog(
                                        context,
                                        'Confirmation',
                                        'No',
                                        'Yes',
                                        'Do you really want to cancel a request ?',
                                        () {
                                      Get.back();
                                    }, () {
                                      print("on process to delete");
                                      acceptRejectApi(
                                          index,
                                          requestedservicelist
                                              .requestedList[index].id
                                              .toString(),
                                          'Cancel');
                                    });
                                  },
                                );
                              });
                }),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: FloatingActionButton(
            backgroundColor: appBlue,
            onPressed: () {
              // Get.to(const ServicesScreenPage());
              Get.to(const ServiceListsScreen());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void requestedServiceListApi(
    double lng,
    double lat,
  ) async {
    await requestedservicelist.getRequestedServicesList(lng, lat);
  }

  Future commentDialogBox(BuildContext context, String serviceId) {
    TextStyle textStyle = const TextStyle(
        color: appBlack, fontFamily: 'Gilroy', height: 1.4, fontSize: 16);
    final commentTextController = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 325,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const NewMyText(
                          textValue: 'Comment',
                          fontName: 'Gilroy',
                          color: appBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                      IconButton(
                          padding: const EdgeInsets.only(left: 30.0),
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close_outlined)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: commentTextController,
                        style: textStyle,
                        cursorColor: appBlack,
                        maxLines: 4,
                        minLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Type your message',
                          hintStyle: const TextStyle(color: appBlack),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: appBlack, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: appBlack, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Rate Service : "),
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 15,right: 10),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 5,
                          ),
                          onRatingUpdate: (rating) {
                            _rating = rating;
                            print(_rating);
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      AddCustomButton(
                          press: () {
                            if (commentTextController.text
                                .toString()
                                .isNotEmpty) {
                              completeService(serviceId, commentTextController,_rating!);
                            } else {
                              LoaderUtils.showToast(
                                  'Write something in the comment box.');
                            }
                          },
                          buttonText: 'Submit')
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void completeService(
      String serviceId, TextEditingController commentTextController, double rating) async {
    final completeService = Get.put(CompleteServiceRequestController());
    CompleteServiceRequestBody requestBody = CompleteServiceRequestBody(
        serviceId: serviceId.toString(),
        feedback: commentTextController.text.toString(),
        userId: Preferences.getId(Preferences.id).toString(),
      rating: rating
    );
    await completeService.completeServiceApi(requestBody).then((value) {
      if (value != null) {
        if (value.status == true) {
          LoaderUtils.message(value.message.toString());
          Get.back();
        } else {
          LoaderUtils.message(value.message.toString());
        }
      }
    });
  }

  /* void dialog(int index, String status) {
    exitShowDialog(context, 'Confirmation', 'No', 'Yes',
        'Are you sure you want to $status?', () {
          Get.back();
        }, () {
          acceptRejectApi(
              requestedservicelist.requestedList[index].id.toString(), status);
        });
  }*/

  void acceptRejectApi(int index, String id, String status) async {
    var userid = Preferences.getId(Preferences.id);
    print(id + "acceptReject" + status + "  " + userid);

    final controllerApi = Get.put(ServiceAcceptRejectController());
    AcceptRejectBodyRequest request = AcceptRejectBodyRequest(
        id: id.toString(),
        userId: Preferences.getId(Preferences.id).toString(),
        status: status.toString());
    print("RequestBody..." + request.toString());
    await controllerApi.acceptRejectApi(request).then((value) async {
      if (value?.status == true) {
        // print(value?.message.toString());

        CustomLoader.message(value!.message.toString());
        Get.back();
        //requestedservicelist.requestedList.removeAt(index);

        requestedServiceListApi(
            currenctLoaction!.longitude!, currenctLoaction!.latitude!);
      } else {
        CustomLoader.message(value!.message.toString());
      }
    });
  }
}
