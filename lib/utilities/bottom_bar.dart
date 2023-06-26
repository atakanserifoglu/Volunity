import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/add_event_screen.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profileScreenMobile.dart';
import 'package:volunity/riverpod/bottom_bar_riverpod.dart';
import 'constants.dart';


class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});
  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  // void _onItemTapped(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });

  //   if(selectedIndex == 1){
  //       Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
  //   }
  //   else if(selectedIndex ==2){
  //       Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
  //       Navigator.push(context, MaterialPageRoute(builder: (context) {
  //         return const ProfileScreen();
  //       }));
  //   }
  //   else if(selectedIndex ==0){
  //     Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return  AddEvent();
  //     }));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(bottomNavigationBarProvider);
    var read = ref.read(bottomNavigationBarProvider);
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
      selectedItemColor: Colors.amber[800],
      onTap: (index) => read.setCurrentIndex(index),
    );
  }
}
