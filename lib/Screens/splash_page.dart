import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/services/user_profile_model.dart';
import 'package:volunity/utilities/constants.dart';
import 'dart:async';
import '../auth/authentication_provider.dart';
import '../riverpod/profile_screen_riverpod.dart';
import 'main_scaffold.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  String noEventCreated = "Henüz bir event oluşturmadınız";

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      getUserIsOrganizer();
      getUserCurrentCity();
      getUserInterest();
      getUserFavEvents();
      getUserApplyEvents();
    }
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 5,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('Assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  'Volunity',
                  textStyle: kVolunityText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getEventsId() async {
    final docRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey("eventIDS")) {
        for (var element in List.from(data['eventIDS'])) {
          String data = element;
          ref.watch(profileScreenProvider).eventsIdList?.add(data);
        }
      } else {
        print(noEventCreated);
      }
    });
  }

  void getUserIsOrganizer() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        bool isOrg = false;
        isOrg = data["isOrganizer"];
        if (isOrg == true) {
          getEventsId();
        }
        ref.read(profileScreenProvider).setOrganizer(data['isOrganizer']);
      },
    );
  }

  void getUserCurrentCity() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ref.read(profileScreenProvider).changedCity(data['currentCity']);
      },
    );
  }

  void getUserInterest() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ref.read(profileScreenProvider).addInterest(data['interest']);
      },
    );
  }

  void getUserFavEvents() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ref.read(profileScreenProvider).setEventFavIDS(data['favorite']);
      },
    );
  }
  void getUserApplyEvents() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ref.read(profileScreenProvider).setEventApplyIDS(data['apply']);
      },
    );
  }

  startTime() async {
    var dur = const Duration(seconds: 3);
    return Timer(dur, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EntryPage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScaffold()));
      }
    });
  }
}
