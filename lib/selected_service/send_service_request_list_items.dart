import 'package:flutter/material.dart';
import 'package:ride_safe_travel/selected_service/search_service_provider_model.dart';

import '../Widgets/add_custom_btn.dart';
import '../color_constant.dart';

import 'package:get/get.dart';

import '../new_widgets/my_new_text.dart';



class SendServiceProvideRequestListItems extends StatelessWidget {

  final SearchServiceProviderModelData searchServiceProviderModelData;
  final VoidCallback requestClick;
  const SendServiceProvideRequestListItems({Key? key, required this.searchServiceProviderModelData, required this.requestClick, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: appLightGrey),
        color: appWhiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.only(left: 10, right: 20, top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: NewMyText(
                      textValue: searchServiceProviderModelData.title==""?"":searchServiceProviderModelData.title.toString(),
                      fontName: 'Gilroy',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              ),
               NewMyText(
                  textValue: searchServiceProviderModelData.dist.toString(),
                  fontName: 'Gilroy',
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Flexible(
                   child: NewMyText(textValue: searchServiceProviderModelData.address.toString(),textMaxLine: 2,
                       fontName: 'Gilroy', color: appBlack, fontWeight: FontWeight.w500, fontSize: 16)),
              Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Material(
                      color: appLightBlue, // button color
                      child: SizedBox(
                          width: 100,
                          height: 30,
                          child: AddCustomButton(press:  requestClick, buttonText: 'request'.tr)
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );

  }




}
