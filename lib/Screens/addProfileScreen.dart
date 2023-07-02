import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addProfileScreen extends StatefulWidget {
  const addProfileScreen({Key? key}) : super(key: key);

  @override
  State<addProfileScreen> createState() => _addProfileScreenState();
}

class _addProfileScreenState extends State<addProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.orange,
          ),
          Center(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 1,
              width: MediaQuery.of(context).size.width / 1.1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 9),
                    Text(
                      "Profilini oluştur",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 70),
                    Container(
                      child: IconButton(
                        onPressed: () => print("Open image picker"),
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          size: 85,
                          color: Colors.orange,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 10)
                          ],
                        ),
                      ),
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.35,
                      height: MediaQuery.of(context).size.height / 13,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "İsim ve Soyisim",
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.25,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.35,
                      height: MediaQuery.of(context).size.height / 13,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Hakkında",
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.25,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.35,
                      height: MediaQuery.of(context).size.height / 13,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "İlgi Alanların",
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.25,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.35,
                      height: MediaQuery.of(context).size.height / 13,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Adresin",
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.25,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.35,
                      height: MediaQuery.of(context).size.height / 13,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Mesleğin",
                          border: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.25,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 12.5,
                        width: MediaQuery.of(context).size.width / 3.75,
                        color: Colors.orange,
                        child: TextButton(
                          child: Text(
                            "Kaydet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.5,
                            ),
                          ),
                          onPressed: () => print("kaydete basıldı"),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
