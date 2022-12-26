import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? instance;

  static const String id = 'id';
  static const String firstname = 'firstname';
  static const String lastname = 'lastname';
  static const String emailId = 'emailId';
  static const String mobileNumber = 'mobileNumber';
  static const String aadharCard = 'aadharCard';
  static const String panNumber = 'panNumber';
  static const String userType = 'userType';
  static const String pinCode = 'pinCode';
  static const String userRiderId = 'userRiderId';
  static const String vehicleId = 'vehicleId';
  static const String driverId = 'driverId';
  static const String selectRole = 'selectRole';
  static const String riderIdFromFamilyMem = 'riderIdFromFamilyMem';

  static const String startLat = 'startLat';
  static const String startLng = 'startLng';

  static Future<void> setPreferences() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() {
    return Preferences.instance!.clear();
  }

  static Future<bool> setStartLat( String value) {
    return Preferences.instance!.setString(startLat, value);
  }
  static dynamic getStartLat() {
    return Preferences.instance!.get(startLat);
  }

  static Future<bool> setStartLng( String value) {
    return Preferences.instance!.setString(startLng, value);
  }
  static dynamic getStartLng() {
    return Preferences.instance!.get(startLng);
  }

  static Future<bool> setId(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }
  static Future<bool> setRiderIdFromFamilyMem(String value) {
    return Preferences.instance!.setString(riderIdFromFamilyMem, value);
  }
  static dynamic getRiderIdFromFamilyMem() {
    return Preferences.instance!.get(riderIdFromFamilyMem);
  }

  static Future<bool> setVehicleId(String value) {
    return Preferences.instance!.setString(vehicleId, value);
  }
  static Future<bool> setSelectRole(String value) {
    return Preferences.instance!.setString(selectRole, value);
  }
  static dynamic getSelectRole() {
    return Preferences.instance!.get(selectRole);
  }

  static Future<bool> setDriverId(String value) {
    return Preferences.instance!.setString(driverId, value);
  }

  static dynamic getDriverId() {
    return Preferences.instance!.get(driverId);
  }

  static dynamic getVehicleId(String key) {
    return Preferences.instance!.get(key);
  }

  static Future<bool> setUserRiderId(String value) {
    return Preferences.instance!.setString('userRiderId', value);
  }

  static Future<bool> setFirstName(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setLastName(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setEmailID(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setMobileNumber(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setAadharNumber(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setPanNumber(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setUserType(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setPinCode(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static dynamic getId(String key) {
    return Preferences.instance!.get(key);
  }

  static dynamic getUserRiderId() {
    return Preferences.instance!.get('userRiderId');
  }

  static dynamic getFirstName(String key) {
    return Preferences.instance!.get(key);
  }

  static dynamic getLastName(String key) {
    return Preferences.instance!.get(key);
  }

  static dynamic getEmailId(String key) {
    return Preferences.instance!.get(key);
  }

  static dynamic getMobileNumber(String key) {
    return Preferences.instance?.get(key);
  }

  static dynamic getAdharCard(String key) {
    return Preferences.instance?.get(key);
  }

  static dynamic getPanNumber(String key) {
    return Preferences.instance?.get(key);
  }

  static dynamic getUserType(String key) {
    return Preferences.instance?.get(key);
  }

  static dynamic getPinCode(String key) {
    return Preferences.instance?.get(key);
  }

  ///Singleton factory
  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();
}
