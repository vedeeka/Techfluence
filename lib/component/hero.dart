import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: dividegrid(context),
      ),
    );
  }
}

  Widget dividegrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
          Center(
          child: Text(
            'This is a text',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Center(
          child: Image.network(
            'https://via.placeholder.com/150',
            width: 100,
            height: 100,
          ),
        ),
      
       
        
      ],
    );
  }