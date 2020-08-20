import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AppState { initial, authenticated, authenticating, unauthenticated }

class LoginProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  AppState _appState = AppState.initial;

  AppState get appState => _appState;
  User get user => _user;

  LoginProvider.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _appState = AppState.unauthenticated;
      } else {
        _user = firebaseUser;
        _appState = AppState.authenticated;
      }

      notifyListeners();
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      _appState = AppState.authenticating; //set current state to loading state.
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _appState = AppState.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future logout() async {
    await _auth.signOut();
    _appState = AppState.unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}