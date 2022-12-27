import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AwsSignedApi {
  Future<http.Response?> awsUpload(String imagePath) async {
    final response = await http.post(
      Uri.parse(
          'https://w7rplf4xbj.execute-api.ap-south-1.amazonaws.com/dev/api/getSignedUrlsgb/getSignedURL'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contentType': 'img/jpeg',
        'filePath': '/register/$imagePath',
      }),
    );

    if (response.statusCode == 200) {
      bool status = jsonDecode(response.body)['status'];
      var data = jsonDecode(response.body)['data'];
      Get.snackbar("Message", "Successful");
      print(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
    return null;
  }
}
