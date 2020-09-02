
import 'package:cloud_firestore/cloud_firestore.dart' as db;
import 'package:firebase_auth/firebase_auth.dart' as auth;


final _firebaseAuth = auth.FirebaseAuth.instance;
final _doc = db.FirebaseFirestore.instance;


class User {
  User({this.uid, this.displayName, this.email, this.photoUrl});

  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;

  factory User.fromMap(Map data) {
    return User(
      displayName: data['displayName'] ?? '',
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
        displayName: user.displayName,
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
  final String firstName;
  final String lastName;
  final String country;
  final String city;
  final String email;
  final String photoURL;

  Profile({
    this.idProfile,
    this.firstName,
    this.lastName,
    this.country,
    this.city,
    this.email,
    this.photoURL,
  });

  factory Profile.fromFirestore(_doc) {

    Map data = _doc.data();

    return Profile(
      idProfile: _doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      photoURL: data['photoURL'] ?? '',
      email: data['email'] ?? ''
    );
  }

}