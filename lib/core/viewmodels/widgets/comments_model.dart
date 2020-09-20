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

  Future fetchComments(String postId) async {
    setState(true);
    comments = _api.streamDataCollection() as List<Comment>;
    setState(false);
  }

  @override
  void dispose() {
    print('I have been disposed!!');
    super.dispose();
  }
}