
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final int uid;
  final String diplayName;
  final String email;
  final String photoUrl;

  User({this.uid, this.diplayName, this.email, this.photoUrl});

  factory User.fromMap(Map data) {
    return User(
      diplayName: data['displayName'] ?? '',
      uid : data['uid'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

}

class Profile {
  User user = User();
  final String idProfile;
  final String displayName;
  final String email;

  Profile({this.idProfile, this.displayName, this.email});

  factory Profile.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Profile(
      idProfile: doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? ''
    );
  }

}