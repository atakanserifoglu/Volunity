import 'package:flutter/material.dart';


const kButtonColor = Color(0XFF49F457);


const kButtonTextStyle = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 40.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const kButtonTextStyleSmall = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 22.0,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

const kGuestTextStyle = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 14.0,
  decoration: TextDecoration.underline,
  color: Colors.black54,
  fontWeight: FontWeight.w500,
);
const kTitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const kTitleStyle = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 40.0,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);
const kCardTitleStyle = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 27.0,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

var kButtonStyle = ButtonStyle(
    shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)
        )
    )
);