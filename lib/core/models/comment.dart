import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;
  final DocumentReference reference;


  Comment.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['postId'] != null),
        assert(map['email'] != null),
        assert(map['name']),
        assert(map['body']),
        assert(map['id']),
        postId = map['postId'],
        email = map['email'],
        name = map['name'],
        body = map['body'],
        id = map['body'];

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Comment<$postId:$email:$name:$email>";

}