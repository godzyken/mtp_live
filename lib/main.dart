import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/app.dart';

FirebaseAnalytics analytics;

void main() {
  analytics = FirebaseAnalytics();
  Crashlytics.instance.enableInDevMode = true; // turn this off after seeing reports in in the console.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MtpLive());
}
