import 'package:flutter/material.dart';

// ignore: unused_element
Widget _buildIllustrationSection(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE6F2F5),
          Color(0xFFC7E0E6),
        ],
      ),
    ),
    child: Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Clipboard and Checklist
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            child: Container(
              width: 280,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.checklist, size: 80, color: Color(0xFF2B6C76)),
                  SizedBox(height: 20),
                  Text(
                    'Inventory Tracking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A3B4A),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Real-time stock monitoring and automated alerts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5A6B7C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Warehouse Workers illustration would ideally be a custom SVG/asset
          const Positioned(
            bottom: 50,
            child: Text(
              '🏭 Smart Inventory Solutions',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF2B6C76),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
