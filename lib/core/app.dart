import 'package:flutter/material.dart';
import 'package:mtp_live/core/providers/provider_setup.dart';
import 'package:mtp_live/ui/router.dart';
import 'package:provider/provider.dart';

import 'constants/app_constants.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Test Flutter app',
        theme:ThemeData(primarySwatch: Colors.blue),
        initialRoute: RoutePaths.Landing,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}