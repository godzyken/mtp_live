import 'package:firebase_database/firebase_database.dart';
import 'package:googleapis/firestore/v1.dart';
import 'package:mtp_live/core/models/user.dart';

import '../models/post.dart';

final databaseReference = FirebaseDatabase.instance.reference();

//DatabaseReference savePost(Post post) {
//  var id = databaseReference.child('posts/').push();
//  id.set(post.toJson());
//  return id;
//}
//
//void updatePost(Post post, DatabaseReference id) {
//  id.update(post.toJson());
//}
//
//Future<List<Post>> getAllPosts() async {
//  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
//  List<Post> posts = [];
//  if (dataSnapshot.value != null) {
//    dataSnapshot.value.forEach((key, value) {
//      Post post = createPost(value);
//      post.setId(databaseReference.child('posts/' + key));
//      posts.add(post);
//    });
//  }
//  return posts;
//}
final firestore = FirestoreApi.DatastoreScope;

class DatabaseService {
  Future<User> getUser(String id) async {
    var snap = await databaseReference.
  }

  DatabaseReference savePost(Post post) {
    var id = databaseReference.child('posts/').push();
    id.set(post.toJson());
    return id;
  }

  void updatePost(Post post, DatabaseReference id) {
    id.update(post.toJson());
  }

  Future<List<Post>> getAllPosts() async {
    DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
    List<Post> posts = [];
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        Post post = createPost(value);
        post.setId(databaseReference.child('posts/' + key));
        posts.add(post);
      });
    }
    return posts;
  }
}