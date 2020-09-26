import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth_services.dart';

class GoogleLoginButton extends StatefulWidget {
  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  bool _isProcessing = false;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () async {
        setState(() {
          _isProcessing = true;
        });
        var connected = await authService.signInWithGoogle();
        if (connected != null) {
          Navigator.pushNamed(context, 'home');
        } else {
          print('Error: $connected');
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      splashColor: Colors.grey,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
                image: AssetImage('assets/images/google_logo.png'), height: 35),
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
}