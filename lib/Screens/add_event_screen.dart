import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:volunity/utilities/bottom_bar.dart';
import '../utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const BottomBar(
        selectedInt: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: fieldText,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Event Name",
                    hintText: "Event Name",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                validator: (value) {
                  if (value!.length < 3)
                    return "Event name should contain more thsn 3 letters";
                  return null;
                },
                onSaved: (data) => eventName = data,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: fieldText2,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Event Detail",
                    hintText: "Event Detail",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                onSaved: (data) => eventDetails = data,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text("Selected Date: ${eventDate}"),
                  ElevatedButton.icon(
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
                      label: Text("Event Date")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton.icon(
                      onPressed: () => {
                        _saveFormData(),
                        clearText()
                      },
                      icon: Icon(Icons.check),
                      label: Text("Kaydet"),
                    ),
                  ),
                ],
              ),
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
                    radius: 55,
                    backgroundColor: Color(0xffFDCF09),
                    child: _photo != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _photo!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
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
  void _saveFormData() {
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
      });
    }
    uploadFile();
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
}

sandDataToDB() async {}

