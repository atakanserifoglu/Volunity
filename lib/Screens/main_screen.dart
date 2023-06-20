import 'package:flutter/material.dart';
import 'package:volunity/utilities/event_card.dart';
import 'package:volunity/utilities/bottomBar.dart';
import '../utilities/constants.dart';


class MainScreen extends StatefulWidget{
  static const String id = 'Main Screen';

  const MainScreen({super.key});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
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
              child: const Center(child: EventCard()),
            );
          }
      ),
      bottomNavigationBar: bottomBar(selectedInt: 0,),
    );
  }
}
