import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunity/utilities/event_card.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../utilities/constants.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'Main Screen';
  var db = FirebaseFirestore.instance;

  MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen> {
  _MainScreenState();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Stream<QuerySnapshot> getDocuments() {
    return FirebaseFirestore.instance.collection('orgs').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: getDocuments(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return  ListView.builder(
                itemCount: snapshot
                    .data!
                    .docs.
                length ,
                  itemBuilder: (BuildContext context, int index) {
                    final document = snapshot.data!.docs[index];
                    final docData = document!.data() as Map<String, dynamic>;
                return EventCard(
                  eventName: docData['name'].
                  toString() ,
                  eventDetail: docData['details'].toString(),
                  eventDate:formatString (docData['date'].toDate().toString()),
                  photoName: "gs://volunity-f6738.appspot.com/${docData['photoName'].toString()}",
                );
              });
            }
          }),
      bottomNavigationBar: const BottomBar(
        selectedInt: 1,
      ),
    );
  }
}

String formatString(String text){
  int indexOfSpace = text.indexOf(' ', 0);
  return text.substring(0, indexOfSpace);
}