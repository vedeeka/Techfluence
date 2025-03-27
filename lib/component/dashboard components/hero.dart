import 'package:flutter/material.dart';
import 'package:techfluence/auth/authpage.dart';

class InventoryHomePage extends StatelessWidget {
  const InventoryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile View
              return Column(
                children: [
                  _buildHeroSection(context, isMobile: true),
                  _buildFeaturesSection(isMobile: true),
                  _buildBenefitsSection(isMobile: true),
                  _buildPricingSection(isMobile: true),
                  _buildFooter(isMobile: true),
                ],
              );
            } else {
              // Desktop View (existing code)
              return Column(
                children: [
                  _buildHeroSection(context),
                  _buildFeaturesSection(),
                  _buildBenefitsSection(),
                  _buildPricingSection(),
                  _buildFooter(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, {bool isMobile = false}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: isMobile ? 40 : 80, horizontal: isMobile ? 20 : 20),
      child: isMobile
          ? _buildMobileHeroContent(context)
          : _buildDesktopHeroContent(context),
    );
  }

  Widget _buildDesktopHeroContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildHeroTextColumn(context: context)),
        Expanded(
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/heroimg.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeroContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeroTextColumn(isMobile: true, context: context),
        _buildHeroTextColumn(isMobile: true, context: context),
        const SizedBox(height: 20),
        Container(
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/heroimg.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroTextColumn(
      {bool isMobile = false, required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Smart Inventory Management',
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A3B4A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Revolutionize your business with our cutting-edge inventory tracking solution. Real-time insights, automated alerts, and seamless integration.',
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.black87,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        isMobile
            ? Column(
                children: [
                  _buildStartFreeTrialButton(isMobile: true, context: context),
                  _buildStartFreeTrialButton(isMobile: true, context: context),
                  const SizedBox(height: 10),
                  _buildWatchDemoButton(isMobile: true),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStartFreeTrialButton(context: context),
                  const SizedBox(width: 20),
                  _buildWatchDemoButton(),
                ],
              ),
      ],
    );
  }
}

Widget _buildStartFreeTrialButton(
    {bool isMobile = false, required BuildContext context}) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthChecker()),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthChecker()),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFC9F7F7),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 30 : 40,
        vertical: isMobile ? 12 : 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Start Free Trial',
      style: TextStyle(
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildWatchDemoButton({bool isMobile = false}) {
  return OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF2B6C76),
      side: const BorderSide(
        color: Color(0xFF2B6C76),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 30 : 40,
        vertical: isMobile ? 12 : 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      'Watch Demo',
      style: TextStyle(
        fontSize: isMobile ? 14 : 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildFeaturesSection({bool isMobile = false}) {
  return Container(
    color: const Color(0xFFF5F7FA),
    padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80, horizontal: isMobile ? 10 : 20),
    child: Column(
      children: [
        Text(
          'Powerful Features',
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A3B4A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        isMobile
            ? Column(
                children: [
                  _buildFeatureCard(
                    Icons.cloud_sync,
                    'Real-time Tracking',
                    'Monitor inventory levels instantly across multiple locations.',
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureCard(
                    Icons.analytics,
                    'Advanced Analytics',
                    'Gain insights with comprehensive reporting and forecasting.',
                  ),
                  const SizedBox(height: 15),
                  _buildFeatureCard(
                    Icons.notifications,
                    'Automated Alerts',
                    'Receive instant notifications for low stock and restocking.',
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFeatureCard(
                    Icons.cloud_sync,
                    'Real-time Tracking',
                    'Monitor inventory levels instantly across multiple locations.',
                  ),
                  const SizedBox(width: 20),
                  _buildFeatureCard(
                    Icons.analytics,
                    'Advanced Analytics',
                    'Gain insights with comprehensive reporting and forecasting.',
                  ),
                  const SizedBox(width: 20),
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
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
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
          color: const Color(0xFF2B6C76),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A3B4A),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBenefitsSection({bool isMobile = false}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80, horizontal: isMobile ? 10 : 20),
    child: isMobile
        ? Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(),
              ),
              const SizedBox(height: 20),
              _buildMobileBenefitsContent(),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: Container(
                  height: 500,
                  decoration: const BoxDecoration(),
                ),
              ),
              Expanded(
                child: _buildMobileBenefitsContent(),
              ),
            ],
          ),
  );
}

Widget _buildMobileBenefitsContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Why Choose InventoryPro?',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1A3B4A),
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
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
  );
}

Widget _buildBenefitItem(String title, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xFF2B6C76),
          size: 30,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A3B4A),
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Other methods remain the same: _buildFeatureCard, _buildBenefitItem

Widget _buildPricingSection({bool isMobile = false}) {
  return Container(
    color: const Color(0xFFF5F7FA),
    padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80, horizontal: isMobile ? 10 : 20),
    child: Column(
      children: [
        Text(
          'Simple, Transparent Pricing',
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A3B4A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        isMobile
            ? Column(
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
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
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
              )
            : Row(
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
                  const SizedBox(width: 20),
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
                  const SizedBox(width: 20),
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

Widget _buildFooter({bool isMobile = false}) {
  return Container(
    color: const Color(0xFF1A3B4A),
    padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 50, horizontal: isMobile ? 10 : 20),
    child: Column(
      children: [
        isMobile ? _buildMobileFooterContent() : _buildDesktopFooterContent(),
        const Divider(
          color: Colors.white24,
          height: 30,
        ),
        Text(
          '© 2025 InventoryPro. All rights reserved.',
          style: TextStyle(
            color: Colors.white54,
            fontSize: isMobile ? 12 : 14,
          ),
          textAlign: TextAlign.center,
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
    padding: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      color: isPrimary ? const Color(0xFF2B6C76) : Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
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
            color: isPrimary ? Colors.white : const Color(0xFF1A3B4A),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          price,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: isPrimary ? Colors.white : const Color(0xFF2B6C76),
          ),
        ),
        Text(
          priceSubtitle,
          style: TextStyle(
            color: isPrimary ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: features.map((feature) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: isPrimary ? Colors.white : const Color(0xFF2B6C76),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
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
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isPrimary ? Colors.white : const Color(0xFF2B6C76),
            foregroundColor: isPrimary ? const Color(0xFF2B6C76) : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Choose Plan'),
        ),
      ],
    ),
  );
}

Widget _buildDesktopFooterContent() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Column(
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
  );
}

Widget _buildMobileFooterContent() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'InventoryPro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Simplifying inventory management for businesses worldwide.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      Wrap(
        spacing: 20,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          _buildFooterLink('Product'),
          _buildFooterLink('Features'),
          _buildFooterLink('Pricing'),
          _buildFooterLink('Support'),
          _buildFooterLink('About'),
          _buildFooterLink('Contact'),
        ],
      ),
    ],
  );
}

Widget _buildFooterLink(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
      ),
    ),
  );
}
