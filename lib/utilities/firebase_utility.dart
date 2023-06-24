import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'constants.dart';


class FirebaseUtility {

  static final _fireStore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String eventName = "";
  static DateTime? eventDate;
  static String eventDetail = "";
  static String photoName = "";


  ///read from database and update local static variables
  static Future<bool> refresh() async {
    final docRef = await _fireStore
        .collection("events")
        .doc("singleEvent")
        .get()
        .then((ds) async {
      await insertData(ds);
    });

    return false;
  }


  static Future<bool> insertData(ds) async {
    eventName = ds.data()!['name'];
    eventDetail = ds.data()!['details'];
    eventDate = ds.data()!['date'];
    return true;
  }


  /// Used for event creation
  static void setUserData(
      {required eventName, required eventDetail, required eventDate}) {
    FirebaseUtility.eventName = eventName;
    FirebaseUtility.eventDetail = eventDetail;
    FirebaseUtility.eventDate = eventDate;
  }

  /// Saves every local static variable in this class to database
  static void saveUserData() {
    _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
      'eventName': eventName,
      'eventDetail': eventDetail,
      'eventDate': eventDate,

    }).catchError((error) => {print(error)});

    //TODO handle error
  }


  static void reset() {
    eventName = "";
    eventDetail = "";
  }

}