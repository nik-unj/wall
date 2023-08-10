import 'package:flutter/material.dart';

class CustomStyle {
  static TextStyle blackConcertBold(double size) {
    return TextStyle(
        fontSize: size, fontFamily: 'concertOne', fontWeight: FontWeight.bold);
  }

  static TextStyle blackConcer(double size) {
    return TextStyle(fontSize: size, fontFamily: 'concertOne');
  }

  static TextStyle blackOswaldBold(double size) {
    return TextStyle(
        fontSize: size, fontFamily: 'oswald', fontWeight: FontWeight.bold);
  }

  static TextStyle blackOswald(double size) {
    return TextStyle(fontSize: size, fontFamily: 'oswald');
  }

  static TextStyle blackNeueBold(double size) {
    return TextStyle(
        fontSize: size, fontFamily: 'bebasNeue', fontWeight: FontWeight.bold);
  }

  static TextStyle blackNeue(double size) {
    return TextStyle(fontSize: size, fontFamily: 'bebasNeue');
  }

  static Color whitebg() {
    return const Color(0xffFFFFFF);
  }

  static Color white2bg() {
    return const Color(0xffECEEF1);
  }
}
