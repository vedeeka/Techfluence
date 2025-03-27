import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/auth/loginpage.dart';
import 'package:techfluence/pages/dashboard.dart';
import 'package:techfluence/component/dashboard%20components/homepage.dart';
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
          return const EquipmentMaintenanceApp();
        }
        return const LoginPage();
      },
    );
  }
}
