
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mtp_live/core/models/post.dart';

class Api {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Post path;
  CollectionReference ref;

  Api({this.path}) {
    ref = _db.collection('path');
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.doc(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map data , String id) {
    return ref.doc(id).update(data) ;
  }

  /*
  var client;
  Future<User> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$endpoint/users/$userId');


    // Convert and return
    return User.fromSnapshot(response.body);
  }
  Future<List<Post>> getPostsForUser(int userId) async {
    var posts = List<Post>();
    // Get user posts for id
    var response = await client.get('$endpoint/users/$userId/posts/$posts');

    // parse into List
    var parsed = response.body as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromSnapshot(post));
    }

    return posts;
  }
  Future<List<Comment>> getCommentsForPost(int postId) async {
    var comments = List<Comment>();

    // Get comments for post
    var response = await client.get('$endpoint/comments?postId=$postId');

    // Parse into List
    var parsed = response.body as List<dynamic>;

    // Loop and convert each item to a Comment
    for (var comment in parsed) {
      comments.add(Comment.fromSnapshot(comment));
    }

    return comments;
  }
  */
}

class Path {
  static String post(String uid, String postId) => 'users/$uid/posts/$postId';
  static String posts(String uid) => 'users/$uid/posts';
  static String comment(String uid, String postId, String commentId) => 'users/$uid/posts/$postId/comment/$commentId';
}