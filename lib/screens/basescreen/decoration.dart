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

Widget botton(
    {required void Function() onPressed,
    required String titel,
    Color color = Colors.purple}) {
  return Padding(
    padding: const EdgeInsets.only(top: 50),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(titel),
    ),
  );
}
