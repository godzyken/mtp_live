
import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mtp_live/core/constants/app_constants.dart';
import 'package:mtp_live/core/models/post.dart';

import 'api.dart';

class PostsService {
  final StorageReference storageReference = FirebaseStorage().ref().child(RoutePaths.Post);

  Api _api;

  List<Post> posts;

  Uint8List get data => null;

  Future<List<Post>> getPostsForUser() async {
    var result = await _api.getDataCollection();
    posts = result.docs
    .map((doc) => Post.fromMap(doc.data(), doc.id))
    .toList();

    final StorageUploadTask uploadTask = storageReference.putData(data);
    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {

      print('EVENT ${event.type}');
    });

    await uploadTask.onComplete;
    streamSubscription.cancel();

    return posts;
  }
}