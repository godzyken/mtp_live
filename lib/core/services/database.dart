import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mtp_live/core/models/post.dart';

final databaseReference = FirebaseFirestore.instance;

class DatabaseService {
  CollectionReference savePost(Post post) {
    var id = databaseReference.collection('posts/');
    id.add(post.toJson());
    return id;
  }

  void updatePost(Post post, CollectionReference id) {
    id.add(post.toJson());
  }

  Future<List<Post>> getAllPosts() async {
    CollectionReference snapShot = databaseReference.collection('posts/');
    List<Post> posts = [];
    if (snapShot.doc() != null) {
      snapShot.where((key, value) {
        Post post = createPost(value);
        post.setId(databaseReference.collection('posts/' + key));
      });
    }
    return posts;
  }
}
