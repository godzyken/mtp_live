import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:googleapis/firestore/v1.dart';

import '../models/post.dart';

final databaseReference = db.FirebaseDatabase.instance.reference();

final firestore = FirestoreApi.DatastoreScope;

class DatabaseService {
  Future<User> getUser(String id) async {
    db.DataSnapshot snap = await databaseReference.child('user/').once();
    if(snap != null) {
      CollectionReference user = FirebaseFirestore.instance.collection('users');
      return snap.value(user.id);
    }



  }

  db.DatabaseReference savePost(Post post) {
    var id = databaseReference.child('posts/').push();
    id.set(post.toJson());
    return id;
  }

  void updatePost(Post post, db.DatabaseReference id) {
    id.update(post.toJson());
  }

  Future<List<Post>> getAllPosts() async {
    db.DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
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