import 'dart:io';

import 'package:ride_safe_travel/LoginModule/preferences.dart';

class ApiUrl {
  static var baseUrl = 'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/';
  static var awsImagePathUrl = 'https://travelsafe-docs.s3.ap-south-1.amazonaws.com/';

  static Map<String, String> headerToken = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    'Authorization': Preferences.getLoginToken(Preferences.loginToken),
  };

  static var login = '${baseUrl}user/userlogin';
  static var resetPassword = '${baseUrl}user/resetPassword';
  static var verifyOtp = '${baseUrl}user/verifyOtp';
  static var stateApi = '${baseUrl}user/stateMaster';
  static var cityApi = '${baseUrl}user/cityMaster';
  static var vehicleReg = '${baseUrl}vehicles/vehicleReg';
  static var driverVehicleList = '${baseUrl}vehicles/driverVehicleList';
  static var userRideAdd = '${baseUrl}userRide/userRideAdd';
  static var rideDataSave = '${baseUrl}userRide/rideDataSave';
  static var familyMember = '${baseUrl}userRide/familymemberRideList';
  static var getRideCurrentApi = '${baseUrl}userRide/rideDataCurrent';
  static var getMyTripApi = '${baseUrl}userRide/userRideList';
  static var SOS_Push_Notification = '${baseUrl}user/Sospushnotification';
  static var readNotification = '${baseUrl}user/read_notification';
  static var countNotification = '${baseUrl}user/userNotification';
  static var socketUrl = 'http://65.1.73.254:8090';
  //static var socketUrl = 'http://192.168.1.25:3000';
  static var endRide = 'userRide/endRide';
  static var checkActiveUserRide = '${baseUrl}userRide/checkActiveUserRide';
  static var geolocatelist = '${baseUrl}user/geocodelats';
  static var geolocationDetails = '${baseUrl}user/geocodelocationdetails';
  static var sosReason = '${baseUrl}user/sosReasonMaster';
  static var getserviceType = '${baseUrl}serviceProvider/serviceTypeMasterList';
  static var serviceRequest = '${baseUrl}serviceProvider/sendServiceRequest';

}
