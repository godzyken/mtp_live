import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

final databaseReference = FirebaseFirestore.instance;
final dataSnapshot = databaseReference.doc('users');

class DatabaseService {
//  Future<User> getUser(String id) async {
//     var snap = dataSnapshot.get().asStream();
//
//    if(snap != null) {
//      CollectionReference user = databaseReference.collection('users');
//
//      return user;
//    }
//
//     Cached and lazily loaded instance of [FirestorePlatform] to avoid
//     creating a [MethodChannelFirestore] when not needed or creating an
//     instance with the default app before a user specifies an app.
//
//
//
//  }

//    savePost(Post post) {
//    var id = databaseReference.collection('posts/').add(data);
//    id.set(post.toJson());
//    return id;
//  }

//  void updatePost(Post post, DatabaseReference id) {
//    id.update(post.toJson());
//  }

//  Future<List<Post>> getAllPosts() async {
//    DataSnapshot dataSnapshot = databaseReference.collection('posts/').doc();
//    List<Post> posts = [];
//    if (dataSnapshot != null) {
//      dataSnapshot.value.forEach((key, value) {
//        Post post = createPost(value);
//        post.setId(databaseReference.collection('posts/' + key));
//        posts.add(post);
//      });
//    }
//    return posts;
//  }
}