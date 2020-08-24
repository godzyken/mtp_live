import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({this.uid, this.diplayName, this.email, this.photoUrl});

  final String uid;
  final String diplayName;
  final String email;
  final String photoUrl;
}

abstract class AuthBase {
  Stream<User> get onAuthChanged;

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> currentUser();

  Future<User> updateUser(String name);

  Future<void> signOut();

  Future<void> signInGoogle();
}

class Auth implements AuthBase {
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User _userFromFirebase(auth.User user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid,
        photoUrl: user.photoURL,
        diplayName: user.displayName,
        email: user.email);
  }

  @override
  Stream<User> get onAuthChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await account.authentication;
      if (googleSignInAuthentication.accessToken != null &&
          googleSignInAuthentication.idToken != null) {
        final auth.UserCredential result =
            await _firebaseAuth.signInWithCredential(
          auth.GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          ),
        );
        return _userFromFirebase(result.user);
      }

    }
    return null;
  }

  @override
  Future<void> signOut() async {
    final gsignin = GoogleSignIn();
    await gsignin.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> updateUser(String name) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}