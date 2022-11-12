import 'package:url_launcher/url_launcher.dart';
toolsopenUrl(String url,{LaunchMode launchMode = LaunchMode.externalApplication}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    launchUrl(Uri.parse(url),mode: launchMode);
  }
}


