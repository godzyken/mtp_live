import 'package:mtp_live/core/models/post.dart';
import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/api.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: Api()),
  Provider.value(value: DatabaseService())
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthService>(
    update: (context, api, authService) => AuthService(api: api),
  ),
  ProxyProvider<AuthService, DatabaseService>(
    update: (context, authService, databaseService) => DatabaseService(authService: authService),
    updateShouldNotify: (previous, current) => true,
  )
];
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    lazy: false,
    create: (context) =>
    Provider.of<AuthService>(context, listen: false).currentUser,
  ),
  StreamProvider<Post>(
    lazy: false,
    create: (context) =>
    Provider.of<AuthService>(context, listen: false).currentUser,
  ),
];