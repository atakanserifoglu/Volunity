import 'package:flutter/material.dart';

class DefaultTheme {
  const DefaultTheme(this.context);

  final BuildContext context;
  ThemeData get theme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        // Default theme
          );
}
