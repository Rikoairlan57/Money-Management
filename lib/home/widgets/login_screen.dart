import 'package:flutter/material.dart';
import 'package:money_management/screens/basescreen/decoration.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_management/home/widgets/setup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 233, 252),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            child: Image.asset('assets/image/icon.png'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30, left: 15),
            child: textBig(
                text: "money",
                color: Colors.purple,
                weight: FontWeight.w900,
                size: 70),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: botton(
                onPressed: () async {
                  if (nameController.text == '') {
                    final snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Sorry....',
                        message: 'Please enter your name',
                        contentType: ContentType.help,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  } else {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    await sharedPreferences.setString(
                        'nameKey', nameController.text);

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Setup();
                        },
                      ),
                    );
                  }
                },
                titel: "Login"),
          )
        ],
      )),
    );
  }
}