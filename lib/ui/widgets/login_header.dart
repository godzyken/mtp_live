import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/ui/shared/text_styles.dart';
import 'package:mtp_live/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';

class LoginHeader extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController controller;
  final String validationMessage;

  LoginHeader({@required this.controller, this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Login', style: headerStyle),
          UIHelper.verticalSpaceMedium,
          Text('Enter ur email', style: subHeaderStyle),
          LoginTextField(controller),
          Text('Enter ur password'),
          PassTextField(controller),
          this.validationMessage != null
              ? Text(validationMessage, style: TextStyle(color: Colors.red))
              : Container()
        ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  LoginTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        onChanged: (value) {
          user.email = value;
          print('Email: $value');
        },
        decoration: InputDecoration(hintText: "Enter Email..."),
        controller: controller,
      ),
    );
  }
}

class PassTextField extends StatelessWidget {
  final TextEditingController controller;

  PassTextField(this.controller);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(
        onChanged: (value) {
          user.password = value;
          print('Password: $value');
        },
        decoration: InputDecoration(hintText: "Enter ur Password..."),
        controller: controller,
      ),
    );
  }
}
