import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/select_account_screen.dart';
import 'package:volunity/auth/custom_login_page.dart';
import '../utilities/constants.dart';

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
               Column(
                children: [
                  Text("Volunity",style: kTitleStyle.copyWith(fontSize: 48),),
                  Text("İyilik için birlikte",style: kTitleTextStyle.copyWith(fontSize: 20 , color: Colors.black54, ),textAlign: TextAlign.center, ),
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
                          color: kButtonSecondColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, CustomLoginPage.id,(route)=> false);
                          },
                          child: Text('Giriş Yap',style: kButtonTextStyleSmall.copyWith(color: Colors.grey[800]),),
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
                          color: kThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, SelectAccount.id,(route)=> false);
                          },
                          child: Text('Kayıt Ol',style: kButtonTextStyleSmall.copyWith(color: Colors.grey[800]),),
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
