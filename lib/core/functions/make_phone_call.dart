import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCallLaunch(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
