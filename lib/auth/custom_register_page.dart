import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: StreamBuilder<User?>(
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
            return const MainScaffold();
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
                      Expanded(flex: 2, child: Image.asset('Assets/logo.png')),
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Form(
                            key: formKey,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.height * 0.1,
                                    0,
                                    MediaQuery.of(context).size.height * 0.03,
                                  ),
                                  child: Text("Volunity'e Hoş Geldiniz!",
                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height * 0.005,
                                      horizontal: MediaQuery.of(context).size.width / 20),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    // Validator yaparken textformfield küçülüyor error mesajının büyüklüğü yüüznden şimdilik es geçildi.
                                    validator: (email) => email != null && !EmailValidator.validate(email)
                                        ? "Enter a valid email "
                                        : null,
                                    controller: emailCtrl,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: 'Email',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height * 0.005,
                                      horizontal: MediaQuery.of(context).size.width / 20),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    controller: passwordCtrl,
                                    obscureText: true,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value != null && value.length < 6 ? "Enter min. 6 characters " : null,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: 'Şifre',
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height * 0.005,
                                      horizontal: MediaQuery.of(context).size.width / 20),
                                  child: TextFormField(
                                    controller: passwordCtrl2,
                                    obscureText: true,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) => value != null && passwordCtrl.text != passwordCtrl2.text
                                        ? "Şifreler aynı olmak zorundadır."
                                        : null,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: 'Şifreyi tekrar giriniz.',
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: MediaQuery.of(context).size.height * 0.008,
                                      horizontal: MediaQuery.of(context).size.width / 25),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 5,
                                    //height: MediaQuery.of(context).size.height * 0.2,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        signUp(context, ref);
                                      },
                                      child: Text('Kayıt Ol',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.teal[800], fontSize: 18)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
                                  child: Center(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            //backgroundColor: Colors.white,
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
                                  padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.02,
                                  ),
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Bir hesaba Sahip misiniz? ",
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          children: [
                                            TextSpan(
                                                recognizer: TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Navigator.pushNamedAndRemoveUntil(
                                                        context, CustomLoginPage.id, (route) => false);
                                                  },
                                                text: 'Giriş yap',
                                                style: const TextStyle(decoration: TextDecoration.underline))
                                          ]),
                                    ),
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
      ),
    );
  }

  signInWithGoogle(ref) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      userDetailSetToFirebase(ref);

      return await FirebaseAuth.instance.signInWithCredential(credential);
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
