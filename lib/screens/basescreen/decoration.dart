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

Widget textBigB(
    {required String text,
    double size = 30,
    FontWeight weight = FontWeight.w700,
    TextAlign align = TextAlign.center}) {
  return Text(text,
      textAlign: align,
      style: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: weight,
      ));
}

Widget textBigG({
  required String text,
  Color color = const Color.fromARGB(255, 196, 195, 195),
  double size = 15,
  FontWeight weight = FontWeight.w700,
  TextAlign align = TextAlign.center,
}) {
  return Text(
    text,
    textAlign: align,
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
