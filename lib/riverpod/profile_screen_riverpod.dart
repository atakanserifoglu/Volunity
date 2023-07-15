import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/services/user_profile_model.dart';

class ProfileScreenNotifier extends ChangeNotifier {
  String city = "None";
  List interest = [""];
  bool isOrganizer = false;
  UserProfileModel? user = UserProfileModel();
  List? eventsIdList = [];
  List? eventsFav = [];
  List? eventsApply = [];

  void setEventApplyIDS(value) {
    eventsApply = value;
    notifyListeners();
  }

  void setEventFavIDS(value) {
    eventsFav = value;
    notifyListeners();
  }

  void setEventIDS(value) {
    eventsIdList = value;
    notifyListeners();
  }

  void setOrganizer(value) {
    isOrganizer = value;
    notifyListeners();
  }

  void getUser(UserProfileModel? user2) {
    user = user2;
    notifyListeners();
  }

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
