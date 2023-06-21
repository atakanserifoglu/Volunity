import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class registerScreen extends StatefulWidget {
  static const String id = 'Register Screen';
  const registerScreen({super.key});

  @override
  State<StatefulWidget> createState() => registerScreenState();
}

class registerScreenState extends State<registerScreen> {
  bool value = false; // For checkbox
  void test_function() {
    print("FUNCTION CALL"); // test function
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevent overflow
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                "Register",
                style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 60),
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 17.5,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  TextButton(
                    onPressed: test_function,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 17.5,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 80,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      helperText: "Please enter your E-Mail address to sign up",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "E-Mail",
                      fillColor: Colors.white70),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                height: 80,
                child: TextField(
                  obscureText: true,
                  autocorrect: false,
                  autofocus: true,
                  decoration: InputDecoration(
                      helperText: "Please create a password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Password",
                      fillColor: Colors.white70),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 50),
                  Checkbox(
                    // ERROR
                    value: value,
                    activeColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        value = value!;
                      });
                    },
                  ),
                  const Text(
                    "Agree to the Terms of Use",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'DMSans',
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0XFF49F457))),
                  height: 70,
                  width: 320,
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/google_logo.png'),
                            fit: BoxFit.fill,
                          ),
                          //shape: BoxShape.circle,
                        ),
                      ),
                      TextButton(
                        onPressed: test_function,
                        child: const Text(
                          "Sign up with Google",
                          style: TextStyle(
                              fontSize: 22.5,
                              fontFamily: 'DMSans',
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: const Color(0XFF49F457),
                  height: 70,
                  width: 320,
                  child: TextButton(
                    onPressed: test_function,
                    child: const Text(
                      "Next",
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
