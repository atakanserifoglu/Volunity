import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/auth/authentication_provider.dart';

class CustomSignIn extends ConsumerWidget {
  static const String id = 'CustomSignIn Screen';
  const CustomSignIn({super.key});
  final String _clientId2 = '44510558997-bgrtg2qdqt2upf36dfa4t681gl2737k9.apps.googleusercontent.com';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return Scaffold(
            body: Theme(
                data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(15),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    )),
                child: SafeArea(
                    child: Column(children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset('Assets/logo.png'),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: SignInScreen(
                          providers: [EmailAuthProvider(), GoogleProvider(clientId: _clientId2)],
                        ),
                      ))
                ]))),
          );
        }
        // Render your application if authenticated
        return  MainScreen();
      },
    );
  }
}

class CustomRegister extends ConsumerWidget {
  static const String id = 'CustomRegister Screen';
  const CustomRegister({super.key});
  final String _clientId = '44510558997-bgrtg2qdqt2upf36dfa4t681gl2737k9.apps.googleusercontent.com';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Theme(
              data: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  )),
              child: SafeArea(
                  child: Column(children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset('Assets/logo.png'),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: RegisterScreen(
                        actions: [
                          AuthStateChangeAction((context, state) {
                            userDetailSetToFirabe(ref);
                            Navigator.of(context).pushReplacementNamed(MainScreen.id);
                          })
                        ],
                        providers: [EmailAuthProvider(), GoogleProvider(clientId: _clientId)],
                      ),
                    ))
              ]))),
        );
      },
    );
  }

  Future<void> userDetailSetToFirabe(ref) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set({'isOrganizer': ref.watch(authNotifierProvider).isOrganizer});
  }
  //   final _formkey = GlobalKey<FormState>();
  //   final _auth = FirebaseAuth.instance;

  //   _dbUserRole (String email, String password, String isOrganizer) async {

  //   final _db =FirebaseFirestore.instance.collection('users');
  //   final _user = FirebaseAuth.instance.currentUser;
  //   if (_formkey.currentState!.validate()) {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((value) => {postDetailsToFirestore(isOrganizer)})
  //         .catchError((e) {});
  //   }
  // }
  //   postDetailsToFirestore(String isOrganizer) async {
  //   var user = _auth.currentUser;
  //   CollectionReference ref = FirebaseFirestore.instance.collection('users');
  //   ref.doc(user!.uid).set({'isOrganizer': isOrganizer});
  // }
  // await _db.doc(_user!.uid).set({'isOrganizer' : ref.watch(authNotifierProvider).isOrganizer});

  // Burası user için olması gereken özellikleri firestore a push eder, Usage: 'isOrganizer' ile eşleşen firestore collection a datayı eşleştirmek.
}
