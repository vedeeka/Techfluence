import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/pages/dashboard.dart' as dashboard;
import 'package:techfluence/pages/scheduler.dart' as scheduler;
import 'package:techfluence/pages/dashboard.dart';
import 'package:techfluence/component/dashboard%20components/current_jobs.dart';

Widget _buildSidebarItem(
    {required BuildContext context,
    required IconData icon,
    required Widget page,
    required String label,
    bool isActive = false}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isActive ? dashboard.AppTheme.primaryColor : Colors.grey,
    ),
    title: Text(
      label,
      style: TextStyle(
        color: isActive ? AppTheme.primaryColor : Colors.grey[700],
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    },
    selected: isActive,
  );
}

class MachineryProductGridPage extends StatelessWidget {
  const MachineryProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Machinery Marketplace'), actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.8,
        ),
      ]),
      body: Row(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width / 5.1,
            child: Column(children: [
              _buildSidebarItem(
                context: context,
                icon: Icons.dashboard,
                page: const EquipmentMaintenanceApp(),
                label: 'Dashboard',
                isActive: true,
              ),
              _buildSidebarItem(
                context: context,
                icon: Icons.list,
                page: const MachineryProductGridPage(),
                label: 'Maintenance',
              ),
              _buildSidebarItem(
                context: context,
                icon: Icons.settings,
                page: const MachineryListPage(),
                label: 'Ongoing Jobs',
              ),
              _buildSidebarItem(
                context: context,
                icon: Icons.access_time,
                page: const scheduler.SchedulerPage(),
                label: 'Schedular',
              ),
            ]),
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
                List<Map<String, dynamic>> availableItems = [];
                for (var doc in docs) {
                  if (doc.data()['status'] == 'available') {
                    var v = doc.data();
                    v['id'] = doc.id;
                    availableItems.add(v);
                  }
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 3,
                  ),
                  itemCount: availableItems.length,
                  itemBuilder: (context, index) {
                    availableItems[index]['id'] = docs[index].id;
                    return _buildProductCard(context, availableItems[index]);
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
    var container = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(machinery['status']).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        machinery['status'],
        style: TextStyle(
            color: _getStatusColor(machinery['status']),
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    flex:
                        1, // Reduced flex value for the image to balance the layout
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child: Image.network(
                          'https://t4.ftcdn.net/jpg/00/44/71/01/360_F_44710125_h5BZVCNCLcvnCVylyxhw9oHfgYTBqg6O.jpg',
                          height:
                              100, // Adjusted height to match the combined height of "Job Name" and "Job Description"
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          machinery['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          machinery['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ]),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: container,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'unavailable':
        return const Color.fromARGB(255, 255, 0, 0);
      default:
        return Colors.orange;
        
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
          padding: const EdgeInsets.symmetric(vertical: 8),
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
