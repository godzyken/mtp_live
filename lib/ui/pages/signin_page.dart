import 'package:flutter/material.dart';
import 'package:mtp_live/core/viewmodels/views/signin_view_model.dart';
import 'package:mtp_live/ui/pages/base_page.dart';
import 'package:mtp_live/ui/shared/app_colors.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final verifyPasswordController = TextEditingController();
  final displayNameController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BasePage<SignInViewModel>(
      model: SignInViewModel(authenticationService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Sign'),
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).accentColor),
                ),
              ),
              //TODO: VALIDATOR OF FORM
              TextFormField(
                validator: (value) {
                  if (!value.contains('')) {
                    return "not a valid name";
                  }
                  return null;
                },
                controller: displayNameController,
                decoration: InputDecoration(
                    labelText: "DisplayName", hintText: "DisplayName  DisplayName"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              TextFormField(
                controller: roleController,
                decoration: InputDecoration(
                    labelText: "Role", hintText: "Role"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                validator: (value) {
                  if (!value.contains('@')) {
                    return "not a valid email address";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email", hintText: "Email  Email Address"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", hintText: "Email  Password"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              TextFormField(
                controller: verifyPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Verify Password", hintText: "Verify  Password"),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                onPressed: () {
                  if (emailController.text.contains('@')) {
                    // TODO: registration action
                  }
                },
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Already have an account"),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}