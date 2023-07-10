// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserProfileModel {
final String? uid;
final String? email;
final String? name;
final String? currentCity;
final String? about;
final List? interest;
final bool? isOrganizer;
  UserProfileModel({
    this.uid,
    this.email,
    this.name,
    this.currentCity,
    this.about,
    this.interest,
    this.isOrganizer,
  });
factory UserProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserProfileModel(
      uid: data?['uid'],
      email: data?['email'],
      name: data?['name'],
      currentCity: data?['currentCity'],
      about: data?['about'],
      interest: data?['interest'],
      isOrganizer: data?['isOrganizer']
    );
  }

    Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (currentCity != null) "currentCity": currentCity,
      if (about != null) "about": about,
      if (interest != null) "interest": interest,
      if (isOrganizer != null) "isOrganizer": isOrganizer,
    };
  }
}
