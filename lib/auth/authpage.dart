import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/auth/loginpage.dart';
import 'package:techfluence/component/homepage.dart';
import 'package:techfluence/data/data.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          globalEmail = FirebaseAuth.instance.currentUser!.email!;
          return Homepage();
        }
        return const LoginPage();
      },
    );
  }
}
