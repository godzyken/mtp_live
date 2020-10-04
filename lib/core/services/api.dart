
import 'package:cloud_firestore/cloud_firestore.dart';

class Api {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Path path;
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
}

class Path {
  static String user(String uid) => 'user/$uid';
  static String post(String uid, String postId) => 'users/$uid/posts/$postId';
  static String posts(String uid) => 'users/$uid/posts';
  static String comment(String uid, String postId, String commentId) => 'users/$uid/posts/$postId/comment/$commentId';
}