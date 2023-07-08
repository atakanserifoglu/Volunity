import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:volunity/Screens/add_profile_screen.dart';
import 'package:volunity/Screens/login_screen.dart';
import 'package:volunity/Screens/main_scaffold.dart';
import 'package:volunity/auth/authentication_provider.dart';
import 'package:volunity/auth/custom_login_page.dart';
import 'package:volunity/auth/utils.dart';

import '../main.dart';
import '../utilities/constants.dart';

class CustomRegisterPage extends ConsumerWidget {
  static const String id = 'CustomRegister Screen';
  CustomRegisterPage({super.key});
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final passwordCtrl2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.hasError.toString()),
          );
        } else if (snapshot.hasData) {
          //User signed
          return const AddProfileScreen();
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
                    Expanded(flex: 2, child: Image.asset('Assets/volunitylogocrop.png')),
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height / 20, 0,
                                      MediaQuery.of(context).size.height / 100),
                                  child: Text("Kaydol",
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 30)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    MediaQuery.of(context).size.height * 0.03,
                                  ),
                                  child: Text("Volunity'e Hoş Geldiniz!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(fontSize: 20, fontWeight: FontWeight.w300)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.008,
                                    horizontal: MediaQuery.of(context).size.width / 20),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (email) =>
                                      email != null && !EmailValidator.validate(email) ? "Enter a valid email " : null,
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.008,
                                    horizontal: MediaQuery.of(context).size.width / 20),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: passwordCtrl,
                                  obscureText: true,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) =>
                                      value != null && value.length < 6 ? "Enter min. 6 characters " : null,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 50),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    hintText: 'Şifre',
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.008,
                                    horizontal: MediaQuery.of(context).size.width / 20),
                                child: TextFormField(
                                  controller: passwordCtrl2,
                                  obscureText: true,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) => value != null && passwordCtrl.text != passwordCtrl2.text
                                      ? "Şifreler aynı olmak zorundadır."
                                      : null,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 50),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    hintText: 'Şifreyi tekrar giriniz.',
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.008,
                                          horizontal: MediaQuery.of(context).size.width / 25),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 5,
                                        height: MediaQuery.of(context).size.height / 15,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF367465),
                                          ),
                                          onPressed: () {
                                            signUp(context, ref);
                                          },
                                          child: Text('Kaydol',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(color: Colors.white, fontSize: 18)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.height * 0.008,
                                          horizontal: MediaQuery.of(context).size.width / 25),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: MediaQuery.of(context).size.width / 20),
                                                child: Text(
                                                  "Google ile kaydolun",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(color: Colors.teal[800], fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).size.height * 0.01,
                                      ),
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Bir hesaba sahip misiniz? ",
                                              style: Theme.of(context).textTheme.bodyMedium,
                                              children: [
                                                TextSpan(
                                                    recognizer: TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.pushNamedAndRemoveUntil(
                                                            context, CustomLoginPage.id, (route) => false);
                                                      },
                                                    text: 'Giriş yap',
                                                    style: const TextStyle(
                                                        decoration: TextDecoration.underline,
                                                        decorationColor: Color(0xFF367465),
                                                        color: Color(0xFF367465)))
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
        userDetailSetToFirebase(ref);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future<void> userDetailSetToFirebase(ref) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'isOrganizer': ref.watch(authNotifierProvider).isOrganizer, 'email': emailCtrl.text});
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
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
          .createUserWithEmailAndPassword(email: emailCtrl.text.trim(), password: passwordCtrl.text.trim());
      await userDetailSetToFirebase(ref);
    } on FirebaseAuthException catch (e) {
      print("Something is wrong $e");
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(
        context); //Bu kod şimdilik iş görüyor ileride olabilecek hatalar için alttaki kodu kullanabiliriz: MetarielPage e "navigatorKey: navigatorKey" eklenmeli..
    //navigatorKey.currentState!.popUntil((route)=> route.isFirst);
  }
}
