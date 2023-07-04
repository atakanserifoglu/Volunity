import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/services/user_service.dart';
import 'package:volunity/utilities/event_card.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../utilities/constants.dart';

class MainScreen extends ConsumerStatefulWidget {
  MainScreen({super.key});

  static const String id = 'Main Screen';
  final db = FirebaseFirestore.instance;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  _MainScreenState();

  // kullanıcı yoksa uygulama null dönüp hata veriyor alttaki kod yüzünden, eğer misafir girişi olduysa bunu belirt.
  final Stream _stream =
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  String? city = "";

  Stream<QuerySnapshot> getEvent() =>
      FirebaseFirestore.instance.collection("orgs").where("location", isEqualTo: city).snapshots();

  void getUserCurrentCity() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        city = data['currentCity'];
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Stream<QuerySnapshot> getDocuments() {
  //   return FirebaseFirestore.instance.collection('orgs').snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final currentCity = snapshot.data!;
              return Text(currentCity['currentCity']);
            } else {
              return const Text("Data yok.");
            }
          },
        ),
      ),
      body: StreamBuilder(
          stream: getEvent(),
          builder: (BuildContext context, snapshot) {
            if (city!=null || city=="" ) {
              getUserCurrentCity();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final document = snapshot.data!.docs[index];
                    final docData = document.data() as Map<String, dynamic>;
                    return EventCard(
                      eventName: docData['name'].toString(),
                      eventDetail: docData['details'].toString(),
                      eventDate: formatString(docData['date'].toDate().toString()),
                      photoName: docData['photoName'].toString(),
                    );
                  });
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return const Text("null!!!!");
            }
          } 
          ),
    );
  }
}

String formatString(String text) {
  int indexOfSpace = text.indexOf(' ', 0);
  return text.substring(0, indexOfSpace);
}
