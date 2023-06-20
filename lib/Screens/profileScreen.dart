import 'package:flutter/material.dart';
import 'package:volunity/utilities/bottomBar.dart';
import '../utilities/constants.dart';

class profileScreen extends StatefulWidget {
  static const String id = 'Profile Screen';

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: bottomBar(selectedInt: 1),
    );
  }
}
