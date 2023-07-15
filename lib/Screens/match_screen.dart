import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/riverpod/events_riverpod.dart';

import '../riverpod/profile_screen_riverpod.dart';
import '../utilities/constants.dart';

class MatchScreen extends ConsumerStatefulWidget {
  static const String id = 'Match Event Screen';
  const MatchScreen(
      {required this.image,
      required this.name,
      required this.details,
      required this.location,
      required this.date,
      required this.eventID,
      required this.docData,
      super.key});

  final String image;
  final String name;
  final String details;
  final String location;
  final String date;
  final String eventID;
  final docData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreen();
}

class _MatchScreen extends ConsumerState<MatchScreen> {
  List? userIDS = [""];

  Stream<QuerySnapshot> users() =>
      FirebaseFirestore.instance.collection("users").where("userID", whereIn: userIDS).snapshots();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    userIDS = widget.docData["toApplyUserIDS"];
    final watch = ref.watch(profileScreenProvider);
    final read = ref.read(profileScreenProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2), // Gölgenin yönünü ayarlayabilirsiniz
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        height: deviceHeight / 3,
                        widget.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 30,
                  ),
                  Text(widget.name, style: kTitleTextStyle.copyWith(fontSize: 22)),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  Text(
                    widget.details,
                    style: kTitleTextStyle.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  Text(
                    widget.location,
                    style: kTitleTextStyle.copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  Text(
                    (widget.date),
                    style: kTitleTextStyle.copyWith(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Başvuran kullanıcılar: "),
                  Column(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: StreamBuilder(
                          stream: users(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final document = snapshot.data!.docs[index];
                                    final docData = document.data() as Map<String, dynamic>;
                                    return Text(docData["name"]);
                                  });
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
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
