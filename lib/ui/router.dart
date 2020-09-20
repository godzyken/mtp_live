import 'package:flutter/material.dart';
import 'package:mtp_live/core/constants/app_constants.dart';
import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/ui/pages/home_page.dart';
import 'package:mtp_live/ui/pages/landing_page.dart';
import 'package:mtp_live/ui/pages/login_page.dart';
import 'package:mtp_live/ui/pages/post_view.dart';
import 'package:mtp_live/ui/widgets/postlist_item.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Landing:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutePaths.Post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      case RoutePaths.PostListItem:
        return MaterialPageRoute(builder: (_) => PostListItem());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
