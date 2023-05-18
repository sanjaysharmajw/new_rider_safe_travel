

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:ride_safe_travel/DriverVehicleList.dart';
import 'package:ride_safe_travel/LoginModule/Api_Url.dart';
import 'package:ride_safe_travel/Utils/Loader.dart';

class DriverVehicelListController extends GetxController{


  Future<DriverVehicleList?> driverVehicleListApi(String result) async {
    try {
      LoaderUtils.showLoader("Please wait");
      final response = await http.post(Uri.parse(ApiUrl.driverVehicleList),
        headers: ApiUrl.headerToken,
        body: jsonEncode(
            <String, String>{'driver_id': result.toString(), "status": "Active"}),
      );
      debugPrint('driverDetails');
      debugPrint(response.body);
      debugPrint(jsonEncode(
          <String, String>{'driver_id': result.toString(), "status": "Active"}));
      const utf8Decoder = Utf8Decoder(allowMalformed: true);
      final decodedBytes = utf8Decoder.convert(response.bodyBytes);
      Map<String, dynamic> responseBody = json.decode(decodedBytes);

      if (response.statusCode == 200) {
        LoaderUtils.closeLoader();
        return DriverVehicleList.fromJson(responseBody);
      }
    }
    on TimeoutException catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.message.toString());
    }  catch (e) {
      LoaderUtils.closeLoader();
      LoaderUtils.showToast(e.toString());
    }
    return null;
  }


/*  Future<DriverVehicleList> driverVehicleListApi(String result) async {
    final response = await http.post(
      Uri.parse(ApiUrl.driverVehicleList),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'driver_id': result.toString(), "status": "Active"}),
    );
    print(jsonEncode(
        <String, String>{'driver_id': result.toString(), "status": "Active"}));

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)[ErrorMessage.status];
      print("statussssss" + status.toString());

      if (status == true) {
        OverlayLoadingProgress.stop();
        List<VehicleListData> driverDetails = jsonDecode(response.body)['data']
            .map<VehicleListData>((data) => VehicleListData.fromJson(data))
            .toList();
        print('family: $driverDetails');
        var driverName = driverDetails[0].driverName;
        var driverMob = driverDetails[0].driverMobileNumber.toString();
        var driverLicense =
            driverDetails[0].drivingLicenceNumber.toString() ?? "";
        var vOwnerName = driverDetails[0].ownerName.toString();
        var vRegNumber =
        driverDetails[0].vehicledetails![0].registrationNumber.toString();

        var vPucvalidity =
        driverDetails[0].vehicledetails![0].pucValidity.toString();
        var vFitnessValidity =
        driverDetails[0].vehicledetails![0].fitnessValidity.toString();
        var vInsurance =
        driverDetails[0].vehicledetails![0].insuranceValidity.toString();
        var vModel = driverDetails[0].vehicledetails![0].model.toString();
        var dPhoto = driverDetails[0].driverPhoto.toString();
        var vPhoto = driverDetails[0].ownerPhoto.toString();
        var vehicleIds = driverDetails[0].vehicledetails![0].id.toString();
        var driverIds = driverDetails[0].driverId.toString();
        var rating = driverDetails[0].otherInfo?.rating?.toDouble();
        var comment = driverDetails[0].otherInfo?.totalComments.toString();
        print("Rating.." + rating.toString());

        // print("PUCValidityDate:"+DateFormat('dd-MM-yyyy').format(DateTime.parse(vPucvalidity)) );
        print(response.body);

        Get.to(UserDriverInformation(
          vehicleId: vehicleIds.toString(),
          driverId: driverIds.toString(),
          driverName: driverName.toString(),
          driverMob: driverMob.toString(),
          driverLicense: driverLicense.toString(),
          vOwnerName: vOwnerName.toString(),
          vRegNumber: vRegNumber.toString(),
          vPucvalidity: vPucvalidity.toString(),
          vFitnessValidity: vFitnessValidity.toString(),
          vInsurance: vInsurance.toString(),
          vModel: vModel.toString(),
          dPhoto: dPhoto.toString(),
          vPhoto: vPhoto.toString(),
          rating: rating!,
          totalComment: comment.toString(),
        ));
        setState(() {});
      } else if (status == false) {
        OverlayLoadingProgress.stop();
      }
      return DriverVehicleList.fromJson(response.body);
    } else {
      throw Exception('Failed to create.');
    }
  }*/
}