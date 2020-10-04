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
      builder: (context, model, child) => new Scaffold(
        extendBody: true,
        appBar: new AppBar(
          title: new Text('MTP live App'),
        ),
        backgroundColor: backgroundColor,
        body: Container(
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: StreamBuilder<User>(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (BuildContext context,
                              AsyncSnapshot<User> asyncSnapshot) {
                            if (asyncSnapshot.hasError) {
                              return Text('Something went wrong happen');
                            }

                            if (!asyncSnapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (asyncSnapshot.connectionState ==
                                ConnectionState.active) {
                              var data = asyncSnapshot.data;
                              print("Watt is in: ${data.uid}");
                              return Text("Full Name: ${data.displayName}");
                            }
                            return Text('loading...');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc('userId')
                              .collection('posts')
                              .orderBy('create_at')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.connectionState ==
                                ConnectionState.active) {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index) => PostListItem());
                            } else if (snapshot.hasError) {
                              return Text('Snapshot has Error: ${snapshot.error}');
                            } else {
                              return Text('Fetching...');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
