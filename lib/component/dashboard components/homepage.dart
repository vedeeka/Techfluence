import 'package:flutter/material.dart';
import 'package:techfluence/component/dashboard%20components/navbar.dart';
import 'package:techfluence/component/dashboard%20components/hero.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
        appBar:  buildAppBar(context),
      
      body: const Center(
        child: InventoryHomePage(),
      ),
    );
  }
}