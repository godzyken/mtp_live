import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';

final databaseReference = FirebaseFirestore.instance;

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference 'PROFILE'
  final CollectionReference profileCollection =
  FirebaseFirestore.instance.collection('profiles');

  Future updateUserData(String firstName, String lastName, String country,
      String city, String imgUrl) async {
    return await profileCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'country': country,
      'city': city,
      'imgUrl': imgUrl,
    });
  }

//profil list from snapshot
  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
        firstName: doc.data()?? '',
        lastName: doc.data() ?? '',
        country: doc.data() ?? '',
        city: doc.data() ?? '',
        photoURL: doc.data() ?? '',
        email: doc.data() ?? '',
        idProfile: doc.id ?? '',
      );
    }).toList();
  }

//get profiles list
  Stream<List<Profile>> get profiles {
    return profileCollection.snapshots().map(_profileListFromSnapshot);
  }

  //collection reference 'POST'
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
