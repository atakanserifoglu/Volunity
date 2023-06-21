import 'package:flutter/material.dart';
import 'package:volunity/utilities/bottomBar.dart';
import '../utilities/constants.dart';
import 'main_screen.dart';

class selectAccount extends StatefulWidget {
  static const String id = 'Select Type Screen';

  const selectAccount({super.key});

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<selectAccount> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth / 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(
                  height: deviceHeight / 15,
                ),
            Text(
              "Choose an",
              style: kButtonTextStyle,
            ),
            Text("account type:", style: kButtonTextStyle),
            SizedBox(
              height: deviceHeight / 40,

            ),

            SizedBox(
              height: deviceHeight / 8,
              child: DecoratedBox(
                decoration:  BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                      ),
                child: TextButton(
                  style: kButtonStyle,
                  onPressed: () {},
                  child: Text('Personal',style: kButtonTextStyleSmall,),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight / 45,
            ),
                SizedBox(
                  height: deviceHeight / 8,
                  child: DecoratedBox(
                    decoration:  BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      style: kButtonStyle,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, MainScreen.id,(route)=> false);
                      },
                      child: Text('Organization',style: kButtonTextStyleSmall,),
                    ),
                  ),
                ),
          ])),
    );
  }
}
