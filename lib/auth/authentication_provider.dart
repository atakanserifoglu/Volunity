// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AuthenticationNotifier extends ChangeNotifier {

  bool isOrganizer = false;

  void organizer() {
    isOrganizer= true;
    notifyListeners();
  }
  void notOrganizer() {
    isOrganizer= false;
    notifyListeners();
  }
}

final authNotifierProvider = ChangeNotifierProvider<AuthenticationNotifier>((ref) {
  return AuthenticationNotifier();
});
