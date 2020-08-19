import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/services/database.dart';
import 'package:mtp_live/ui/auth/login_page.dart';
import 'package:mtp_live/ui/screen/first_screen.dart';
import 'package:mtp_live/ui/screen/postList.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return LoginPage();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MtpLive();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FirstScreen();
      },
    );
  }
}

class MtpLive extends StatefulWidget {
  // This widget is the root of your application.

  MtpLive();

  @override
  _MtpLiveState createState() => _MtpLiveState();
}

class _MtpLiveState extends State<MtpLive> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = new Post();
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllPosts().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello World!')),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWidget(this.newPost)
        ]));
  }
}

class TextInputWidget {
  TextInputWidget(void Function(String text) newPost);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
