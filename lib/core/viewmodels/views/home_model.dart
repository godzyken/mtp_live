import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/api.dart';
import 'package:mtp_live/core/services/auth_services.dart';

import 'file:///C:/Users/isgod/StudioProjects/mtp_live/lib/core/viewmodels/views/base_model.dart';

class HomeModel extends BaseModel {
  final AuthService _authService;
  final  Api _api;

  HomeModel({
    @required AuthService authService,
    @required Api api,
  })  : _authService = authService,
        _api = api;


  List<User> users;

  Future<User> getUserById(String id) async {
    var doc = await _authService.currentUser(id);
    return User.fromJson(doc.data().id);
  }

  Stream<QuerySnapshot> fetchUsersAsStream() {
    return _api.streamDataCollection();
  }


  List<Post> posts;

  Future<Post> getPostById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Post.fromMap(doc.data(), doc.id);
  }


}
