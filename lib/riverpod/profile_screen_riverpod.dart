import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenNotifier extends ChangeNotifier {
  String city = "None";
  List interest = [];

  void addInterest(value) {
    interest = value;
    notifyListeners();
  }

  void changedCity(String value) {
    city = value;
    notifyListeners();
  }
}

final profileScreenProvider = ChangeNotifierProvider<ProfileScreenNotifier>((ref) {
  return ProfileScreenNotifier();
});
