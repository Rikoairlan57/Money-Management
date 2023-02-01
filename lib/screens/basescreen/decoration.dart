import 'package:flutter/material.dart';

Widget textBig(
    {required String text,
    double size = 60,
    FontWeight weight = FontWeight.w700,
    Color color = Colors.white}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: weight),
  );
}
