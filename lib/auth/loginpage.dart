import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/widgets/buttons.dart';
import 'package:techfluence/widgets/textfields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController(), password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              c: email,
              hint: "Email",
              prefix: Icon(Icons.email),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyTextField(
              c: password,
              hint: "password",
              visible: false,
            ),
          ),
          MyButton(
              f: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text.trim(),
                  password: password.text.trim(),
                );
                globalEmail = email.text.toLowerCase().trim();
              },
              text: "login")
        ],
      ),
    );
  }
}
