import 'package:flutter/material.dart';
import 'package:volunity/utilities/EventCard.dart';

import '../utilities/constants.dart';

class mainScreen extends StatefulWidget{
  static const String id = 'Main Screen';
  @override
  _mainScreenState createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen>{
  final List<String> entries = <String>['A', 'B', 'C'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(

              child: Center(child: EventCard()),
            );
          }
      ),
    );
  }
}