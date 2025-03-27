import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MachineryListPage(),
    );
  }
}

class Machinery {
  final String id;
  final String name;
  final String model;
  final String status;

  Machinery({
    required this.id,
    required this.name,
    required this.model,
    required this.status,
  });
}

class MachineryListPage extends StatefulWidget {
  const MachineryListPage({super.key});

  @override
  State<MachineryListPage> createState() => _MachineryListPageState();
}

class _MachineryListPageState extends State<MachineryListPage> {
  final List<Machinery> _machineryList = [
    Machinery(
      id: 'M001',
      name: 'CNC Milling Machine',
      model: 'XR-500',
      status: 'Operational',
    ),
    Machinery(
      id: 'M002',
      name: 'Lathe Machine',
      model: 'TK-300',
      status: 'Under Maintenance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Permanent Sidebar
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
                        'Equipment Hub',
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
                        title: const Text('Machinery List'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text('Add Machinery'),
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
              appBar:AppBar(
                    title: Row(
                      children: [
                        const Text("Dashboard"),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 1",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 2",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 3",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 4",
                              style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Page 5",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    shadowColor: Colors.black,
                    elevation: 1,
                    actions: [
                      Container(
                        height: double.infinity,
                        width: 350,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: TextField(
                            
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search",
                            ),
                          ),
                        ),
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
              body: ListView.builder(
                itemCount: _machineryList.length,
                itemBuilder: (context, index) {
                  final machinery = _machineryList[index];
                  return ListTile(
                    title: Text(machinery.name),
                    subtitle: Text(machinery.model),
                    trailing: Text(
                      machinery.status,
                      style: TextStyle(
                        color: machinery.status == 'Operational'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MachineryDetailPage(machinery: machinery),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MachineryDetailPage extends StatefulWidget {
  final Machinery machinery;

  const MachineryDetailPage({super.key, required this.machinery});

  @override
  State<MachineryDetailPage> createState() => _MachineryDetailPageState();
}



class _MachineryDetailPageState extends State<MachineryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machinery.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editMachinery,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Machine Overview Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        icon: Icons.numbers,
                        label: 'Machine ID',
                        value: widget.machinery.id,
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        icon: Icons.engineering,
                        label: 'Model',
                        value: widget.machinery.model,
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        icon: Icons.power,
                        label: 'Status',
                        value: widget.machinery.status,
                        valueColor: widget.machinery.status == 'Operational'
                            ? Colors.green
                            : Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Additional Details Section
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoTile(
                        title: 'Last Maintenance',
                        subtitle: 'June 15, 2024',
                        icon: Icons.build_circle,
                      ),
                      const Divider(),
                      _buildInfoTile(
                        title: 'Next Scheduled Maintenance',
                        subtitle: 'December 15, 2024',
                        icon: Icons.calendar_today,
                      ),
                      const Divider(),
                      _buildInfoTile(
                        title: 'Total Operating Hours',
                        subtitle: '1,245 hours',
                        icon: Icons.timer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reportIssue,
        backgroundColor: Colors.red[600],
        child: const Icon(Icons.report_problem),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }

  void _editMachinery() {
    // TODO: Implement edit machinery functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit Machinery feature coming soon')),
    );
  }

  void _reportIssue() {
    // TODO: Implement issue reporting functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report an Issue'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Describe the issue with the machinery',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Submit issue logic
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Issue reported successfully')),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}