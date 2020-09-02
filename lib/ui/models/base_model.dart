import 'package:mtp_live/core/constants/view_state.dart';
import 'package:scoped/scoped.dart';

export 'package:mtp_live/core/constants/view_state.dart';
export 'package:scoped/scoped.dart';

class BaseModel extends Scope {
  ViewState _state;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;

    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}