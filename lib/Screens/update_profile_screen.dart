import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/Screens/main_scaffold.dart';
import 'package:volunity/Screens/splash_page.dart';
import 'package:volunity/riverpod/profile_screen_riverpod.dart';
import 'package:volunity/services/user_profile_model.dart';

import '../auth/utils.dart';
import '../utilities/constants.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String id = 'Update Profile Screen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  final TextEditingController _fieldTextController = TextEditingController();
  final TextEditingController _fieldTextController2 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;
  bool selected6 = false;
  bool selected7 = false;
  bool selected8 = false;
  bool selected9 = false;
  String a = "";
  String b = "";
  Set selectedInterest = {};
  List selectedInterestData = [];
  UserProfileModel? user = UserProfileModel();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fieldTextController.dispose();
    _fieldTextController2.dispose();
    super.dispose();
  }

  Future<void> oldNameAndAbout() async {
    _fieldTextController.text = user!.name.toString();
    _fieldTextController2.text = user!.about.toString();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    var watch = ref.watch(profileScreenProvider);
    var read = ref.read(profileScreenProvider);
    user = watch.user;
    selectedInterest = user!.interest!.toSet();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(deviceWidth / 10, deviceHeight / 30, deviceWidth / 10, deviceHeight / 30),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Profilini düzenle",
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
                          decoration: InputDecoration(
                            labelText: user!.name ?? "İsim ve Soyisim",
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight / 30,
                        ),
                        TextFormField(
                          //validator: (value) => value != null ? "Hakkında kısmı boş olamaz" : null,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _fieldTextController2,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: deviceHeight / 20, horizontal: deviceWidth / 30),
                            labelText: user!.about ?? "Hakkında",
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight / 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Yaşadığın şehir: ",
                              style: kCardTitleStyle.copyWith(fontSize: 16),
                            ),
                            DropdownButton(
                              hint: Text(user?.currentCity ?? ""),
                              value: user?.currentCity,
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
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight / 50,
                        ),
                        Text(
                          "İlgi alanların:",
                          style: kCardTitleStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: deviceHeight / 100,
                        ),
                        Column(
                          children: [
                            Wrap(
                              spacing: 5.0, // Chip'ler arasındaki boşluk
                              runSpacing: 1.0, // Yeni satıra geçtiğinde chip'ler arasındaki boşluk
                              children: [
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Eğitim'),
                                  selected: selectedInterest.contains('Egitim') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected1 = selected;
                                      if (selected) {
                                        selectedInterest.add('Egitim');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Egitim"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Sağlık'),
                                  selected: selectedInterest.contains('Sağlik') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected2 = selected;
                                      if (selected) {
                                        selectedInterest.add('Sağlik');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Sağlik"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Çevre ve Doğa'),
                                  selected: selectedInterest.contains('Cevre') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected3 = selected;
                                      if (selected) {
                                        selectedInterest.add('Cevre');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Cevre"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Hayvan hakları'),
                                  selected: selectedInterest.contains('HayvanHaklari') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected4 = selected;
                                      if (selected) {
                                        selectedInterest.add('HayvanHaklari');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("HayvanHaklari"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Toplumsal duyarlılık'),
                                  selected: selectedInterest.contains('ToplumsalDuyarlilik') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected5 = selected;
                                      if (selected) {
                                        selectedInterest.add('ToplumsalDuyarlilik');
                                      } else {
                                        selectedInterest
                                            .removeWhere((element) => element.contains("ToplumsalDuyarlilik"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Sanat ve Kültür'),
                                  selected: selectedInterest.contains('Sanat') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected6 = selected;
                                      if (selected) {
                                        selectedInterest.add('Sanat');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Sanat"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Teknoloji'),
                                  selected: selectedInterest.contains('Teknoloji') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected7 = selected;
                                      if (selected) {
                                        selectedInterest.add('Teknoloji');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Teknoloji"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('Spor ve Rekreasyon'),
                                  selected: selectedInterest.contains('Spor') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected8 = selected;
                                      if (selected) {
                                        selectedInterest.add('Spor');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("Spor"));
                                      }
                                    });
                                  },
                                ),
                                ChoiceChip(
                                  backgroundColor: kButtonColor,
                                  shape: const StadiumBorder(side: BorderSide.none),
                                  label: const Text('İnsan hakları'),
                                  selected: selectedInterest.contains('İnsanHaklari') ? true : false,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selected9 = selected;
                                      if (selected) {
                                        selectedInterest.add('İnsanHaklari');
                                      } else {
                                        selectedInterest.removeWhere((element) => element.contains("İnsanHaklari"));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight / 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: deviceWidth * 0.7,
                    height: deviceHeight / 15,
                    child: ElevatedButton(
                      onPressed: () {
                        userProfileSetToFirebase(watch);
                        Navigator.pushNamedAndRemoveUntil(context, MainScaffold.id, (route) => false);
                      },
                      child: Text('Profili Tamamla',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.teal[800], fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userProfileSetToFirebase(ProfileScreenNotifier watch) async {
    final isValid = formKey.currentState!.validate();
    selectedInterestData = selectedInterest.toList();
    if (!isValid) {
      return;
    }
    try {
      final data = {
        "name": _fieldTextController.text.trim(),
        "about": _fieldTextController2.text.trim(),
        "currentCity": watch.city,
        "interest": selectedInterestData,
      };
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
