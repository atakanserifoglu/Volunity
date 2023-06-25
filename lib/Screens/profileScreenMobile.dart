import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunity/utilities/constants.dart';

import '../utilities/bottom_bar.dart';
import 'entry_page.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'Profile Screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomBar(selectedInt: 2),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: deviceHeight/50),
                Text(
                  "Your Profile",
                  style: kButtonTextStyle,
                ),
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      image: DecorationImage(
                          image: AssetImage(
                        "Assets/profileAvatar.jpg",
                      )),
                      shape: BoxShape.circle),
                ),
                Text(
                  "Name Surname",
                  style: kButtonTextStyleSmall.copyWith(color: Colors.black),
                ),
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(17.5),
                  child: Container(
                    width: 175,
                    height: 40,
                    color: kButtonColor,
                    child: TextButton(
                      onPressed: () => print("Update pressed"),
                      child: Text(
                        "Update your profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    SizedBox(width: 55),
                    Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                      size: 35,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Text(
                      "examplemail7@gmail.com",
                      style: kButtonTextStyleSmall.copyWith(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    SizedBox(width: 55),
                    Icon(
                      Icons.location_city,
                      color: Colors.black,
                      size: 35,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Your Address",
                      style: kButtonTextStyleSmall.copyWith(color: Colors.black, fontSize: 17),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: Container(
                    width: 300,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kButtonColor),
                      icon: Icon(
                        Icons.event,
                        color: Colors.white,
                        size: 27.5,
                      ),
                      label: Text(
                        "Manage Events",
                        style: TextStyle(color: Colors.white, fontSize: 22.5),
                      ),
                      onPressed: () => print("manage events pressed"),
                    ),
                  ),
                ),
                SizedBox(height: deviceHeight/40),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: Container(
                    width: 300,
                    height: 60,

                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 27.5,
                      ),
                      label: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 22.5),
                      ),
                      onPressed: () async =>  {
                    await FirebaseAuth.instance.signOut(),
                    Navigator.of(context).pushReplacementNamed(EntryPage.id),
                    },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
