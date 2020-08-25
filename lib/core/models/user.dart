
import 'package:cloud_firestore/cloud_firestore.dart' as db;
import 'package:firebase_auth/firebase_auth.dart' as auth;


final _firebaseAuth = auth.FirebaseAuth.instance;
final _doc = db.FirebaseFirestore.instance;


class User {
  User({this.uid, this.diplayName, this.email, this.photoUrl});

  final int uid;
  final String diplayName;
  final String email;
  final String photoUrl;

  factory User.fromMap(Map data) {
    return User(
      diplayName: data['displayName'] ?? '',
      uid : data['uid'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  User _userFromFirebase(user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid,
        photoUrl: user.photoURL,
        diplayName: user.displayName,
        email: user.email);
  }

  Stream<User> get onAuthChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

//  Stream<db> get onAuthDocChanged {
//    return ;
//  }

}

class Profile {
  User user = User();
  final String idProfile;
  final String displayName;
  final String email;

  Profile({this.idProfile, this.displayName, this.email});

  factory Profile.fromFirestore(_doc) {

    Map data = _doc.data();

    return Profile(
      idProfile: _doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? ''
    );
  }

}