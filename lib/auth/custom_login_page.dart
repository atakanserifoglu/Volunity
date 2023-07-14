import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:volunity/Screens/main_scaffold.dart';
import 'package:volunity/auth/utils.dart';

import '../Screens/select_account_screen.dart';
import '../riverpod/profile_screen_riverpod.dart';
import '../utilities/constants.dart';
import 'authentication_provider.dart';

class CustomLoginPage extends ConsumerStatefulWidget {
  static const String id = 'CustomSignIn Screen';
  const CustomLoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomLoginPage();
}

class _CustomLoginPage extends ConsumerState<CustomLoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var read = ref.read(authNotifierProvider);
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.hasError.toString()),
          );
        } else if (snapshot.hasData) {
          //User signed
          return MainScaffold();
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width / 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.asset(
                          'Assets/volunitylogocrop.png',
                        )),
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height / 40, 0,
                                    MediaQuery.of(context).size.height / 100),
                                child: Text("Giriş yap",
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  MediaQuery.of(context).size.height * 0.03,
                                ),
                                child: Text("Hoş geldiniz!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontSize: 20, fontWeight: FontWeight.w300)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, right: 15, left: 15),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailCtrl,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 50),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    hintText: 'Email',
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.08,
                                child: TextField(
                                  controller: passwordCtrl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 50),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    hintText: 'Şifre',
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 5,
                                height: MediaQuery.of(context).size.height / 15,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kThemeDarkColor,
                                  ),
                                  onPressed: () {
                                    signIn(emailCtrl, passwordCtrl, context);
                                  },
                                  child: Text(
                                    'Giriş yap',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kButtonColor,
                                    ),
                                    onPressed: () {
                                      signInWithGoogle(ref);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'Assets/google_logo.png',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width / 8,
                                          //height: MediaQuery.of(context).size.height * 0.08,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                                          child: Text(
                                            "Google ile giriş yap",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: Colors.teal[800], fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.05,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "Bir hesabınız yok mu? ",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context, SelectAccount.id, (route) => false);
                                              },
                                            text: 'Kaydolun',
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                decoration: TextDecoration.underline,
                                                decorationColor: const Color(0xFF367465),
                                                color: const Color(0xFF367465))),
                                      ]),
                                ),
                              ),
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "veya",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.01,
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "misafir olarak ",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      children: [
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context, MainScaffold.id, (route) => false);
                                              },
                                            text: 'devam edin',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(decoration: TextDecoration.underline)),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  signInWithGoogle(ref) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      if (user.additionalUserInfo!.isNewUser == true) {
        userDetailSetToFirebase(ref, user.user!.email.toString());
      }
      return user;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> userDetailSetToFirebase(ref, String userEmail) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'isOrganizer': ref.watch(authNotifierProvider).isOrganizer, 'email': userEmail});
  }

  Future<void> signIn(TextEditingController emailCtrl, TextEditingController passwordCtrl, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailCtrl.text.trim(), password: passwordCtrl.text.trim());
          getEventsId();
          getUserIsOrganizer();
          getUserCurrentCity();
          getUserInterest();


    } on FirebaseAuthException catch (e) {
      print("Something is wrong $e");
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(
        context); //Bu kod şimdilik iş görüyor ileride olabilecek hatalar için alttaki kodu kullanabiliriz: MetarielPage e "navigatorKey: navigatorKey" eklenmeli..

    //navigatorKey.currentState!.popUntil((route)=> route.isFirst);
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
          ref.watch(profileScreenProvider).eventsIdList.add(data);
        }
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
}
