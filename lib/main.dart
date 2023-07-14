import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:volunity/Screens/add_event_screen.dart';
import 'package:volunity/Screens/entry_page.dart';
import 'package:volunity/Screens/main_scaffold.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/auth/utils.dart';
import 'package:volunity/firebase_options.dart';
import 'package:volunity/theme/default_theme.dart';

import 'Screens/add_profile_screen.dart';
import 'Screens/select_account_screen.dart';
import 'Screens/show_event_screen.dart';
import 'Screens/splash_page.dart';
import 'Screens/update_profile_screen.dart';
import 'auth/custom_login_page.dart';
import 'auth/custom_register_page.dart';
import 'auth/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'Volunity',
      theme: DefaultTheme(context).theme,
      routes: {
        MainScaffold.id: (context) => MainScaffold(),
        MainScreen.id: (context) => MainScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        CustomLoginPage.id: (context) => CustomLoginPage(),
        CustomRegisterPage.id: (context) => CustomRegisterPage(),
        SelectAccount.id: (context) => const SelectAccount(),
        EntryPage.id: (context) => const EntryPage(),
        AddProfileScreen.id: (context) => const AddProfileScreen(),
        AddEvent.id: (context) => const AddEvent(),
        UpdateProfileScreen.id: (context) => const UpdateProfileScreen(),
        //sign-in.id :(context) =>
      },
      home: const SplashPage(),
    );
  }
}
