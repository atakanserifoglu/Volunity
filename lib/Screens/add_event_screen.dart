import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunity/riverpod/add_profile_screen_riverpod.dart';
import 'package:volunity/services/user_profile_model.dart';
import 'package:volunity/services/user_service.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:typed_data';

var uuid = const Uuid();

class AddEvent extends ConsumerStatefulWidget {
  static const String id = 'Add Event Screen';

  const AddEvent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEvent();
}

class _AddEvent extends ConsumerState<AddEvent> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  String? eventName, eventDetails;
  String? city="";
  DateTime eventDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  File? _photo;
  String? photoName = "";
  Uint8List? _selectedFileBytes;
  Uint8List? get selectedFileBytes => _selectedFileBytes;
  
  // kullanıcı yoksa uygulama null dönüp hata veriyor alttaki kod yüzünden, eğer misafir girişi olduysa bunu belirt.
  final Stream _stream =
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();

  final ImagePicker _picker = ImagePicker();
  final fieldText = TextEditingController();
  final fieldText2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var watch = ref.watch(addProfileScreenProvider);
    var read = ref.watch(addProfileScreenProvider);
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: deviceHeight / 30),
                child: Text(
                  "Create an event for the community",
                  style: kButtonTextStyle.copyWith(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth / 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: deviceHeight / 40,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: deviceWidth / 5,
                                backgroundColor: _photo == null ? kButtonColor : Colors.white,
                                child: _photo != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
                                        child: Image.file(
                                          fit: BoxFit.cover,
                                          _photo!,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(deviceWidth / 1.5)),
                                        width: deviceWidth / 2.9,
                                        height: deviceWidth / 2.9,
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight / 40,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: fieldText,
                        decoration: const InputDecoration(
                            labelText: "Event Name",
                            
                            ),
                        validator: (value) {
                          if (value!.length < 3) return "Event name should contain more thsn 3 letters";
                          return null;
                        },
                        onSaved: (data) => eventName = data,
                      ),
                      SizedBox(
                        height: deviceHeight / 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: fieldText2,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: deviceHeight / 30, horizontal: 10.0),
                            labelText: "Event Detail",
                            hintMaxLines: 8,
                            ),
                        onSaved: (data) => eventDetails = data,
                      ),
                      SizedBox(
                        height: deviceHeight / 40,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Event Date: "),
                              ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFecf4f3), // Background color
                                    foregroundColor: kThemeDarkColor, // Text Color (Foreground color)
                                  ),
                                  onPressed: () async {
                                    final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: eventDate,
                                        firstDate: eventDate.subtract(const Duration(days: 20)),
                                        lastDate: eventDate.add(const Duration(days: 30)));
                                    if (picked != null && picked != eventDate) {
                                      setState(() {
                                        eventDate = picked;
                                      });
                                    }
                                    ;
                                  },
                                  icon: const Icon(Icons.calendar_today),
                                  label: Text("${formatString(eventDate.toString())} ")),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight / 30,
                      ),
                      StreamBuilder(
                        stream: _stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final currentCity = snapshot.data!;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Şuanki konumunuz: ", style: kTitleTextStyle),
                                Text(currentCity['currentCity'],
                                    style: kTitleTextStyle.copyWith(fontWeight: FontWeight.bold))
                              ],
                            );
                          }
                          return const Text("Şuanki konumunuz belli değil! Lütfen Profilden konumunuzu belirleyin.");
                        },
                      ),
                      SizedBox(height: deviceHeight / 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFecf4f3), // Background color
                                foregroundColor: kThemeDarkColor, // Text Color (Foreground color)
                              ),
                              onPressed: () => {
                                _saveFormData(),
                                clearText(),
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Bilgi'),
                                      content: const Text('İşlem tamamlandı.'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Tamam'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              },
                              icon: const Icon(Icons.check),
                              label: const Text("Create Event"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearText() {
    fieldText.clear();

    fieldText2.clear();
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _selectedFileBytes = await pickedFile?.readAsBytes();
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        photoName = basename(_photo!.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    _selectedFileBytes = await pickedFile?.readAsBytes();
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        photoName = basename(_photo!.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Reference? uploadFile() {
    final storageRef = FirebaseStorage.instance.ref();
    if (_photo == null) return null;
    final fileName = basename(_photo!.path);
    final ref = storageRef.child(fileName);
    return ref;
  }
  
  void getUserCurrentCity() {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        city = data['currentCity'];
      },
    );
  }

  void _saveFormData() async {
    String uid = uuid.v1();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      getUserCurrentCity();
      uploadFile();
      final imageReference = uploadFile();

      if (_selectedFileBytes == null) return print("selectedfile null");

      await imageReference!.putData(_selectedFileBytes!);
      final urlPath = await imageReference.getDownloadURL();

      CollectionReference _collectionReferance = FirebaseFirestore.instance.collection("orgs");
      _collectionReferance.doc().set({
        "name": eventName,
        "details": eventDetails,
        "location": city,
        "date": eventDate,
        "photoName": urlPath,
        "eventID": uid,
      });

      List<String> idList = <String>[];
      CollectionReference _userCollectionReferance = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot<Object?> doc = await _userCollectionReferance.doc(FirebaseAuth.instance.currentUser!.uid).get();
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('eventIDS')) {
        // 'eventIDS' is already available.
        for (var element in List.from(data['eventIDS'])) {
          String data = element;
          idList.add(data);
        }
      } else {
        //is not available
        data['eventIDS'] = [];
        for (var element in List.from(data['eventIDS'])) {
          String data = element;
          idList.add(data);
        }
      }
      idList.add(uid);
      _userCollectionReferance.doc(FirebaseAuth.instance.currentUser!.uid).update({"eventIDS": idList});
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  String formatString(String text) {
    int indexOfSpace = text.indexOf(' ', 0);
    return text.substring(0, indexOfSpace);
  }
}

sandDataToDB() async {}
