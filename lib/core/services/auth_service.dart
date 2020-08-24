import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',

    ]
  );
  final _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String name;
  String email;
  String imageUrl;

  Stream<auth.User> user;
  Stream<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService() {
    user = user.asBroadcastStream();

    profile = user.switchMap((auth.User u) {
      if (u != null) {
        return _db
            .collection('users')
            .doc(u.uid)
            .snapshots()
            .map((snap) => snap.data());
      } else {
        return Stream.value({});
      }
    });
  }


  Future<auth.User> googleSignIn() async {
    loading.add(true);
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      googleAuth.accessToken,
      googleAuth.idToken,
    );

    var provider = auth.GoogleAuthProvider();
    provider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    provider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

//    auth.FirebaseAuth.languageCode = 'pt';
// To apply the default browser preference instead of explicitly setting it.
// firebase.auth().useDeviceLanguage();


    final  auth.UserCredential result = await _auth.signInWithCredential(credential);

    _auth.signInWithPopup(provider).then((result) => {
        var token = {result.credential.accessToken, result.credential.idToken};
        var user = result.user;
    }).catchError((error) => {
        var errorCode = error.code;
        var errorMessage = error.message;
        // The email of the user's account used.
        var email = error.email;
        // The firebase.auth.AuthCredential type that was used.
        var credential = error.credential;
    });

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final auth.User currentUser = _auth.currentUser;
    assert(currentUser.uid == user.uid);

    updateUserData(user);
    print('signed in ' + user.displayName);

    loading.add(false);
    return user;
  }

//  Future<String> signInWithGoogle() async {
//    final GoogleSignInAccount googleSignInAccount = await _googleSignin.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication =
//    await googleSignInAccount.authentication;
//
//    final OAuthCredential credential = GoogleAuthProvider.credential(
//      googleSignInAuthentication.idToken,
//      googleSignInAuthentication.accessToken
//    );
//
//    final auth.GoogleAuthCredential authResult = await _auth.signInWithCredential(credential);
//    final user = authResult.user;
//
//    // Checking if email and name is null
//    assert(user.email != null);
//    assert(user.displayName != null);
//    assert(user.photoURL != null);
//
//    name = user.displayName;
//    email = user.email;
//    imageUrl = user.photoURL;
//
//    // Only taking the first part of the name, i.e., First Name
//    if (name.contains(" ")) {
//      name = name.substring(0, name.indexOf(" "));
//    }
//
//    assert(!user.isAnonymous);
//    assert(await user.getIdToken() != null);
//
//    final currentUser = _auth.currentUser;
//    assert(user.uid == currentUser.uid);
//
//    return 'signInWithGoogle succeeded: $user';
//  }

  void updateUserData(auth.User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
      },
    );
  }

  void signOut() {
    _auth.signOut();
  }

//  Future<void> linkGoogleAndTwitter() async {
//    // Trigger the Google Authentication flow.
////    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
////    // Obtain the auth details from the request.
////    final GoogleSignInAuthentication googleAuth =
////        await googleUser.authentication;
//    String accessToken;
//    String idToken;
//
//    // Create a new credential.
//
//    final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(accessToken: accessToken, idToken: idToken );
//    // Sign in to Firebase with the Google [UserCredential].
//    final UserCredential googleUserCredential =
//        await FirebaseAuth.instance.signInWithCredential(googleCredential);
//    if (googleUserCredential != null) {
//      var user = googleUserCredential.user;
//      print('ok dem !! $googleUserCredential');
//      return user;
//    }
//
//
//
//    // Now let's link Twitter to the currently signed in account.
//    // Create a [TwitterLogin] instance.
////    final TwitterLogin twitterLogin = new TwitteérLogin(
////        consumerKey: consumerKey, consumerSecret: consumerSecret);
////    // Trigger the sign-in flow.
////    final TwitterLoginResult loginResult = await twitterLogin.authorize();
////    // Get the logged in session.
////    final TwitterSession twitterSession = loginResult.session;
////    // Create a [AuthCredential] from the access token.
////    final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
////        accessToken: twitterSession.token, secret: twitterSession.secret);
////    // Link the Twitter account to the Google account.
////    await googleUserCredential.user.linkWithCredential(twitterAuthCredential);
//    return googleUserCredential.user;
//  }
//
//  Future<void> authenticationState() async {
//    FirebaseAuth auth = FirebaseAuth.instance;
//    if (auth.currentUser != null) {
//      print(auth.currentUser.uid);
//      return true;
//    } else {
//      print('error');
//    }
//    return false;
//  }
//
//  Future<void> reauthenticateUser() async {
//    String email = 'isgodzy@gmail.com';
//    String password = 'dattebayo';
//
//    EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//
//    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);
//  }
//
//  Future<void> signinCredential() async {
//    FirebaseAuth auth =  FirebaseAuth.instance;
//    UserCredential userCredential = await auth.signInAnonymously();
//    if (userCredential != null) {
//      print(userCredential.user.uid);
//      return userCredential.user.uid;
//    }
//    return userCredential;
//  }
//
//  Future<void> registration() async {
//    try {
//      UserCredential user = await FirebaseAuth.instance
//          .createUserWithEmailAndPassword(
//              email: "isgodzy@gmail.com", password: "dattebayo");
//    } on FirebaseAuthException catch (e) {
//      if (e.code == 'weak-password') {
//        print('The password provided is too weak.');
//      } else if (e.code == 'email-already-in-use') {
//        print('The account already exists for that email.');
//      }
//    } catch (e) {
//      print(e.toString());
//    }
//  }
//

//  Future<void> signInWithEmailPassword() async {
//    try {
//      final user = _auth.createUserWithEmailAndPassword(email: email, password: password);
//    } on auth.FirebaseAuthException catch (e) {
//      if (e.code == 'user-not-found') {
//        print('No user found for that email.');
//      } else if (e.code == 'wrong-password') {
//        print('Wrong password provided for that $user.');
//      }
//    }
//  }

  Future<void> deleteUser() async {
    try {
      await _auth.currentUser.delete();
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<void> verifyUserEmail() async {
    auth.User user = _auth.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<void> sendEmailVerification() async {
    auth.User user = _auth.currentUser;

    String code = 'xxxxxxx';

    try {
      await _auth.checkActionCode(code);
      await _auth.applyActionCode(code);

      _auth.currentUser.reload();
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      } else {
        return user;
      }
    }
  }
}

final AuthService authService = AuthService();
