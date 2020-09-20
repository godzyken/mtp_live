import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  final User user;

  const PostListItem({this.post, this.onTap, this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .doc(post.id)
          .collection(user.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<DocumentChange> snapshot = asyncSnapshot.data.docChanges;
          snapshot.forEach((DocumentChange change) {

          })


          return GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(0.0, 2.0),
                        color: Color.fromARGB(80, 0, 0, 0))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data['displayName'],
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
                  ),
                  Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
