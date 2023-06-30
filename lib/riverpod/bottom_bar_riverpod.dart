import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/add_event_screen.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profile_screen.dart';

class BottomNavigationBarRiverpod extends ChangeNotifier {

  int currentIndex = 1;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Widget currentWidget() {
    switch (currentIndex) {
      case 0:
        return const AddEvent();
      case 1:
        return MainScreen();
      case 2:
        return const ProfileScreen();
      default:
        return MainScreen();
    }
  }
}

final bottomNavigationBarProvider = ChangeNotifierProvider<BottomNavigationBarRiverpod>((ref) => BottomNavigationBarRiverpod());
