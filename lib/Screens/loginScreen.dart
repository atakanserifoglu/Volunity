import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volunity/Screens/mainScreen.dart';

import '../utilities/constants.dart';

class loginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => loginScreenState();
}

class loginScreenState extends State<loginScreen> {
  //Test Function for Buttons
  void empty_function() {
    print("FUNCTION CALL");
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevent overflow
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height/8), //Responsive
              Text(
                "Log In",
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(height:MediaQuery.sizeOf(context).height/23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: MediaQuery.sizeOf(context).width/19),
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('Assets/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width/23),
                  Text(
                    'Volunity',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: MediaQuery.sizeOf(context).width/15),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/15),
              SizedBox(
                width: 350,
                height: 80,
                child: TextField(
                  autofocus: false, //altta misafir girişi gözükmesi için
                  decoration: InputDecoration(
                      helperText: "Please enter your password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 1, color: Colors.black)
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "E-Mail",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 80,
                child: TextField(
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      helperText: "Please enter your password",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(width: 1, color: Colors.black)
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Password",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: kButtonColor)
                  ),
                  height: 80,
                  width: 350,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/google_logo.png'),
                            fit: BoxFit.fill,
                          ),
                          //shape: BoxShape.circle,
                        ),
                      ),
                      TextButton(
                        onPressed: empty_function,
                        child: Text(
                          "Log in with Google",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: kButtonColor,
                  height: 80,
                  width: 350,
                  child: TextButton(
                    onPressed: empty_function,
                    child: Text(
                      "Log in ",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height/35),
              GestureDetector(
                onTap: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> mainScreen())); },
                child: Text("Click here to use Volunity as a guest",style: kGuestTextStyle,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
