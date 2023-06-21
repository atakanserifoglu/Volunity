import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/auth/authentication_view.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/Screens/select_account_screen.dart';
import 'package:volunity/utilities/constants.dart';
import 'dart:async';
import 'login_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
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
            Container(
              height: 150,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Volunity',
                    textStyle: kButtonTextStyle.copyWith(fontWeight: FontWeight.w600)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    var dur = const Duration(seconds: 3);
    return Timer(dur, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> EntryPage()));
    });
  }
}

//Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AuthenticationView()));