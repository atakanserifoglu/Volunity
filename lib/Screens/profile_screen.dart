import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/add_profile_screen.dart';
import 'package:volunity/Screens/update_profile_screen.dart';
import 'package:volunity/riverpod/bottom_bar_riverpod.dart';
import 'package:volunity/services/user_service.dart';
import 'package:volunity/utilities/constants.dart';

import '../riverpod/profile_screen_riverpod.dart';
import '../services/user_profile_model.dart';
import '../utilities/bottom_bar.dart';
import 'entry_page.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String id = 'Profile Screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends ConsumerState<ProfileScreen> {
  UserProfileModel? user = UserProfileModel();
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      getUserModelFromFirebase();
    }
  }

  Future<void> getUserModelFromFirebase() async {
    final docRef = db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).withConverter(
          fromFirestore: UserProfileModel.fromFirestore,
          toFirestore: (UserProfileModel user, _) => user.toFirestore(),
        );
    final docSnap = await docRef.get();
    user = docSnap.data(); // Convert to City object
    ref.read(profileScreenProvider).getUser(user);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight / 50),
              const Text(
                "Profil",
                style: kButtonTextStyle,
              ),
              Container(
                width: deviceWidth / 3,
                height: deviceHeight / 4,
                decoration: BoxDecoration(
                    border: Border.all(color: kThemeDarkColor, width: 2),
                    image: const DecorationImage(
                        image: AssetImage(
                      "Assets/profileAvatar.jpg",
                    )),
                    shape: BoxShape.circle),
              ),
              Text(
                user?.name ?? "İsim yok.",
                style: kButtonTextStyleSmall.copyWith(color: Colors.black),
              ),
              SizedBox(height: deviceHeight / 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(17.5),
                child: Container(
                  width: deviceWidth / 2.5,
                  height: deviceHeight / 20,
                  color: kThemeColor,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, UpdateProfileScreen.id);
                    },
                    child: const Text("Profilini düzenle", style: kTitleTextStyle),
                  ),
                ),
              ),
              SizedBox(height: deviceHeight / 40),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
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
                      SizedBox(
                        width: deviceWidth / 15,
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser?.email ?? "Anonymous",
                        style: kButtonTextStyleSmall.copyWith(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight / 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
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
                      SizedBox(
                        width: deviceWidth / 15,
                      ),
                      Text(
                        "Adresin: ${ref.watch(profileScreenProvider).city.toString()}",
                        style: kButtonTextStyleSmall.copyWith(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: deviceHeight / 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(22.5),
                child: SizedBox(
                  width: deviceWidth / 1.3,
                  height: deviceHeight / 15,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: kButtonColor),
                    icon: const Icon(
                      Icons.event,
                      color: Colors.white,
                      size: 27.5,
                    ),
                    label: const Text(
                      "Manage Events",
                      style: TextStyle(color: Colors.white, fontSize: 22.5),
                    ),
                    onPressed: () => print("manage events pressed"),
                  ),
                ),
              ),
              SizedBox(height: deviceHeight / 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(22.5),
                child: SizedBox(
                  width: deviceWidth / 1.3,
                  height: deviceHeight / 15,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 27.5,
                    ),
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 22.5),
                    ),
                    onPressed: () async => {
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
    );
  }
}
