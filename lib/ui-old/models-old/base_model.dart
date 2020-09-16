import 'package:flutter/cupertino.dart';
import 'package:mtp_live/core/constants/view_state.dart';

export 'package:mtp_live/core/constants/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;

    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}