import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: auth().onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

        } else {
          
        }
      },
    );
  }
}
