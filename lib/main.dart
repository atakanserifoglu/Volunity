import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/main_screen.dart';
import 'package:volunity/Screens/profileScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/firebase_options.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      routes: {
        MainScreen.id: (context) =>  MainScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        profileScreen.id: (context) =>  profileScreen(),
      },
      home: const SplashPage(),
    );
  }
}
