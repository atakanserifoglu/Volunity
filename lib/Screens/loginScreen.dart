import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              SizedBox(height: 150),
              Text(
                "Log In",
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(width: 10),
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
                  SizedBox(width: 25),
                  Text(
                    'Volunity',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              SizedBox(
                width: 350,
                height: 80,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      helperText: "Please enter your registered E-Mail address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                  autofocus: true,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      helperText: "Please enter your password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Password",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    color: Colors.grey,
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
              ),
              SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.lightGreen,
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
            ],
          ),
        ),
      ),
    );
  }
}
