import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/riverpod/events_riverpod.dart';

import '../riverpod/profile_screen_riverpod.dart';
import '../utilities/constants.dart';

class ShowEventScreen extends ConsumerStatefulWidget {
  static const String id = 'Show Event Screen';
  ShowEventScreen(
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
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowEventScreen();
}

class _ShowEventScreen extends ConsumerState<ShowEventScreen> {
  Future<void> setFavToFirebase(String eventId) async {
    Set setData = {};
    List listData = [];
    setData = ref.watch(profileScreenProvider).eventsFav!.toSet();
    List<String> idList = <String>[];
    final _user = FirebaseFirestore.instance.collection("users");
    DocumentSnapshot<Object?> doc = await _user.doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('favorite')) {
      // 'eventIDS' is already available.
      for (var element in List.from(data['favorite'])) {
        String data = element;
        idList.add(data);
      }
    }
    if (idList.contains(eventId)) {
      print("data eşitliği var");
    } else {
      idList.add(eventId);
      setData.add(eventId);
      listData = setData.toList();
      ref.watch(profileScreenProvider).eventsFav = listData;
    }
    _user.doc(FirebaseAuth.instance.currentUser!.uid).update({"favorite": idList});
  }

  Future<void> setApplyToFirebase(String eventId) async {
    Set setData = {};
    List listData = [];
    setData = ref.watch(profileScreenProvider).eventsApply!.toSet();
    List<String> idList = <String>[];
    final _user = FirebaseFirestore.instance.collection("users");
    DocumentSnapshot<Object?> doc = await _user.doc(FirebaseAuth.instance.currentUser!.uid).get();
    final data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('apply')) {
      // 'eventIDS' is already available.
      for (var element in List.from(data['apply'])) {
        String data = element;
        idList.add(data);
      }
    }
    if (idList.contains(eventId)) {
      print("data eşitliği var");
    } else {
      idList.add(eventId);
      setData.add(eventId);
      listData = setData.toList();
      ref.watch(profileScreenProvider).eventsApply = listData;
    }
    _user.doc(FirebaseAuth.instance.currentUser!.uid).update({"apply": idList});
  }

  Future<void> setApplyUserIDSToFirebase(String userApplyIDS, docData, eventId) async {
    Set setData = {};
    List listData = [];
    List<String> idList = <String>[];

    for (var element in List.from(docData['toApplyUserIDS'])) {
      String data = element;
      idList.add(data);
    }

    if (idList.contains(userApplyIDS)) {
      print("data eşitliği var");
    } else {
      idList.add(userApplyIDS);
      setData.add(userApplyIDS);
      listData = setData.toList();
    }
    await FirebaseFirestore.instance.collection("orgs").doc(eventId).update({"toApplyUserIDS": idList});

    //({"toApplyUserIDS": idList})
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

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
                  ElevatedButton(
                      onPressed: () {
                        setApplyToFirebase(widget.eventID);
                        read.eventsApply!.add(widget.eventID);
                        setApplyUserIDSToFirebase(
                            FirebaseAuth.instance.currentUser!.uid, widget.docData, widget.eventID);
                      },
                      child: const Text("Katılma talebinde bulun")),
                  ElevatedButton(
                      onPressed: () {
                        setFavToFirebase(widget.eventID);
                        read.eventsFav!.add(widget.eventID);
                      },
                      child: const Text("Favorilere ekle"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
