import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Dashboard',
    home: Scaffold(appBar: AppBar(title: Text('Dashboard'),),
    body: Center(child: Text('Hello'),),),);
  }
}
