import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String displayName;
  final String email;
  final String photoURL;
  final String uid;
  final String userRole;
  final DocumentReference reference;

  User({
    this.displayName,
    this.email,
    this.photoURL,
    this.uid,
    this.userRole,
    this.reference});

  User.initial(this.reference)
      : uid = '',
        displayName = '',
        email = '',
        photoURL = '',
        userRole = '';

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['displayName'] != null),
        assert(map['email'] != null),
        assert(map['uid']),
        assert(map['photoURL']),
        assert(map['userRole']),
        displayName = map['displayName'],
        email = map['email'],
        photoURL = map['photoURL'],
        uid = map['uid'],
        userRole = map['userRole'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "User<$displayName:$email:$photoURL:$userRole:$uid>";
}


class Profile {
  User user;
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