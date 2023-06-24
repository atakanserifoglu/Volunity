import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'profileScreenMobile.dart';
import 'profileScreenDesktop.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  int mobileWidthLimit = 550;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidthLimit) {
          return profileScreenMobile();
        } else {
          return profileScreenDesktop();
        }
      },
    );
  }
}
