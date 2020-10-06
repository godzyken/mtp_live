import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/app.dart';
import 'package:provider/provider.dart';

FirebaseAnalytics analytics;


void main() async {
  final FirebaseApp firebaseApp = await Firebase.initializeApp();
  final db = FirebaseFirestore.instanceFor(app: firebaseApp);
  db.collection('users').snapshots(includeMetadataChanges: false);

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true); // turn this off after seeing reports in in the console.
  Firebase.app().setAutomaticDataCollectionEnabled(true); // turn this off after seeing reports in in the console.
  Firebase.app().isAutomaticDataCollectionEnabled; // turn this off after seeing reports in in the console.
  Firebase.app().setAutomaticResourceManagementEnabled(true); // turn this off after seeing reports in in the console.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Provider.debugCheckInvalidValueType = null;
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}