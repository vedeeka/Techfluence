import 'package:flutter/material.dart';

void main() => runApp(MyApp());

Widget _buildSidebarItem(IconData icon, String label, {bool isActive = false}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isActive ? Colors.lightBlueAccent : Colors.grey,
    ),
    title: Text(
      label,
      style: TextStyle(
        color: isActive ? Colors.blue : Colors.grey[700],
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    onTap: () {},
    selected: isActive,
  );
}

Widget _buildSidebar(BuildContext context) {
  return Container(
    width: 250,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Equipment Hub',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildSidebarItem(Icons.dashboard, 'Dashboard', isActive: true),
        _buildSidebarItem(Icons.schedule, 'Maintenance'),
        _buildSidebarItem(Icons.analytics, 'Analytics'),
        _buildSidebarItem(Icons.person, 'Profile'),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Equipment'),
          ),
        ),
      ],
    ),
  );
}

class _StatusCard extends StatefulWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatusCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  State<_StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<_StatusCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(widget.icon, color: widget.color, size: 36),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            Text(
              widget.value,
              style: TextStyle(
                color: widget.color,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MachineryListPage(),
    );
  }
}

Widget _buildStatusOverview() {
  return const Row(
    children: [
      Expanded(
        child: _StatusCard(
          title: 'Total Equipment',
          value: '124',
          color: Colors.blue,
          icon: Icons.devices,
        ),
      ),
      Expanded(
        child: _StatusCard(
          title: 'Maintenance Due',
          value: '12',
          color: Colors.orange,
          icon: Icons.build_circle,
        ),
      ),
      Expanded(
        child: _StatusCard(
          title: 'Critical Assets',
          value: '3',
          color: Colors.red,
          icon: Icons.warning_amber_rounded,
        ),
      ),
    ],
  );
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
      appBar: AppBar(
        title: Text('Machinery List'),
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
    );
  }
}

class MachineryDetailPage extends StatefulWidget {
  final Machinery machinery;

  const MachineryDetailPage({Key? key, required this.machinery})
      : super(key: key);

  @override
  State<MachineryDetailPage> createState() => _MachineryDetailPageState();
}

class _MachineryDetailPageState extends State<MachineryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machinery.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${widget.machinery.id}'),
            Text('Name: ${widget.machinery.name}'),
            Text('Model: ${widget.machinery.model}'),
            Text('Status: ${widget.machinery.status}'),
          ],
        ),
      ),
    );
  }
}