

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProfileScreenNotifier extends ChangeNotifier {
  String city="None";

  void changedCity(String value){
    city=value;
    notifyListeners();
  }

}


final addProfileScreenProvider = ChangeNotifierProvider<AddProfileScreenNotifier>((ref) {
  return AddProfileScreenNotifier();
});