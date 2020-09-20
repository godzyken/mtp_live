import 'package:flutter/material.dart';
import 'package:mtp_live/core/constants/app_constants.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/viewmodels/widgets/posts_model.dart';
import 'package:mtp_live/ui/pages/base_page.dart';
import 'package:mtp_live/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<PostsModel>(context);
    return BasePage<PostsModel>(
        model: productProvider,
        onModelReady: (model) => model.fetchPostsAsStream(),
        builder: (context, model, child) => model.state
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, i) => PostListItem(
                  post: model.posts[i],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.Post,
                      arguments: model.posts[i],
                    );
                  },
                ),
              ));
  }
}
