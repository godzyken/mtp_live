import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;

  const PostListItem({Key key, this.post, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: post,
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
                  Text(
                    "${this.post.id}",
                    style:
                        TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
                  ),
                  Text(this.post.body, maxLines: 2, overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Something went wrong happen');
        } else {
          return Text('Found no Data...');
        }
      },
    );
  }
}
