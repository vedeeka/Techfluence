import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
      appBar: AppBar(
        title: const Text('Machinery List'),
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
