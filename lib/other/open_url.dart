import 'package:url_launcher/url_launcher.dart';
export 'package:url_launcher/url_launcher.dart';

toolsUrlLauncher(String url,{LaunchMode launchMode = LaunchMode.externalApplication}) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    launchUrl(Uri.parse(url),mode: launchMode);
  }else{
    print('can not launch');
  }
}

/*

https:<URL>  https://flutter.dev
mailto:<email address>?subject=<subject>&body=<body>  mailto:smith@example.org?subject=News&body=New%20plugin
tel:<phone number>  tel:+989155604020
sms:<phone number>  sms:5550101234
file:<path>  file:/home


*/


/*
ios
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>sms</string>
  <string>tel</string>
</array>


anddoid
<queries>
  <!-- If your app checks for SMS support -->
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="sms" />
  </intent>
  <!-- If your app checks for call support -->
  <intent>
    <action android:name="android.intent.action.VIEW" />
    <data android:scheme="tel" />
  </intent>
</queries>
*/