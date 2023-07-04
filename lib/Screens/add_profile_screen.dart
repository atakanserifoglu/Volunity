import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/main_scaffold.dart';
import 'package:volunity/riverpod/add_profile_screen_riverpod.dart';

import '../auth/utils.dart';
import '../utilities/constants.dart';

class AddProfileScreen extends ConsumerStatefulWidget {
  const AddProfileScreen({super.key});
  static const String id = 'Add Profile Screen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends ConsumerState<AddProfileScreen> {
  final TextEditingController _fieldTextController = TextEditingController();
  final TextEditingController _fieldTextController2 = TextEditingController();
  final TextEditingController _fieldTextController3 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fieldTextController.dispose();
    _fieldTextController2.dispose();
    _fieldTextController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    var watch = ref.watch(addProfileScreenProvider);
    var read = ref.read(addProfileScreenProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: deviceHeight / 10, horizontal: deviceWidth / 10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Profilini oluştur",
                      style: kButtonTextStyle.copyWith(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _fieldTextController,
                    decoration: const InputDecoration(
                        labelText: "İsim ve Soyisim",
                        hintText: "İsim ve Soyisim",
                        border: OutlineInputBorder(borderSide: BorderSide(color: kButtonColor))),
                  ),
                  SizedBox(
                    height: deviceHeight / 30,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _fieldTextController2,
                    maxLines: null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: deviceHeight / 20, horizontal: deviceWidth / 30),
                        labelText: "Hakkında",
                        hintText: "Kendinden biraz bahset",
                        border: const OutlineInputBorder(borderSide: BorderSide(color: kButtonColor))),
                  ),
                  SizedBox(
                    height: deviceHeight / 30,
                  ),
                  DropdownButton(
                    hint: const Text('Bir il seçin'),
                    value: watch.city,
                    onChanged: (newValue) {
                      read.changedCity(newValue.toString());
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: deviceHeight / 30,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _fieldTextController3,
                    decoration: const InputDecoration(
                        labelText: "İlgi alanların",
                        border: OutlineInputBorder(borderSide: BorderSide(color: kButtonColor))),
                  ),
                  SizedBox(
                    height: deviceHeight / 30,
                  ),
                  Align(
                    child: SizedBox(
                      width: deviceWidth * 0.7,
                      height: deviceHeight / 15,
                      child: ElevatedButton(
                        onPressed: () {
                          userProfileSetToFirebase(watch);
                          Navigator.pushNamedAndRemoveUntil(context, MainScaffold.id,(route)=> false);
                        },
                        child: Text('Profili Tamamla',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.teal[800], fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userProfileSetToFirebase(AddProfileScreenNotifier watch) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      final data = {
        "name": _fieldTextController.text.trim(),
        "about": _fieldTextController2.text.trim(),
        "currentCity": watch.city,
        "interest": _fieldTextController3.text.trim(),
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
