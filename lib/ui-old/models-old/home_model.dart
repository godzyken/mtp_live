import 'package:mtp_live/core/constants/view_state.dart';
import 'package:mtp_live/core/services/auth.dart';

import '../../service_locator.dart';
import 'base_model.dart';


class HomeModel extends BaseModel {
   Auth authService = locator<AuthBase>();

  String title = "HomeModel";

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    title = "Saving Data";
    await authService.saveData();
    title = "Data Saved";
    setState(ViewState.Retrieved);

    return true;
  }

}