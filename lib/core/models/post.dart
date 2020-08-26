import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mtp_live/core/services/database.dart';


class Post {
  String body;
  String author;
  Set usersLiked = {};
  CollectionReference _id;

  Post(this.body, this.author);

  void likePost(User user) {
    if (this.usersLiked.contains(user.uid)) {
      this.usersLiked.remove(user.uid);
    } else {
      this.usersLiked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(CollectionReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'usersLiked': this.usersLiked.toList(),
      'body': this.body
    };
  }

  void updatePost(Post post, CollectionReference id) {
    Post post = Post(body, author);
    post._id = _id;
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  Post post = new Post(attributes['body'], attributes['author']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  return post;
}

Post savePost(record)  {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  try {
    Post post = new Post(attributes['body'], attributes['author']);

    if (post != null) {
     post._id = new DatabaseService().savePost(post);
      return post;
    }
  } catch (e, s) {
    print(s);
  }

  return record;
}
