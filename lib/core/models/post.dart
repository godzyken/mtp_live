import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final int userId;
  final int id;
  final String body;
  final String title;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['userId'] != null),
        assert(map['id'] != null),
        assert(map['title']),
        assert(map['body']),
        userId = map['userId'],
        id = map['id'],
        body = map['body'],
        title = map['title'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Post<$userId:$id:$body:$title>";

}