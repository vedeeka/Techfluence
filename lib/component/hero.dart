import 'package:flutter/material.dart';

class InventoryHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturesSection(),
            _buildBenefitsSection(),
            _buildPricingSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Inventory Management',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A3B4A),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Revolutionize your business with our cutting-edge inventory tracking solution. Real-time insights, automated alerts, and seamless integration.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2B6C76),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Start Free Trial',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF2B6C76),
                        side: BorderSide(
                          color: Color(0xFF2B6C76),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Watch Demo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Image Column
          Expanded(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/heroimg.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      color: Color(0xFFF5F7FA),
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Powerful Features',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A3B4A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureCard(
                Icons.cloud_sync,
                'Real-time Tracking',
                'Monitor inventory levels instantly across multiple locations.',
              ),
              SizedBox(width: 20),
              _buildFeatureCard(
                Icons.analytics,
                'Advanced Analytics',
                'Gain insights with comprehensive reporting and forecasting.',
              ),
              SizedBox(width: 20),
              _buildFeatureCard(
                Icons.notifications,
                'Automated Alerts',
                'Receive instant notifications for low stock and restocking.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 60,
            color: Color(0xFF2B6C76),
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A3B4A),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/benefits_illustration.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why Choose InventoryPro?',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A3B4A),
                  ),
                ),
                SizedBox(height: 20),
                _buildBenefitItem(
                  'Seamless Integration',
                  'Connect with your existing systems effortlessly.',
                ),
                _buildBenefitItem(
                  'Cost Reduction',
                  'Minimize waste and optimize inventory levels.',
                ),
                _buildBenefitItem(
                  'Scalable Solution',
                  'Perfect for businesses of all sizes and industries.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Color(0xFF2B6C76),
            size: 30,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3B4A),
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      color: Color(0xFFF5F7FA),
      padding: EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Simple, Transparent Pricing',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A3B4A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPricingCard(
                'Starter',
                '\$29',
                'Per Month',
                [
                  'Up to 100 Products',
                  'Basic Reporting',
                  'Email Support',
                ],
              ),
              SizedBox(width: 20),
              _buildPricingCard(
                'Professional',
                '\$99',
                'Per Month',
                [
                  'Unlimited Products',
                  'Advanced Analytics',
                  'Priority Support',
                  'Multiple Location Tracking',
                ],
                isPrimary: true,
              ),
              SizedBox(width: 20),
              _buildPricingCard(
                'Enterprise',
                'Custom',
                'Pricing',
                [
                  'Fully Customized Solution',
                  '24/7 Dedicated Support',
                  'Unlimited Integrations',
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(
    String title,
    String price,
    String priceSubtitle,
    List<String> features, {
    bool isPrimary = false,
  }) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isPrimary ? Color(0xFF2B6C76) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isPrimary ? Colors.white : Color(0xFF1A3B4A),
            ),
          ),
          SizedBox(height: 20),
          Text(
            price,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: isPrimary ? Colors.white : Color(0xFF2B6C76),
            ),
          ),
          Text(
            priceSubtitle,
            style: TextStyle(
              color: isPrimary ? Colors.white70 : Colors.black54,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: features.map((feature) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: isPrimary ? Colors.white : Color(0xFF2B6C76),
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      feature,
                      style: TextStyle(
                        color: isPrimary ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPrimary ? Colors.white : Color(0xFF2B6C76),
              foregroundColor: isPrimary ? Color(0xFF2B6C76) : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text('Choose Plan'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Color(0xFF1A3B4A),
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
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
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLink('Product'),
                  _buildFooterLink('Features'),
                  _buildFooterLink('Pricing'),
                  _buildFooterLink('Demo'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLink('Support'),
                  _buildFooterLink('Contact'),
                  _buildFooterLink('Documentation'),
                  _buildFooterLink('Status'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFooterLink('Company'),
                  _buildFooterLink('About'),
                  _buildFooterLink('Careers'),
                  _buildFooterLink('Press'),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.white24,
            height: 50,
          ),
          Text(
            '© 2025 InventoryPro. All rights reserved.',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}