import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget googleLoginButton() {

  return OutlineButton(
    onPressed:() {},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
    splashColor: Colors.grey,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(image: AssetImage('assets/images/google_logo.png'), height: 35),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(color: Colors.grey, fontSize: 25),
            ),
          )
        ],
      ),
    ),
  );
}
