import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.onAuthChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

        } else {
          
        }
      },
    );
  }
}
