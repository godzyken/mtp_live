import 'package:flutter/material.dart';
import 'package:mtp_live/ui/models/signin_screen_model.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SigninScreenModel(),
    );
  }
}