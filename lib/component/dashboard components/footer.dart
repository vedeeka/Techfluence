import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A3B4A),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive layout for different screen sizes
              if (constraints.maxWidth > 600) {
                return _buildWideContainers();
              } else {
                return _buildNormalContainer();
              }
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 50,
            thickness: 0.5,
          ),
          const Text(
            '© 2025 InventoryPro. All rights reserved.',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWideContainers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCompanySection(),
        _buildLinkColumn('Product', ['Product', 'Features', 'Pricing', 'Demo']),
        _buildLinkColumn('Support', ['Support', 'Contact', 'Documentation', 'Status']),
        _buildLinkColumn('Company', ['About', 'Careers', 'Press']),
      ],
    );
  }

  Widget _buildNormalContainer() {
    return Column(
      children: [
        _buildCompanySection(),
        const SizedBox(height: 20),
        _buildLinkColumn('Product', ['Product', 'Features', 'Pricing', 'Demo']),
        _buildLinkColumn('Support', ['Support', 'Contact', 'Documentation', 'Status']),
        _buildLinkColumn('Company', ['About', 'Careers', 'Press']),
      ],
    );
  }

  Widget _buildCompanySection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'InventoryPro',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Simplifying inventory management\nfor businesses worldwide.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...links.map((link) => _buildFooterLink(link)),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          // TODO: Add navigation logic
          print('Navigated to $text');
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            decoration: TextDecoration.underline,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}