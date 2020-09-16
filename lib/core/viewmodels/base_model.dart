import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void setState(bool value) {
    _state = value;
    notifyListeners();
  }
}