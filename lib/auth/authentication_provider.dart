

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AuthenticationNotifier extends ChangeNotifier {

  bool isOrganizer =false;

  setOrganizer(){
    isOrganizer=true;
    notifyListeners();
  }
}

final authNotifierProvider = ChangeNotifierProvider<AuthenticationNotifier>((ref) {
  return AuthenticationNotifier();
});