import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/auth/authentication_view.dart';
import 'package:volunity/firebase_options.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/theme/default_theme.dart';

import 'Screens/login_screen.dart';
import 'Screens/select_account_screen.dart';
import 'Screens/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        MainScreen.id: (context) =>  const MainScreen(),
        ProfileScreen.id: (context) =>  const ProfileScreen(),
        CustomSignIn.id: (context) => const CustomSignIn(),
        CustomRegister.id : (context) => const CustomRegister(),
        SelectAccount.id : (context) => const SelectAccount(),
        EntryPage.id : (context) => const EntryPage(),
        //sign-in.id :(context) => 
      },
      home: const SplashPage(),
    );
  }
}
