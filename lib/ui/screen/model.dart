import 'package:flutter/cupertino.dart';
import 'package:mtp_live/core/constants/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;
  bool isDisposed = false;

  void setState(ViewState viewState) {
    _state = viewState;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}