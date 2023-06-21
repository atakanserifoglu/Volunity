import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profileScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/firebase_options.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/theme/default_theme.dart';

import 'Screens/login_screen.dart';
import 'Screens/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders(
    [EmailAuthProvider(), GoogleProvider(
      clientId: 
      '44510558997-bgrtg2qdqt2upf36dfa4t681gl2737k9.apps.googleusercontent.com')]
  );
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volunity',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),// Defaul theme kullanmak için : DefaultTheme(context).theme,
      routes: {
        MainScreen.id: (context) =>  MainScreen(),
        profileScreen.id: (context) =>  profileScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        registerScreen.id : (context) => registerScreen(),
      },
      home: const SplashPage(),
    );
  }
}
