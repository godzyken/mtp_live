import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart' as current;
import 'package:mtp_live/core/services/database.dart';
import 'package:mtp_live/core/viewmodels/views/home_model.dart';
import 'package:mtp_live/ui/pages/base_page.dart';
import 'package:mtp_live/ui/shared/app_colors.dart';
import 'package:mtp_live/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeModel>(
      model: HomeModel(
          authService: Provider.of(context),
          databaseService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('MTP live App'),
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: <Widget>[
              StreamProvider<List<Post>>.value(
                value: db.streamPosts(model.users),
                child: PostListItem(),
              ),
              StreamBuilder<current.User>(
                stream: db.streamUser(model.users.uid),
                builder: (context, snapshot) {
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
/*

final user = Provider.of<User>(context);
    return MultiProvider(
      providers: providers,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Welcome ${user.displayName}',
                style: headerStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Here are all your posts', style: subHeaderStyle),
            ),
            UIHelper.verticalSpaceSmall,
            Expanded(child: Container(),)
          ],
        ),
      ),
    );

!!
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Post.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.title),
          trailing: Text(record.reference.toString()),
          onTap: () =>
              record.reference.update({'posts': FieldValue.increment(1)}),
        ),
      ),
    );
  }

 */
}
