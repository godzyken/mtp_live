import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth_service.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

        } else {
          
        }
      },
    );
  }
}
