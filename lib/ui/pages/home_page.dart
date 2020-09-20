import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/viewmodels/views/home_model.dart';
import 'package:mtp_live/ui/pages/base_page.dart';
import 'package:mtp_live/ui/shared/app_colors.dart';
import 'package:mtp_live/ui/widgets/postlist_item.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('MTP live App'),
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Wrap(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return PostListItem();
                  } else {
                    return Text('fetching');
                  }
                },
              ),
              StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong happen');
                  }

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.connectionState == ConnectionState.active) {
                    var data = snapshot.data;
                    print("Watt is in: ${data.uid}");
                    return Text("Full Name: ${data.displayName}");
                  }
                  return Text('loading...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
