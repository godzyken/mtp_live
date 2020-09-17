import 'package:flutter/widgets.dart';
import 'package:mtp_live/core/models/comment.dart';
import 'package:mtp_live/core/services/api.dart';

import '../views/base_model.dart';

class CommentsModel extends BaseModel {
  Api _api;

  CommentsModel({
    @required Api api,
  }) : _api = api;

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setState(true);
    comments = await _api.getCommentsForPost(postId);
    setState(false);
  }

  @override
  void dispose() {
    print('I have been disposed!!');
    super.dispose();
  }
}