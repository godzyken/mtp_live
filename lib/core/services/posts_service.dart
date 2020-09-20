
import 'package:mtp_live/core/models/post.dart';

import 'api.dart';

class PostsService {
  Api _api;

  List<Post> posts;

  Future<List<Post>> getPostsForUser() async {
    var result = await _api.getDataCollection();
    posts = result.docs
    .map((doc) => Post.fromMap(doc.data(), doc.id))
    .toList();

    return posts;
  }
}