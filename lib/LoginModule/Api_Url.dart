class ApiUrl {
  static var baseUrl = 'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/';
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
  static var socketUrl = 'http://65.1.73.254:8090';
}
