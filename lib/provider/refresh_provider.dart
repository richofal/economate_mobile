import 'package:flutter/material.dart';

class RefreshProvider with ChangeNotifier {
  bool _needsRefresh = false;

  bool get needsRefresh => _needsRefresh;

  void setRefresh(bool value) {
    _needsRefresh = value;
    if (value) {
      notifyListeners();
    }
  }
}