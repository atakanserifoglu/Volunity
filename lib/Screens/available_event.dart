import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/show_event_screen.dart';

import '../riverpod/profile_screen_riverpod.dart';
import '../utilities/constants.dart';

class AvailableEvent extends ConsumerStatefulWidget {
  const AvailableEvent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvailableEventState();
}

class _AvailableEventState extends ConsumerState<AvailableEvent> {
  List _favorite = ["a"];
  List _apply = ["a"];

  Stream<QuerySnapshot> getFavEvents() =>
      FirebaseFirestore.instance.collection("orgs").where("eventID", whereIn: _favorite).snapshots();
  Stream<QuerySnapshot> getApplyEvent() =>
      FirebaseFirestore.instance.collection("orgs").where("eventID", whereIn: _apply).snapshots();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final watch = ref.watch(profileScreenProvider);
    _favorite = watch.eventsFav;
    _apply = watch.eventsApply;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Favori etkinliklerin",
                  style: kTitleTextStyle.copyWith(fontSize: 20),
                )),
          ),
          StreamBuilder(
            stream: getFavEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: deviceHeight / 4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final document = snapshot.data!.docs[index];
                              final docData = document.data() as Map<String, dynamic>;
                              return getEvents(docData, deviceHeight);
                            }),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(child: Text("Data is null!"));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Başvurulanlar",
                  style: kTitleTextStyle.copyWith(fontSize: 20),
                )),
          ),
          StreamBuilder(
            stream: getApplyEvent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: deviceHeight / 4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final document = snapshot.data!.docs[index];
                              final docData = document.data() as Map<String, dynamic>;
                              return getEvents(docData, deviceHeight);
                            }),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(child: Text("Data is null!"));
              }
            },
          ),
        ],
      ),
    );
  }

  GestureDetector getEvents(Map<String, dynamic> docData, double deviceHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowEventScreen(
              name: docData['name'].toString(),
              details: docData['details'].toString(),
              image: docData['photoName'].toString(),
              date: formatString(docData['date'].toDate().toString()),
              location: docData['location'].toString(),
              eventID: 'eventID',
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(children: [
          Column(
            children: [
              Ink.image(
                image: NetworkImage(docData['photoName'].toString()),
                height: 120,
                width: 250,
                fit: BoxFit.cover,
              ),
              SizedBox(height: deviceHeight / 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(docData['name'].toString(), style: kTitleTextStyle),
                    Text(
                      docData['details'].toString(),
                      style: kTitleTextStyle,
                    ),
                    Text(
                      formatString(docData['date'].toDate().toString()),
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  String formatString(String text) {
    int indexOfSpace = text.indexOf(' ', 0);
    return text.substring(0, indexOfSpace);
  }
}
