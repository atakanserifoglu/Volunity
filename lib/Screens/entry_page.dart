import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/login_screen.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/Screens/select_account_screen.dart';
import '../auth/authentication_view.dart';
import '../utilities/constants.dart';
import 'main_screen.dart';

class EntryPage extends StatelessWidget {
  static const String id = 'EntryPage Screen';
  const EntryPage({super.key});
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: <Widget>[
    Image.asset("Assets/volunteer_stock.jpg",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    ),
    BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5), // Blur düzeyini ayarlayabilirsiniz
        child: Container(
          color: Colors.black.withOpacity(0.05), // Arka planın görünürlüğünü ayarlayabilirsiniz
        ),
      ),
    SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0).copyWith(top: deviceHeight/16),
          child: Column(
            children: [
              const Column(
                children: [
                  Text("VOLUNITY",style: kTitleStyle,),
                  Text("Lorem ipsum dolor sit amet, consectetur",style: kTitleTextStyle,textAlign: TextAlign.center,),
                ],
              ),
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 25.0).copyWith(top: deviceHeight/1.9),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: deviceHeight / 12,
                      child: DecoratedBox(
                        decoration:  BoxDecoration(
                          color: const Color.fromRGBO(240, 240, 240, 0.95),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          style: kButtonStyle,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, CustomSignIn.id,(route)=> false);
                          },
                          child: Text('Log In',style: kButtonTextStyleSmall.copyWith(color: Colors.black),),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight / 40,
                    ),

                    SizedBox(
                      height: deviceHeight / 12,
                      child: DecoratedBox(
                        decoration:  BoxDecoration(
                          color: kButtonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          style: kButtonStyle,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, SelectAccount.id,(route)=> false);
                          },
                          child: Text('Register',style: kButtonTextStyleSmall.copyWith(color: Colors.black),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
      ]
    );
  }
}