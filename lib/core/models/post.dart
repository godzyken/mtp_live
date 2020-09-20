import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userId;
  final String id;
  final String body;
  final String title;
  final DocumentReference reference;

  Post({this.userId, this.id, this.body, this.title, this.reference});

  Post.fromMap(Map snapshot, String id)
      : id = id ?? '',
        userId = snapshot['userId'] ?? '',
        body = snapshot['body'] ?? '',
        title = snapshot['title'] ?? 'Espadon padon',
        reference = snapshot['reference'] ?? '';

  toJson() {
    return {
      "body": body,
      "title": title,
      "reference": reference,
      "userId": userId,
    };
  }

  @override
  String toString() => "Post<$userId:$id:$body:$title>";
}
