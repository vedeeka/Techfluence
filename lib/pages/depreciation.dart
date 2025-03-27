import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DepreciationPage extends StatelessWidget {
  const DepreciationPage({Key? key}) : super(key: key);

  // Status chip widget (helper method)
  Widget _buildStatusChip(String status) {
    Color chipColor;
    switch (status.toLowerCase()) {
      case 'active':
        chipColor = Colors.green[100]!;
        break;
      case 'pending':
        chipColor = Colors.orange[100]!;
        break;
      case 'completed':
        chipColor = Colors.blue[100]!;
        break;
      default:
        chipColor = Colors.grey[200]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                // Sidebar Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Depreciation Hub',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Sidebar Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.dashboard),
                        title: const Text('Dashboard'),
                        selected: true,
                        selectedColor: Colors.blue,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text('Asset List'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.calculate),
                        title: const Text('Depreciation Calculator'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    const Text("Depreciation Dashboard"),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Overview", 
                        style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Reports", 
                        style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Trends", 
                        style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                shadowColor: Colors.black,
                elevation: 1,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.bell_fill),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.help),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  // Depreciation Summary Cards
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryCard(
                          title: 'Total Assets',
                          value: '54',
                          icon: Icons.inventory,
                          color: Colors.blue[100]!,
                        ),
                        _buildSummaryCard(
                          title: 'Total Depreciation',
                          value: '\$124,500',
                          icon: Icons.trending_down,
                          color: Colors.green[100]!,
                        ),
                        _buildSummaryCard(
                          title: 'Asset Value',
                          value: '\$456,200',
                          icon: Icons.monetization_on,
                          color: Colors.orange[100]!,
                        ),
                      ],
                    ),
                  ),

                  // Recent Depreciation Entries
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recent Depreciation Entries',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            DataTable(
                              columns: const [
                                DataColumn(label: Text('Asset Name')),
                                DataColumn(label: Text('Category')),
                                DataColumn(label: Text('Depreciation Amount')),
                                DataColumn(label: Text('Date')),
                              ],
                              rows: [
                                _buildDepreciationTableRow(
                                  'Server Rack',
                                  'IT Equipment',
                                  '\$2,500',
                                  '03/15/2025',
                                ),
                                _buildDepreciationTableRow(
                                  'Company Truck',
                                  'Vehicle',
                                  '\$3,200',
                                  '03/10/2025',
                                ),
                                _buildDepreciationTableRow(
                                  'Office Furniture',
                                  'Furniture',
                                  '\$1,800',
                                  '03/05/2025',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Summary Card Widget
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(icon, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Depreciation Table Row Builder
  DataRow _buildDepreciationTableRow(
    String assetName, 
    String category, 
    String depreciationAmount, 
    String date,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(assetName)),
        DataCell(Text(category)),
        DataCell(Text(depreciationAmount)),
        DataCell(Text(date)),
      ],
    );
  }
}