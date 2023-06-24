import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../auth/authentication_view.dart';
import '../utilities/constants.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'Profile Screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomBar(selectedInt: 2),
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(EntryPage.id);
        },  child: Text(FirebaseAuth.instance.currentUser!.toString())),
      ),
    );
  }
}
