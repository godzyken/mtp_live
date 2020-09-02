import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/user.dart';

class UserProfile extends StatefulWidget {
  final User user;

  const UserProfile({Key key, this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();

   // authService.profile.listen((event) {_profile.values.contains(authService.user);});
   // authService.loading.listen((state) => setState(() => _loading = state));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.all(20),
        child: Text(_profile.toString()),
      ),
      Text(_loading.toString())
    ]);
  }
}