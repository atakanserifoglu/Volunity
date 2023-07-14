import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/show_event_screen.dart';
import 'package:volunity/riverpod/profile_screen_riverpod.dart';
import 'package:volunity/services/user_service.dart';
import 'package:volunity/utilities/event_card.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../services/user_profile_model.dart';
import '../utilities/constants.dart';

class MainScreen extends ConsumerStatefulWidget {
  MainScreen({super.key});

  static const String id = 'Main Screen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  _MainScreenState();
  String _city = "";
  List _interest = [];

  // kullanıcı yoksa uygulama null dönüp hata veriyor alttaki kod yüzünden, eğer misafir girişi olduysa bunu belirt.
  Stream<QuerySnapshot> getCityEvent() =>
      FirebaseFirestore.instance.collection("orgs").where("location", isEqualTo: _city).snapshots();
  Stream<QuerySnapshot> getInterestEvent() =>
      FirebaseFirestore.instance.collection("orgs").where("interest", arrayContainsAny: _interest).snapshots();

  @override
  void initState() {
    super.initState();
  }

  // Stream<QuerySnapshot> getDocuments() {
  //   return FirebaseFirestore.instance.collection('orgs').snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    final watch = ref.watch(profileScreenProvider);
    _interest = watch.interest;
    _city = watch.city;

    return Scaffold(
      appBar: AppBar(
        title: Text(_city),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Yakınındaki etkinlikler",
                  style: kTitleTextStyle.copyWith(fontSize: 20),
                )),
          ),
          StreamBuilder(
            stream: getCityEvent(),
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
                              return getEventCity(docData, deviceHeight);
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
                  "Önerilenler",
                  style: kTitleTextStyle.copyWith(fontSize: 20),
                )),
          ),
          StreamBuilder(
            stream: getInterestEvent(),
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
                              return getEventInterest(docData, deviceHeight);
                            }),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  GestureDetector getEventInterest(Map<String, dynamic> docData, double deviceHeight) {
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
              eventID: docData['eventID'].toString(),
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
                height: 100,
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

  GestureDetector getEventCity(Map<String, dynamic> docData, double deviceHeight) {
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
              eventID: docData['eventID'].toString(),
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
