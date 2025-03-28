import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:techfluence/data/data.dart';
import 'package:techfluence/pages/dashboard.dart';
import 'package:techfluence/component/dashboard%20components/current_jobs.dart';
import 'package:techfluence/component/dashboard%20components/equipment.dart';
import 'package:techfluence/component/dashboard%20components/jobspage.dart';

class DepreciationPage extends StatefulWidget {
  const DepreciationPage({super.key});

  @override
  State<DepreciationPage> createState() => _DepreciationPageState();
}

class _DepreciationPageState extends State<DepreciationPage> {
  List<Map<String, dynamic>> items = [];

  void loadIndividual() async {
    
  }

  void loadData() async {
    items.clear();
    var v = await FirebaseFirestore.instance
        .collection(backendBaseString)
        .doc(globalEmail)
        .collection('inventory')
        .get()
        .then(
      (onValue) {
        return onValue.docs;
      },
    );
    for (var i in v) {
      Map<String, dynamic> m = i.data();
      m['id'] = i.id;
      items.add(m);
    }
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EquipmentMaintenanceApp(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.list),
                        title: const Text('Maintenance'),
                        onTap: () {
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MachineryProductGridPage(),
                            ),
                          );


                        },
                      ),
                          ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Ongoing Jobs'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MachineryListPage(),
                            ),
                          );
                        },
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
                    const Text("Depreciation "),
                    const SizedBox(width: 20),
                   
                 
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
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 300,
                          child: _buildSummaryCard(
                            title: 'Total Assets',
                            value: items.length.toString(),
                            icon: Icons.inventory,
                            color: Colors.blue[100]!,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: _buildSummaryCard(
                            title: 'Total Depreciation',
                            value: '\RS. 124,500',
                            icon: Icons.trending_down,
                            color: Colors.green[100]!,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: _buildSummaryCard(
                            title: 'Asset Value',
                            value: '\RS. 456,200',
                            icon: Icons.monetization_on,
                            color: Colors.orange[100]!,
                          ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  '\RS. 2,500',
                                  '03/15/2025',
                                ),
                                _buildDepreciationTableRow(
                                  'Company Truck',
                                  'Vehicle',
                                  '\RS. 3,200',
                                  '03/10/2025',
                                ),
                                _buildDepreciationTableRow(
                                  'Office Furniture',
                                  'Furniture',
                                  '\RS. 1,800',
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
