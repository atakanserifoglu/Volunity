import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class DefaultTheme {
  const DefaultTheme(this.context);

  final BuildContext context;
  ThemeData get theme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor:kThemeDarkColor,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Color.fromARGB(255, 156, 202, 175),
          showUnselectedLabels: false,
          backgroundColor: Color(0xFFecf4f3),
          //unselectedIconTheme: IconThemeData(color: Colors.black)
        ),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(218, 234, 234, 234),
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            //focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            ),
      );
}
