import 'package:flutter/material.dart';
import 'package:techfluence/auth/authpage.dart';

PreferredSizeWidget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: _buildAppBarTitle(),
    actions: _buildAppBarActions(context),
  );
}

Widget _buildAppBarTitle() {
  return const Row(
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
  );
}

List<Widget> _buildAppBarActions(BuildContext context) {
  // Check if the screen is mobile
  bool isMobile = MediaQuery.of(context).size.width < 600;

  // If mobile, return a menu icon
  if (isMobile) {
    return [
      IconButton(
        icon: const Icon(Icons.menu, color: Colors.black87),
        onPressed: () {
          _showMobileMenu(context);
        },
      ),
    ];
  }

  // Desktop actions
  return [
    TextButton(
      onPressed: () {},
      child: const Text('Features', style: TextStyle(color: Colors.black87)),
    ),
    TextButton(
      onPressed: () {},
      child: const Text('Pricing', style: TextStyle(color: Colors.black87)),
    ),
    ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthChecker()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC9F7F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    const SizedBox(width: 16),
  ];
}

void _showMobileMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileMenuButton('Features', context),
            _buildMobileMenuButton('Pricing', context),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2B6C76),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Get Started'),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildMobileMenuButton(String text, BuildContext context) {
  return ListTile(
    title: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black87),
    ),
    onTap: () {
      Navigator.pop(context);
      // Add navigation or action for the specific menu item
    },
  );
}
