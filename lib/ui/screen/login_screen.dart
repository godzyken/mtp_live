import 'package:flutter/material.dart';
import 'package:mtp_live/core/app.dart';
import 'package:mtp_live/core/services/auth.dart';
import 'package:mtp_live/ui/screen/model.dart';

class LoginScreen extends BaseModel {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
        appBar: AppBar(title: Text('Hello World!')),
        body: Body()));
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user;

  @override
  void initState() {
    super.initState();
    authService.signOut();
  }

  void click() {
    authService.signInGoogle().then((user) => {
      this.user = user,
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MtpLive()))
    });
  }

  Widget googleLoginButton() {
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}