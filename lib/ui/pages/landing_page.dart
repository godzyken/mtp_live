import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/ui/pages/home_page.dart';
import 'package:mtp_live/ui/pages/login_page.dart';

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialisation = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialisation,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if(snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final User user = snapshot.data;

                if (user == null) {
                  return LoginPage();
                } else {
                  return MyHomePage();
                }
              }
              else {
                return Scaffold(
                  body: Center(
                    child: Text('Check di log...'),
                  ),
                );
              }
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text('Connecting to di app my nigga...'),
          ),
        );

      },
    );
  }
}