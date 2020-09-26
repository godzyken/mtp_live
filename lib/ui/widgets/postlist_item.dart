import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;

  const PostListItem({Key key, this.post, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
                  Text("${post.title}", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
                  ),
                  Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          );

        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}
