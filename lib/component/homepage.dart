import 'package:flutter/material.dart';
import 'package:techfluence/component/navbar.dart';
import 'package:techfluence/component/hero.dart';
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        appBar:  CustomNavbar(),
      
      body: Center(
        child: HeroWidget(),
      ),
    );
  }
}