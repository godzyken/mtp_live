
import 'package:mtp_live/core/models/comment.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';

class Api {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

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
}