import 'package:mtp_live/core/models/user.dart';
import 'package:mtp_live/core/services/api.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: Api())
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, AuthService>(
    update: (context, api, authService) => AuthService(api: api),
  ),
];
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<User>(
    lazy: false,
    create: (context) =>
    Provider.of<AuthService>(context, listen: false).currentUser,
  ),
];