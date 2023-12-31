import 'dart:io';

import 'package:ride_safe_travel/LoginModule/preferences.dart';

class ApiUrl {
 //static var baseUrl = 'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/';
  static var baseUrl = 'https://l8olgbtnbj.execute-api.ap-south-1.amazonaws.com/dev/api/';
  static const googleMapGetDirection="AIzaSyBvMbj8bSuQ3W2e0ILvvby9d3UTjpxD9KI";
  static var awsImagePathUrl = 'https://travelsafe-docs.s3.ap-south-1.amazonaws.com/';
  static var serviceUrl = 'https://24txld2sb5.execute-api.ap-south-1.amazonaws.com/dev/api/';

  static Map<String, String> headerToken = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    'Authorization': Preferences.getLoginToken(Preferences.loginToken),
  };
  static Map<String, String> authHeader  = {
    HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
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
  static var getRideDetails = '${baseUrl}user/getRideData';
  //static var socketUrl = 'http://192.168.1.25:3000';
  static var endRide = '${baseUrl}userRide/endRide';
  static var checkActiveUserRide = '${baseUrl}userRide/checkActiveUserRide';
  static var geolocatelist = '${baseUrl}user/geocodelats';
  static var geolocationDetails = '${baseUrl}user/geocodelocationdetails';
  static var sosReason = '${baseUrl}user/sosReasonMaster';
  static var getserviceType = '${serviceUrl}serviceProvider/serviceTypeMasterList';
  static var sendServiceRequest = '${serviceUrl}serviceProvider/sendServiceRequest';
  static var myFamilyList = '${baseUrl}user/myFamilyList';
  static var userStatus = '${baseUrl}userRide/deleteblockFamilyMember';
  static var coPassengerList = '${baseUrl}userRide/coPassengerList';
  static var addCoPassenger = "${baseUrl}userRide/coPassengerAdd";
  static var getServiceDetails = "${serviceUrl}user/getServiceRideDetails";
  static var completeServiceRequest = "${serviceUrl}serviceProvider/completeServiceRequest";
  static var selectVolunteer = "${baseUrl}user/updatevolunteerStatus";
  static var startRideWithVehicle = "${baseUrl}userRide/userRideAdd";
  static var sendOtp = "${baseUrl}user/sendOtpNew";

  static var userDetails = "${baseUrl}user/userList";
  static var searchServiceRequest = "${serviceUrl}serviceProvider/searchServiceProvider";
  static var serviceRequestList = "${serviceUrl}serviceProvider/serviceRequestList";


  static var videoList = "${baseUrl}user/getVideoList";
  static var videoAttend = "${baseUrl}user/attendSession";
  static var familymemberRideList = "${baseUrl}userRide/familymemberRideList";

  static var getVolunteerRequests = "${baseUrl}user/getVolunteerRequests";
  static var updateVolunteerRequest = "${baseUrl}user/updateVolunteerRequest";
  static var multiMarker = "${baseUrl}userRide/getRideToken";
  static var addFamilyMemberNew = "${baseUrl}user/addFamilyMemberNew";
  static var userFamilyList = "${baseUrl}user/userFamilyList";
  static var updateUserProfile = "${baseUrl}user/updateUserProfile";

  static var acceptRejectApi = "${serviceUrl}serviceProvider/acceptrejectServiceRequest";

  static var eventList = "${serviceUrl}event_management/getEventList";
  static var eventAttend = "${serviceUrl}event_management/viewNAttendEvent";

  static var updateMedicalDetails= "${baseUrl}user/updateMedicalCondition";
  static var getMedicalDetails= "${baseUrl}user/getUserMedicalCondition";
  static var medicalDropDownList = "${serviceUrl}user/getmedicaldropdownlist";
  static var rideDataLive = "https://x8f3h6lx4h.execute-api.ap-south-1.amazonaws.com/dev/api/user/getRideDataLive";




}
