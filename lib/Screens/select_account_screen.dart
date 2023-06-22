import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../auth/authentication_provider.dart';
import '../auth/authentication_view.dart';
import '../utilities/constants.dart';
import 'main_screen.dart';

class SelectAccount extends ConsumerWidget {
  static const String id = 'Select Type Screen';

  const SelectAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    final deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      //backgroundColor: Colors.grey[400],
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth / 15, vertical: deviceHeight / 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: deviceHeight / 15,
            ),
            const Text(
              "Choose an",
              style: kButtonTextStyle,
            ),
            const Text("account type:", style: kButtonTextStyle),
            SizedBox(
              height: deviceHeight / 20,
            ),
            SizedBox(
              height: deviceHeight / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  style: kButtonStyle,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, CustomRegister.id, (route) => false);
                  },
                  child: const Text(
                    'Personal',
                    style: kButtonTextStyleSmall,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight / 45,
            ),
            SizedBox(
              height: deviceHeight / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  style: kButtonStyle,
                  onPressed: () {
                    ref.read(authNotifierProvider).setOrganizer();
                    Navigator.pushNamedAndRemoveUntil(context, CustomRegister.id, (route) => false);
                  },
                  child: const Text(
                    'Organization',
                    style: kButtonTextStyleSmall,
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
