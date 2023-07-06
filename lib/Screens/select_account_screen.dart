import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/register_screen.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../auth/authentication_provider.dart';
import '../auth/custom_register_page.dart';
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
      //backgroundColor: Colors.grey[50],
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth / 8, vertical: deviceHeight / 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: deviceHeight / 15,
            ),
            const Text(
              "Volunity’de bireysel hesabınızı oluşturarak gönüllü olabilir veya kurumsal hesap oluşturarak gönüllülerle bir araya gelebilirsiniz.",
              style: TextStyle(
                color: Color(0xFF636363),
                fontSize: 20,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bir hesap türü seçin:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 45,
                  ),
                  SizedBox(
                    height: deviceHeight / 12,
                    width: deviceWidth / 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref.read(authNotifierProvider).notOrganizer();
                          Navigator.pushNamedAndRemoveUntil(context, CustomRegisterPage.id, (route) => false);
                        },
                        child: Text(
                          'Bireysel',
                          style: kButtonTextStyleSmall.copyWith(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 45,
                  ),
                  SizedBox(
                    height: deviceHeight / 12,
                    width: deviceWidth / 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          ref.read(authNotifierProvider).organizer();
                          Navigator.pushNamedAndRemoveUntil(context, CustomRegisterPage.id, (route) => false);
                        },
                        child: Text(
                          'Kurumsal',
                          style: kButtonTextStyleSmall.copyWith(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 45,
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
