import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/Screens/select_account_screen.dart';
import 'package:volunity/utilities/constants.dart';
import 'dart:async';
import 'login_screen.dart';
import 'main_scaffold.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical : MediaQuery.of(context).size.height / 5,),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Volunity',
                  textStyle: kVolunityText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  startTime() async {
    var dur = const Duration(seconds: 3);
    return Timer(dur, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> FirebaseAuth.instance.currentUser == null ? const EntryPage() :  const MainScaffold())); // kullanıcı varsa mainscaffold yoksa entrypage
    });
  }
}