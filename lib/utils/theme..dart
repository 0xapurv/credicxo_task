import 'package:flutter/material.dart';
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color notWhite = Color(0xFFEDF0F2);
Color primaryColor = Colors.blue;

///+============ text styles ================================``
/*
TextStyle title = TextStyle(
  // h5 -> headline
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: Colors.white,
  letterSpacing: 0.27,
);
*/
TextStyle subtitleWhite = TextStyle(
  color: Colors.white,
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Quicksand');

TextStyle descriptionWhite =
TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Quicksand');

TextStyle title = TextStyle(
  // h5 -> headline
  fontWeight: FontWeight.bold,
  fontFamily: 'Quicksand',
  fontSize: 24,
  color: Colors.white,
  letterSpacing: 0.27,
);
TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Quicksand');

TextStyle description =
    TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Quicksand');


