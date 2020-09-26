import 'package:flutter/widgets.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/core/viewmodels/views/base_model.dart';

class SignInViewModel extends BaseModel {
  final AuthService _authService;

  SignInViewModel({
    @required AuthService authenticationService
}) : _authService = authenticationService;

  String errorMessage;
  String _email;
  String _password;
  String _displayName;
  String _role;

  Future signIn({String email, String password, String displayName}) async {
    setState(true);
    var userCreate = await _authService.createUser();
    if (userCreate) {
      setState(true);
      return await _authService.signUpWithEmail(email: _email, password: _password, displayName: _displayName, role: _role);
    } else {
      setState(false);
      return null;
    }

  }
}