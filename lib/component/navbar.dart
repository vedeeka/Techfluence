import 'package:flutter/material.dart';

PreferredSizeWidget buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        Text(
          'InventoryPro',
          style: TextStyle(
            color: Color(0xFF2B6C76),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {},
        child: Text('Features', style: TextStyle(color: Colors.black87)),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Pricing', style: TextStyle(color: Colors.black87)),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2B6C76),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('Get Started'),
      ),
      SizedBox(width: 16),
    ],
  );
}
