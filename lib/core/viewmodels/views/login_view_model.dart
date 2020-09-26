import 'package:flutter/widgets.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/core/services/dialog_service.dart';
import 'package:mtp_live/core/services/navigation_service.dart';
import 'package:mtp_live/core/viewmodels/views/base_model.dart';


class LoginViewModel extends BaseModel {
  final AuthService _authenticationService;
  DialogService _dialogService;
  NavigationService _navigationService;

  LoginViewModel({
    @required AuthService authenticationService,
  }) : _authenticationService = authenticationService;

  String errorMessage;
  String _email;
  String _password;

  Future login({String email, String password}) async {
    setState(true);
    var result = await _authenticationService.loginWithEmail(
      email: _email,
      password: _password,
    );

    if (result is bool) {
      if (result) {
        setState(true);
        _navigationService.navigateTo('home');
      } else {
        setState(false);
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
      setState(false);
    }
  }

  Future createUserWithCredential(String email, String password) async {
    setState(true);

    // Not null
    if (email == null) {
      errorMessage = 'Email field must be non empty!';
      setState(false);
      return false;
    }

    var success = await _authenticationService.createUser();

    // Handle potential error here too.

    setState(false);
    return success;
  }

  Future ghostMode() async {
    setState(true);

    var success = await _authenticationService.createUserAnonymous();
    if (success != null) {
      setState(true);
      print('Success to connect the ghost Mode... $success');
      return success;
    } else {
      setState(false);
      print('Error to connect $success');
      return null;
    }
  }

  Future signInWithGoogle() async {
    setState(true);

    var success = await _authenticationService.signInWithGoogle();

    // Handle potential error here too.

    setState(false);
    return success;
  }
}
