

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreenNotifier extends ChangeNotifier {
  String city="None";

  void changedCity(String value){
    city=value;
    notifyListeners();
  }

}


final profileScreenProvider = ChangeNotifierProvider<ProfileScreenNotifier>((ref) {
  return ProfileScreenNotifier();
});