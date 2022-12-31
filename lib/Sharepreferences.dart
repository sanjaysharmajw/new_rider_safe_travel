import 'package:shared_preferences/shared_preferences.dart';

class SharePreferences {
  static SharedPreferences? _instance;

  static const String id = 'id';
  static const String image = "image";
  static const String address = 'address';
  static const String dob = "dob";
  static const String gender = "gender";
  static const String age = "age";

  static init() async {
    _instance = await SharedPreferences.getInstance();
    return _instance;
  }

  static Future saveId(String value) async {
    return _instance?.setString(id, value);
  }

  static  getId() {
    return _instance!.getString(id);
  }

  static Future saveAddress(String value) async {
    return _instance?.setString(address, value);
  }

  static  getAddress() {
    return _instance!.getString(address);
  }

  static Future saveImage(String value) async {
    return _instance?.setString(image, value);
  }

  static  getImage() {
    return _instance!.getString(image);
  }

  static Future saveDate(String value) async {
    return _instance?.setString(dob, value);
  }

  static  getDate() {
    return _instance!.getString(dob);
  }

  static Future saveGender(String value) async {
    return _instance?.setString(gender, value);
  }

  static  getGender() {
    return _instance!.getString(gender);
  }

  static Future saveAge(String value) async {
    return _instance?.setString(age, value);
  }

  static  getAge() {
    return _instance!.getString(age);
  }
}
