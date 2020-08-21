import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:rxdart/rxdart.dart';


class AuthService {
  final GoogleSignin _googleSignin = GoogleSignIn();
  final _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Observable<auth.User> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = Observable(_auth.authStateChanges());

    profile = user.switchMap((auth.User u) {
      if (u != null) {
        return _db.collection('users').doc(u.uid).snapshots().map((snap) => snap.data);
      } else {
        return Observable.just({});
      }
    });
  }

  Future<auth.User> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignin.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    auth.User user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    updateUserData(user);
    print('signed in ' + user.displayName);

    loading.add(false);
    return user;

  }

  void updateUserData(auth.User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    },);
  }

  void signOut() {
    _auth.signOut();
  }

  Future<void> linkGoogleAndTwitter() async {
    // Trigger the Google Authentication flow.
//    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//    // Obtain the auth details from the request.
//    final GoogleSignInAuthentication googleAuth =
//        await googleUser.authentication;
    String accessToken;
    String idToken;

    // Create a new credential.

    final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(accessToken: accessToken, idToken: idToken );
    // Sign in to Firebase with the Google [UserCredential].
    final UserCredential googleUserCredential =
        await FirebaseAuth.instance.signInWithCredential(googleCredential);
    if (googleUserCredential != null) {
      var user = googleUserCredential.user;
      print('ok dem !! $googleUserCredential');
      return user;
    }



    // Now let's link Twitter to the currently signed in account.
    // Create a [TwitterLogin] instance.
//    final TwitterLogin twitterLogin = new TwitteérLogin(
//        consumerKey: consumerKey, consumerSecret: consumerSecret);
//    // Trigger the sign-in flow.
//    final TwitterLoginResult loginResult = await twitterLogin.authorize();
//    // Get the logged in session.
//    final TwitterSession twitterSession = loginResult.session;
//    // Create a [AuthCredential] from the access token.
//    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
//        accessToken: twitterSession.token, secret: twitterSession.secret);
//    // Link the Twitter account to the Google account.
//    await googleUserCredential.user.linkWithCredential(twitterAuthCredential);
    return googleUserCredential.user;
  }

  Future<void> authenticationState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser.uid);
      return true;
    } else {
      print('error');
    }
    return false;
  }

  Future<void> reauthenticateUser() async {
    String email = 'isgodzy@gmail.com';
    String password = 'dattebayo';

    EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
  }

  Future<void> signinCredential() async {
    FirebaseAuth auth =  FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInAnonymously();
    if (userCredential != null) {
      print(userCredential.user.uid);
      return userCredential.user.uid;
    }
    return userCredential;
  }

  Future<void> registration() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "isgodzy@gmail.com", password: "dattebayo");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithEmailPassword() async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "isgodzy@gmail.com", password: "dattebayo");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<void> verifyUserEmail() async {
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String code = 'xxxxxxx';

    try {
      await auth.checkActionCode(code);
      await auth.applyActionCode(code);

      auth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }
  }

//  Future<void> signOut() async {
//    await FirebaseAuth.instance.signOut();
//  }

}

final AuthService authService = AuthService();