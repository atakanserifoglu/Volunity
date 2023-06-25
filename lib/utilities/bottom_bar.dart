import 'package:flutter/material.dart';
import 'package:volunity/Screens/add_event_screen.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profileScreenMobile.dart';
import 'constants.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.selectedInt});
  final int selectedInt;
  @override
  State<BottomBar> createState() => _BottomBarState(selectedIndex: selectedInt);
}

class _BottomBarState extends State<BottomBar> {
  _BottomBarState({required this.selectedIndex});

  int selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    if(selectedIndex == 1){
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
    }
    else if(selectedIndex ==2){
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ProfileScreen();
        }));
    }
    else if(selectedIndex ==0){
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return  AddEvent();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
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
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
