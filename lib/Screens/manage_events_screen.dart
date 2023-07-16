import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/show_event_screen.dart';
import 'package:volunity/riverpod/profile_screen_riverpod.dart';

import '../utilities/constants.dart';
import 'match_screen.dart';

class ManageEventsScreen extends ConsumerStatefulWidget {
  const ManageEventsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends ConsumerState<ManageEventsScreen> {
  List? events = [""];

  Stream<QuerySnapshot> getUserEvents() {
    if (events!.isEmpty) {
      return Stream.empty();
    } else {
      return FirebaseFirestore.instance.collection("orgs").where("eventID", whereIn: events).snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    events = ref.watch(profileScreenProvider).eventsIdList;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Etkinliklerin"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: StreamBuilder(
              stream: getUserEvents(),
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
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MatchScreen(
                                          name: docData['name'].toString(),
                                          details: docData['details'].toString(),
                                          image: docData['photoName'].toString(),
                                          date: formatString(docData['date'].toDate().toString()),
                                          location: docData['location'].toString(),
                                          eventID: docData['eventID'].toString(),
                                          docData: docData,
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
                                                Text('${docData['name'].toString()}', style: kTitleTextStyle),
                                                Text(
                                                  shortenString(docData['details'].toString(), 40),
                                                  style: kTitleTextStyle,
                                                ),
                                                Text(
                                                  '${formatString(docData['date'].toDate().toString())}',
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
                  return const Center(child: Text("Herhangi bir etkinlik oluşturmadınız"));
                }
              },
            ),
          )
        ],
      ),
    );
  }
    String shortenString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + "...";
    }
  }

  String formatString(String text) {
    int indexOfSpace = text.indexOf(' ', 0);
    return text.substring(0, indexOfSpace);
  }
}
