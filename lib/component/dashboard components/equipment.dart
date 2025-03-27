import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/pages/dashboard.dart';
import 'package:techfluence/widgets/buttons.dart';

Widget _buildSidebarItem(IconData icon, String label, {bool isActive = false}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isActive ? AppTheme.primaryColor : Colors.grey,
    ),
    title: Text(
      label,
      style: TextStyle(
        color: isActive ? AppTheme.primaryColor : Colors.grey[700],
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: () {},
    selected: isActive,
  );
}

class MachineryProductGridPage extends StatelessWidget {
  const MachineryProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Machinery Marketplace'), actions: [
        Row(
          children: [
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Page 1", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Page 2", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Page 3", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Page 4", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {},
              child:
                  const Text("Page 5", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.8,
        ),
      ]),
      body: Row(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 5.1,
            child: Column(
              children: [
                _buildSidebarItem(Icons.dashboard, 'Dashboard', isActive: true),
                _buildSidebarItem(Icons.schedule, 'Maintenance'),
                _buildSidebarItem(Icons.analytics, 'Analytics'),
                _buildSidebarItem(Icons.person, 'Profile'),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 4 / 5.1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(backendBaseString)
                  .doc(globalEmail)
                  .collection('inventory')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return const Center(
                    child: Text("No Items"),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> m = docs[index].data();
                    m['id'] = docs[index].id;
                    return _buildProductCard(context, m);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> machinery) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MachineryDetailPage(machinery: machinery)),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Icon(Icons.image)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    machinery['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(machinery['status']).withAlpha(55),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(machinery['status'],
                        style: TextStyle(
                            color: _getStatusColor(machinery['status']),
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'operational':
        return Colors.green;
      case 'under maintenance':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class MachineryDetailPage extends StatelessWidget {
  final Map<String, dynamic> machinery;

  const MachineryDetailPage({super.key, required this.machinery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 250,
            color: Colors.grey[100],
            child: Column(
              children: [
                // Logo or Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Machinery',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                // Expanded(
                //   child: ListView(
                //     padding: EdgeInsets.zero,
                //     children: [
                //       _buildNavItem(
                //         icon: Icons.dashboard,
                //         title: 'Dashboard',
                //         isSelected: true,
                //         onTap: () {},
                //       ),
                //       _buildNavItem(
                //         icon: Icons.list,
                //         title: 'Machinery List',
                //         onTap: () {},
                //       ),
                //       _buildNavItem(
                //         icon: Icons.add_circle_outline,
                //         title: 'Add Machinery',
                //         onTap: () {},
                //       ),
                //       _buildNavItem(
                //         icon: Icons.settings,
                //         title: 'Settings',
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Text(machinery['name']),
                elevation: 1,
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('image'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            machinery['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            machinery['description'],
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSpecificationTable(),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Request for quote sent')),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Request Quote'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent navigation items

  // Specification Table (assumed implementation)
  Widget _buildSpecificationTable() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow('Status', machinery['status']),
          ],
        ),
      ),
    );
  }

  // Helper method to create table rows
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
