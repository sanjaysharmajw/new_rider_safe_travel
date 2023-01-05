import 'package:url_launcher/url_launcher.dart';
class ShareContent{
  static Future<void> shareContent(String content) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: content,
    );
    await launchUrl(launchUri);
  }
}