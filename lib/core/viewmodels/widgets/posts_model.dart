import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/services/database.dart';

import '../base_model.dart';

class PostsModel extends BaseModel {
  DatabaseService _db;

  PostsModel({
    @required DatabaseService db,
  }) : _db = db;

  Stream<List<Post>> posts;

  Future getPosts(User userId) async {
    setState(true);
    posts = _db.streamPosts(userId);
    setState(false);
  }
}