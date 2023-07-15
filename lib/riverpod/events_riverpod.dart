import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsNotifier extends ChangeNotifier {
  List? userIDSforApply = [];
  List? userIDSforMatch = [];

  void setUserIDSforApply(value) {
    userIDSforApply = value;
    notifyListeners();
  }

  void setUserIDSforMatch(value) {
    userIDSforMatch = value;
    notifyListeners();
  }
}

final eventNotifierProvider = ChangeNotifierProvider<EventsNotifier>((ref) {
  return EventsNotifier();
});
