import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mtp_live/core/models/comment.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/auth_services.dart';


class FirestorePath {
  static String post(String uid, String postId) => 'users/$uid/posts/$postId';
  static String posts(String uid) => 'users/$uid/posts';
  static String comment(String uid, String postId, String commentId) => 'users/$uid/posts/$postId/comment/$commentId';
}

class DatabaseService {
  DatabaseService({AuthService authService});

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(User user) {
    return _db
        .collection('users')
        .doc(user.uid)
        .set({'displayName': 'DogMan ${user.uid.substring(0, 5)}'});
  }

  Future<void> addPost(User user, dynamic post) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('posts')
        .add(post);
  }

  Future<void> removePost(User user, String id) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('posts')
        .doc(id)
        .delete();
  }

  Future<void> setComment(User user, dynamic comment) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('comments')
        .add(comment);
  }

  Future<void> deleteComment(User user, String id) {
    return _db
        .collection('users')
        .doc(user.uid)
        .collection('comments')
        .doc(id)
        .delete();
  }

  Stream<List<Comment>> commentsStream(User user) {
    var ref  = _db
        .collection('users')
        .doc(user.uid)
        .collection('comments');
    return ref.snapshots().map(
            (list) => list.docs.map(
                    (doc) => Comment.fromSnapshot(doc)).toList());
  }

  Future<User> getUserOnFirebase(String id) async {
    var snap = await _db.collection('users').doc('id').get();

    return User.fromMap(snap.data());
  }

  // Get stream on single doc
  Stream<User> streamUser(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => User.fromMap(snap.data()));
  }

  // Query a subcollection
  Stream<List<Post>> streamPosts(User user) {
    var ref = _db.collection('users').doc(user.uid).collection('posts');

    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => Post.fromSnapshot(doc)).toList());
  }
}

/*
class FirestoreDatabase  extends ChangeNotifier {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  // CRUD operations
Future<void> setPost(Post post){}
Future<void> deletePost(Post post){}
Future<Post> postStream({@required String postId}){}
Future<List<Post>> postsStream(){}
Future<void> setComment(Comment comment){}
Future<void> deleteComment(Comment comment){}
Future<List<Comment>> commentsStream(Post post){}
}

*/
