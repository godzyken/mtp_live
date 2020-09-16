import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart' as current;
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/core/services/database.dart';
import 'package:mtp_live/core/viewmodels/base_model.dart';

class HomeModel extends BaseModel {
  final AuthService _authService;
  final DatabaseService _databaseService;

  HomeModel({
    @required AuthService authService,
    @required DatabaseService databaseService,
  })  : _authService = authService,
        _databaseService = databaseService;

  List<current.User> userStore;
  auth.User users;
  Stream<List<Post>> posts;

  Future getUser(String uid) async {
    setState(true);
    users = await _authService.currentUser;
    // TODO: rectifier ce char à bia !!
    userStore =
        (await _databaseService.getUserOnFirebase(uid)) as List<current.User>;
    if (users != null) {}
  }

  Future getPosts(auth.User userId) async {
    setState(true);
    posts = _databaseService.streamPosts(userId);
    setState(false);
  }
}
