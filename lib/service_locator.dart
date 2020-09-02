import 'package:get_it/get_it.dart';
import 'package:mtp_live/core/services/auth.dart';
import 'package:mtp_live/ui/models/error_model.dart';
import 'package:mtp_live/ui/models/home_model.dart';
import 'package:mtp_live/ui/models/success_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<Auth>(() => authService);

  // register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<ErrorModel>(() => ErrorModel());
  locator.registerFactory<SuccessModel>(() => SuccessModel());
}