import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/services/api.dart';

import '../views/base_model.dart';

class PostsModel extends BaseModel {
  Api _api;

  PostsModel({
    @required Api api,
  }) : _api = api;

  List<Post> posts;

  Future fetchPosts() async {
    var result = await _api.getDataCollection();
    posts = result.docs
        .map((doc) => Post.fromMap(doc.data(), doc.id))
        .toList();
    return posts;
  }

  Stream<QuerySnapshot> fetchPostsAsStream() {
    return _api.streamDataCollection();
  }

  Future getPostById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Post.fromMap(doc.data(), doc.id) ;
  }


  Future removePost(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updatePost(Post data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addPost(Post data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }



}