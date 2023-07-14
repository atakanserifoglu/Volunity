import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/add_event_screen.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profile_screen.dart';
import 'package:volunity/riverpod/bottom_bar_riverpod.dart';
import 'constants.dart';

class BottomOrgBar extends ConsumerStatefulWidget {
  const BottomOrgBar({super.key});
  @override
  ConsumerState<BottomOrgBar> createState() => _BottomBarOrgState();
}

class _BottomBarOrgState extends ConsumerState<BottomOrgBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(bottomNavigationBarOrgProvider);
    var read = ref.read(bottomNavigationBarOrgProvider);
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Event',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: watch.currentIndex,
      onTap: (index) => read.setCurrentIndex(index),
    );
  }
}

class BottomPersBar extends ConsumerStatefulWidget {
  const BottomPersBar({super.key});
  @override
  ConsumerState<BottomPersBar> createState() => _BottomBarPersState();
}

class _BottomBarPersState extends ConsumerState<BottomPersBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(bottomNavigationBarPersProvider);
    var read = ref.read(bottomNavigationBarPersProvider);
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note_rounded),
          label: 'Etkinliklerin',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: watch.currentIndex,
      onTap: (index) => read.setCurrentIndex(index),
    );
  }
}
