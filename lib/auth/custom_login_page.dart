import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/login_screen.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/auth/utils.dart';

import '../Screens/select_account_screen.dart';
import '../main.dart';
import '../utilities/constants.dart';
import 'authentication_provider.dart';

class CustomLoginPage extends ConsumerWidget {
  static const String id = 'CustomSignIn Screen';
  CustomLoginPage({super.key});
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(authNotifierProvider);

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
            return MainScreen();
          } else {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 2, child: Image.asset('Assets/logo.png')),
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
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
                                child: Text("Giriş yapma ekranı", style: Theme.of(context).textTheme.bodyLarge),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: TextField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailCtrl,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: 'Email',
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.08,
                                  child: TextField(
                                    controller: passwordCtrl,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(fontSize: 14),
                                      hintText: 'Şifre',
                                      prefixIcon: Icon(Icons.lock),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 5,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      signIn(emailCtrl, passwordCtrl, context);
                                    },
                                    child: const Text('Giriş Yap'),
                                  ),
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
                                              text: 'Kayıt olun',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(decoration: TextDecoration.underline)),
                                        ]),
                                  ),
                                ),
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Ve ya",
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
                                        text: "Misafir olarak ",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                        children: [
                                          TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.pushNamedAndRemoveUntil(
                                                      context, MainScreen.id, (route) => false);
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
      ),
    );
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
    } on FirebaseAuthException catch (e) {
      print("Something is wrong $e");
      Utils.showSnackBar(e.message);
    }
    Navigator.pop(
        context); //Bu kod şimdilik iş görüyor ileride olabilecek hatalar için alttaki kodu kullanabiliriz: MetarielPage e "navigatorKey: navigatorKey" eklenmeli..

    //navigatorKey.currentState!.popUntil((route)=> route.isFirst);
  }
}
