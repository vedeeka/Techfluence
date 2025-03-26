import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/logo.png', // Replace with your actual logo
        height: 40,
        fit: BoxFit.contain,
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      foregroundColor: Colors.black,
      centerTitle: false,
      actions: [
        _buildNavbarItem(context, 'Home', '/'),
        _buildNavbarItem(context, 'New', '/new'),
        _buildNavbarItem(context, 'Trend', '/trend'),
        _buildNavbarItem(context, 'Company', '/company'),
        _buildNavbarItem(context, 'Collections', '/collections'),
        _buildNavbarItem(context, 'Blog', '/blog'),
      ],
    );
  }

  Widget _buildNavbarItem(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      child: Text(text),
    );
  }


  
}