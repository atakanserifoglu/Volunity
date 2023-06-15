import 'package:flutter/material.dart';

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
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            color: kButtonColor,
            child: Center(child: Text('Entry ${entries[index]}',style: kButtonTextStyle,)),
          );
        }
    );
  }
}