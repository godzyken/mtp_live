import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mtp_live/core/models/user.dart' as user;

import 'api.dart';

abstract class AuthBase {
  Future<auth.User> getCurrentUser();

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<auth.User> login({String email, String password});

  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserAnonymous();

  Future<void> signInWithGoogle();

  Future<void> signOutGoogle();
}

class Auth implements AuthBase {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String name;
  String email;
  String password;
  String imageUrl;

  @override
  Future<auth.User> getCurrentUser() async {
    auth.User user = _auth.currentUser;
    return user;
  }

  @override
  Future<auth.User> createUserAnonymous() async {
    try {
      auth.UserCredential userCredential = await _auth.signInAnonymously();
      print('Users: $userCredential');
      auth.User user = userCredential.user;
      return user;
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('Users: $userCredential');
      auth.User user = userCredential.user;

      return user.uid;
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
    } catch (e) {
      print('Error: $e');
    }

    return null;
  }

  @override
  Future<auth.User> login({String email, String password}) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = userCredential.user;
      return user;
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      print('Users: $userCredential');

      auth.User user = userCredential.user;
      return user.uid;
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final auth.UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final user = authResult.user;

      if (user != null) {
        assert(user.email != null);
        assert(user.displayName != null);
        assert(user.photoURL != null);

        // Store the retrieved data
        name = user.displayName;
        email = user.email;
        imageUrl = user.photoURL;

        // Only taking the first part of the name, i.e., First Name
        if (name.contains(" ")) {
          name = name.substring(0, name.indexOf(" "));
        }

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');

        return '$user';
      }
    } on PlatformException catch (e) {
      print(e.code);
      return null;
    }

    return GoogleSignIn != null ?? 'Google Sign in Success';
  }

  @override
  Future<void> signOutGoogle() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }
}

class AuthService {
  static Auth _auth;
  final Api _api;
  var currentUser;
  user.User get _currentUser => currentUser;

  AuthService({Api api}) : _api = api;


  user.User _userFromFirebase(auth.User user) {
    return user == null ? null : currentUser(uid: user.uid);
  }

  Stream<user.User> get onAuthStateChanged {
    return auth.FirebaseAuth.instance.authStateChanges().map((event) => _userFromFirebase(event));
  }

  Future loginWithEmail(
      {@required String email, @required String password}) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email, password);
      var hasUser =  userCredential != null;

      return hasUser;
    } on auth.FirebaseAuthException catch (e) {
      print('Error: $e');
      return e.message;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
    @required String role,
  }) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
        email, password
      );
      return authResult != null;
    } catch (e) {
      return e.message;
    }
  }

  Future createUser({
    String displayName,
    String email,
    String password,
    String photoUrl,
    String uid,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(email, password)
        .then((value) => _auth.login(email: email, password: password));
  }

  Future createUserAnonymous() async {
    final auth.User user = await _auth.createUserAnonymous();
    return user;
  }

  Future loginUser({String email, String password}) async {
    if (password != null) {
      this.currentUser = {'email', email};
      await _auth.login();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }

  Future signInWithGoogle() async {
    await _auth.signInWithGoogle();
  }
}
