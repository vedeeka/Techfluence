import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
Scaffold(
  body: Center(
    child: Container(
      constraints: BoxConstraints(maxWidth: 600),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'INVENTORY MANAGEMENT',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2B6C76), // Matching the teal color from the image
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, nonummy euismo dolore magna aliquam erat volutpat.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // Add your navigation or action here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2B6C76), // Matching the teal color
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'GET STARTED',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
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