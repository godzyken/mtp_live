import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/core/services/database.dart';

import 'file:///C:/Users/isgod/StudioProjects/mtp_live/lib/core/viewmodels/views/base_model.dart';

class HomeModel extends BaseModel {
  final AuthService _authService;
  final DatabaseService _databaseService;

  HomeModel({
    @required AuthService authService,
    @required DatabaseService databaseService,
  })  : _authService = authService,
        _databaseService = databaseService;

  List<User> userStore;
  User users;
  Stream<List<Post>> _posts;

  Future getUser(String uid) async {
    setState(true);
    users = await _authService.currentUser;
    // TODO: rectifier ce char à bia !!
    userStore =
        (await _databaseService.getUserOnFirebase(uid)) as List<User>;
    if (users != null) {}
  }

  Future getPosts() async {
    setState(true);
    _posts = _databaseService.streamPosts(users) ;
    setState(false);
  }
}
