import 'package:flutter/material.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profileScreen.dart';
import 'constants.dart';

class bottomBar extends StatefulWidget {
  bottomBar({required this.selectedInt});
  final int selectedInt;
  @override
  _bottomBarState createState() => _bottomBarState(selectedIndex: selectedInt);
}

class _bottomBarState extends State<bottomBar> {
  _bottomBarState({required this.selectedIndex});

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
    if(selectedIndex == 0){
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
    }
    else if(selectedIndex ==1){
        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return profileScreen();
        }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
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
