import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'loginScreen.dart';


class splashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => splashPageState();
}

class splashPageState extends State<splashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 320),
              Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/logo.png'),
                    fit: BoxFit.fill,
                  ),
                  //shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 25),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Volunity',
                    textStyle: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                        //letterSpacing: -1.25,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  startTime() async {
    var dur = new Duration(seconds: 3);
    return new Timer(dur, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginScreen()));
    });
  }
}
