import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid;
String name;
String email;
String imageUrl;
Stream<auth.User> user;

abstract class AuthBase {
  Stream<User> get onAuthChanged;

  Future<User> createUserWithEmailAndPassword(String email, String password);

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> currentUser();

  Future<User> updateUser(String displayName, String photoURL);

  Future<void> signInGoogle();

  Future<void> signOut();

  Future<bool> saveData();
}

class Auth implements AuthBase {
  final _firebaseAuth = auth.FirebaseAuth.instance;


  User _userFromFirebase(user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid,
        photoUrl: user.photoURL,
        displayName: user.displayName,
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

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> updateUser(String displayName, String photoURL) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<User> signInGoogle() async {
    final googleSignIn = GoogleSignIn(
      scopes: [
        'profile',
        'email',
        'openid',
      ]
    );
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
        final user = result.user;
        // Checking if email and name is null

        assert(user.uid != null);
        assert(user.email != null);
        assert(user.displayName != null);
        assert(user.photoURL != null);

        uid = user.uid;
        name = user.displayName;
        email = user.email;
        imageUrl = user.photoURL;

        if (name.contains(" ")) {
          name = name.substring(0, name.indexOf(" "));
        }

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final auth.User currentUser = _firebaseAuth.currentUser;
        assert(currentUser.uid == user.uid);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', true);

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

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('auth', false);

    uid = null;
    name = null;
    email = null;
    imageUrl = null;

    print("User signed out of Google account");
  }

  @override
  Future<bool> saveData() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

}

final Auth authService = Auth();