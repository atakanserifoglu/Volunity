import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
class AddEvent extends StatefulWidget {
  static const String id = 'Add Event Screen';

  AddEvent({super.key});

  @override
  _AddEvent createState() => _AddEvent();
}

class _AddEvent extends State<AddEvent> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String? eventName, eventDetails;
  String? _textName = "", _textDetails = "";
  DateTime eventDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  File? _photo;
  String? photoName = "";
  final ImagePicker _picker = ImagePicker();
  final fieldText = TextEditingController();
  final fieldText2 = TextEditingController();




  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.sizeOf(context).height;
    final double deviceWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const BottomBar(
        selectedInt: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("Create an event for the community",style: kButtonTextStyle.copyWith(fontSize: 25),textAlign: TextAlign.center,),
            Form(
              key: formKey,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: deviceWidth/25),
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: CircleAvatar(
                              radius: deviceWidth/5,
                              backgroundColor: _photo == null
                                  ? kButtonColor : Colors.white,
                              child: _photo != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _photo!,
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(deviceWidth/1.5)),
                                width: deviceWidth/2.9,
                                height: deviceWidth/2.9,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: deviceHeight/40,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: fieldText,
                      decoration: InputDecoration(
                          labelText: "Event Name",
                          hintText: "Event Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: kButtonColor))),
                      validator: (value) {
                        if (value!.length < 3)
                          return "Event name should contain more thsn 3 letters";
                        return null;
                      },
                      onSaved: (data) => eventName = data,
                    ),
                    SizedBox(
                      height: deviceHeight/30,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: fieldText2,
                      maxLines: null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                          labelText: "Event Detail",
                          hintMaxLines: 8,
                          hintText: "Event Detail",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: kButtonColor))),
                      onSaved: (data) => eventDetails = data,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Event Date: "),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54, // Background color
                                  foregroundColor: kButtonColor, // Text Color (Foreground color)
                                ),
                                  onPressed: () async {
                                    final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: eventDate,
                                        firstDate: eventDate.subtract(Duration(days: 20)),
                                        lastDate: eventDate.add(Duration(days: 30)));
                                    if (picked != null && picked != eventDate) {
                                      setState(() {
                                        eventDate = picked;
                                      });
                                    }
                                    ;
                                  },
                                  icon: Icon(Icons.calendar_today),
                                  label: Text("${formatString(eventDate.toString())} ")),
                            ],
                          ),
                        )


                      ],
                    ),
                    SizedBox(height: deviceHeight/25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54, // Background color
                              foregroundColor: kButtonColor, // Text Color (Foreground color)
                            ),
                            onPressed: () => {
                              _saveFormData(),
                              clearText()
                            },
                            icon: Icon(Icons.check),
                            label: Text("Create Event"),
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
    );
  }

  void clearText() {
    fieldText.clear();
    fieldText2.clear();
  }
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

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

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        photoName = basename(_photo!.path);

      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(fileName);
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }
  void _saveFormData() async{
    String uid = uuid.v1();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        _textName = eventName;
        _textDetails = eventDetails;
      });
      CollectionReference _collectionReferance =
          FirebaseFirestore.instance.collection("orgs");
      _collectionReferance.doc().set({
        "name": eventName,
        "details": eventDetails,
        "date": eventDate,
        "photoName": photoName,
        "eventID" : uid,
      });
    }

    List<String> idList = <String>[];
    CollectionReference _userCollectionReferance =
    FirebaseFirestore.instance.collection("users");

    DocumentSnapshot<Object?>  doc = await _userCollectionReferance.doc(FirebaseAuth.instance.currentUser!.uid).get();
            final data = doc.data() as Map<String, dynamic>;
            List.from(data['eventIDS']).forEach((element) {
              String data = element;
              idList.add(data);
            },
            );

    idList.add(uid);
    _userCollectionReferance.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "eventIDS" : idList
    });

    uploadFile();
    print(FirebaseAuth.instance.currentUser);
    print("object");
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
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
  String formatString(String text){
    int indexOfSpace = text.indexOf(' ', 0);
    return text.substring(0, indexOfSpace);
  }
}

sandDataToDB() async {}

