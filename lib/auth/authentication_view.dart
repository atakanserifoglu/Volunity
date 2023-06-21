import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/profileScreen.dart';

import '../Screens/main_screen.dart';
import 'authentication_provider.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider = StateNotifierProvider<AuthenticationNotifier, AuthenticationState>((ref) {
    return AuthenticationNotifier();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // LoginView coming from firebase ui
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
        child: FirebaseUIActions(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              // Sayfalar ile eşleştimeler yapılacak
              // if (!state.user!.emailVerified) {
              //   Navigator.pushNamed(context, '/verify-email');
              // } else {
              //   Navigator.pushReplacementNamed(context, '/profile');
              // }
            }),
            AuthStateChangeAction<UserCreated>((context, state) {
               // Kayıt olunduktan sonra hangi sayfaya push atılcak
               // aynı eposta adresinde exp atmalı yoksa uyg çöküyor.
                 if (!state.credential.user!.emailVerified) {
                   Navigator.pushNamed(context, profileScreen.id);
                 } else {
                   Navigator.pushReplacementNamed(context, MainScreen.id);
                 }
              }),
          ],
          child: SafeArea(
            child: Column(
              children: [
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
                    child: LoginView(
                        action: AuthAction.signIn,
                        footerBuilder: (context, action) {
                          return TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                            ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, MainScreen.id);
                              },
                              child: const Text("Continue as guest",
                              style: TextStyle( color: Colors.white),
                              ));
                        },
                        providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
