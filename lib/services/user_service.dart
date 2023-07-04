import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunity/services/user_profile_model.dart';

class UserService {
  String city = "";
  final db=FirebaseFirestore.instance;
  Future<void> getUserModelFromFirebase() async {
    final ref =
        db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).withConverter(
              fromFirestore: UserProfileModel.fromFirestore,
              toFirestore: (UserProfileModel user, _) => user.toFirestore(),
            );

    final docSnap = await ref.get();
    final user = docSnap.data(); // Convert to City object
    if (user != null) {
      print(user);
      city = user.currentCity.toString();
    } else {
      print("No such document.");
    }
  }

  static getUserCurrentCity() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['currentCity'];
      },
    );
  }

  void getEvent(){
    db.collection("orgs").where("capital", isEqualTo: true).get().then(
  (querySnapshot) {
    print("Successfully completed");
    for (var docSnapshot in querySnapshot.docs) {
      print('${docSnapshot.id} => ${docSnapshot.data()}');
    }
  },
  onError: (e) => print("Error completing: $e"),
);
  }
}
