import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/app.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e.toString());
  }
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true); // turn this off after seeing reports in in the console.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Provider.debugCheckInvalidValueType = null;
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}
