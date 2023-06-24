import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class profileScreenMobile extends StatefulWidget {
  const profileScreenMobile({Key? key}) : super(key: key);

  @override
  State<profileScreenMobile> createState() => _profileScreenMobileState();
}

class _profileScreenMobileState extends State<profileScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  "Your Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Container(
                  width: 150,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.5),
                      image: DecorationImage(
                          image: AssetImage(
                        "Assets/profileAvatar.jpg",
                      )),
                      shape: BoxShape.circle),
                ),
                Text(
                  "Name Surname",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.5,
                  ),
                ),
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(17.5),
                  child: Container(
                    width: 175,
                    height: 40,
                    color: Colors.orange,
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
                      color: Colors.orange,
                      size: 35,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Text(
                      "examplemail7@gmail.com",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.5,
                      ),
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
                      color: Colors.orange,
                      size: 35,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Your Address",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.5,
                      ),
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
                    color: Colors.orange,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
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
                SizedBox(height: 30),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22.5),
                  child: Container(
                    width: 300,
                    height: 60,
                    color: Colors.orange,
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
                      onPressed: () => print("manage events pressed"),
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
