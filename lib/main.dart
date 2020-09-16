import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/app.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;

void main() async {
  analytics = FirebaseAnalytics();
  Crashlytics.instance.enableInDevMode = true; // turn this off after seeing reports in in the console.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}
