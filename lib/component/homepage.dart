import 'package:flutter/material.dart';
import 'package:techfluence/component/navbar.dart';
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        appBar:  CustomNavbar(),
      
      body: const Center(
        child: Text('Welcome to Equipment Maintenance App'),
      ),
    );
  }
}