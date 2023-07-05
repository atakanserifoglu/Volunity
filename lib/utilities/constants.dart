import 'package:flutter/material.dart';

const kButtonColor = Color.fromARGB(255, 153, 220, 151);
const kThemeDarkColor = Color(0xFF367465);
const kThemeColor = Color(0xFFBBDEBA);
const kButtonSecondColor=  Color.fromRGBO(240, 240, 240, 0.95);

const List<String> cities = [
  'None',
  'Adana',
  'Adıyaman',
  'Afyonkarahisar',
  'Ağrı',
  'Amasya',
  'Ankara',
  'Antalya',
  'Artvin',
  'Aydın',
  'Balıkesir',
  'Bilecik',
  'Bingöl',
  'Bitlis',
  'Bolu',
  'Burdur',
  'Bursa',
  'Çanakkale',
  'Çankırı',
  'Çorum',
  'Denizli',
  'Diyarbakır',
  'Edirne',
  'Elazığ',
  'Erzincan',
  'Erzurum',
  'Eskişehir',
  'Gaziantep',
  'Giresun',
  'Gümüşhane',
  'Hakkâri',
  'Hatay',
  'Isparta',
  'Mersin',
  'İstanbul',
  'İzmir',
  'Kars',
  'Kastamonu',
  'Kayseri',
  'Kırklareli',
  'Kırşehir',
  'Kocaeli',
  'Konya',
  'Kütahya',
  'Malatya',
  'Manisa',
  'Kahramanmaraş',
  'Mardin',
  'Muğla',
  'Muş',
  'Nevşehir',
  'Niğde',
  'Ordu',
  'Rize',
  'Sakarya',
  'Samsun',
  'Siirt',
  'Sinop',
  'Sivas',
  'Tekirdağ',
  'Tokat',
  'Trabzon',
  'Tunceli',
  'Şanlıurfa',
  'Uşak',
  'Van',
  'Yozgat',
  'Zonguldak',
  'Aksaray',
  'Bayburt',
  'Karaman',
  'Kırıkkale',
  'Batman',
  'Şırnak',
  'Bartın',
  'Ardahan',
  'Iğdır',
  'Yalova',
  'Karabük',
  'Kilis',
  'Osmaniye',
  'Düzce',
];

const kButtonTextStyle = TextStyle(
  fontFamily: 'DMSans',
  fontSize: 40.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const kVolunityText =
    TextStyle(fontFamily: 'DMSans', fontWeight: FontWeight.w400, color: Color(0xFF367465), fontSize: 48, height: 0);

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
  fontFamily: 'DMSans',
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
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.black))));
