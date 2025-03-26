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
child: Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/heroimg.jpg'),
      fit: BoxFit.cover,
    ),
  ),
),

        ),
      
       
        
      ],
    );
  }