import 'package:meta/meta.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/database.dart';

import '../views/base_model.dart';

class PostsModel extends BaseModel {
  DatabaseService _db;

  PostsModel({
    @required DatabaseService db,
  }) : _db = db;

  Stream<List<Post>> posts;
  User user;

  Future getPosts() async {
    setState(true);
    posts = _db.streamPosts(user);
    setState(false);
  }
}