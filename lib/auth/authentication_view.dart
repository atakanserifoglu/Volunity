

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // LoginView coming from firebase ui
      body: LoginView(action: AuthAction.signIn, providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app)),
    );
  }
}