import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/ui/auth/login_page.dart';

import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    checkUserAllreadyLogin().then((isLogin) {
      if (isLogin == true) {
        print('Already login');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
      } else {
        print('Not login');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
    });
    return new Scaffold(
      body: Card(
        child: Center(
          child: Text(
            'Loading.....',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
          ),
        ),
      ),
    );
  }

  checkUserAllreadyLogin() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth
        .currentUser
        .emailVerified
        .runtimeType;
  }
}
